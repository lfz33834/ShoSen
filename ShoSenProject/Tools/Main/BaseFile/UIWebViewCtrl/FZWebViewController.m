//
//  FZWebViewController.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/5.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZWebViewController.h"

@interface FZWebViewController ()<UIWebViewDelegate>

@end

@implementation FZWebViewController

-(float)timeout
{
    return 10.0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.jsModel = [[FZJavaScriptRootModel alloc]init];
    CGRect paramRect = CGRectZero;
//    if (iPhoneX) {
//        paramRect = CGRectMake(0.0f, kTopHeight, kwidth, kheight - kStatusAdd);
//    }else{
        paramRect = CGRectMake(0.0f, 0, kwidth, kheight - 50);
//    }
    self.webView = [[UIWebView alloc] initWithFrame:paramRect];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
//    [self InjectJavaScriptFunc:self.webView];
    [self cleanCacheAndCookie];
//    [self registerUserAgent];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.loadUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:self.timeout];
    [self.webView loadRequest:request];
    

}

//点击返回的方法
- (void)backNative
{

}


- (void)backAction
{
    UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(goToLast) icon:@"home_left_arrow" highlightedIcon:@"home_left_arrow"];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)goToLast
{
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    //判断是否有上一层H5页面
    if ([self.webView canGoBack]) {
        //如果有则返回
        [self.webView goBack];
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
    }
    else if(index != 0 && ![self.webView canGoBack]){
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self setLeftItemNull];
    }
}

#pragma mark -- delegate --
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    if ([request.URL.absoluteString hasPrefix:@"https://mp.weixin.qq.com/s"] && [self.loadUrl hasPrefix:@"https://api.shosen.cn/"] ) {
//        FZWebViewController *webVC = [[FZWebViewController alloc]init];
//        webVC.loadUrl = request.URL.absoluteString;
//        [self.navigationController pushViewController:webVC animated:YES];
//    }

    return YES;
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    if ([self.webView canGoBack] || index != 0) {
        [self backAction];
    }else{
        [self setLeftItemNull];
    }
    
    if (([self.webView canGoBack] && index == 0) || index != 0) {
        self.tabBarController.tabBar.hidden=YES;
    }else{
        self.tabBarController.tabBar.hidden=NO;
    }
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
-(void)InjectJavaScriptFunc:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsModel.controller = self;
    self.jsModel.jsContext = self.jsContext;
    //将SwiftJavaScriptRootModel模型注入到JS中，在JS就可以通过WebJSBridge调用我们暴露的方法了。
    self.jsContext[@"JSObject"] = self.jsModel;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
    };
}
-(void)callJs:(NSString *)funcName dict:(NSDictionary *)paramDic
{
    NSString * jsString = @"";
    if (paramDic) {
//        NSString * paramStr = [paramDic ];
//        jsString = [NSString stringWithFormat:@"\(%@)(\%@)",funcName,paramStr];
    }else{
        jsString = [NSString stringWithFormat:@"\(%@)()",funcName];
    }
    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
}
-(void)callFunJs:(NSString *)jsString
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView stringByEvaluatingJavaScriptFromString:jsString];
    });
}

/*
 *获取 UIWebview 的 Useragent，以及附加自定义字段到 Useragent
 */
-(void)registerUserAgent{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        NSString *newUagent = [NSString stringWithFormat:@"%@ %@/%@",secretAgent,@"",@""];
        NSDictionary *dictionary = [[NSDictionary alloc]
                                    initWithObjectsAndKeys:newUagent, @"UserAgent",nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    });
}

- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

- (void)destroyWebview
{
    self.webView.delegate = nil;
    [self.webView removeFromSuperview];
    self.webView = nil;
}
-(void)dealloc
{
    [self destroyWebview];
}

@end
