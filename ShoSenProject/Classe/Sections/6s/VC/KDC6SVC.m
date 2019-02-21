//
//  KDC6SVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "KDC6SVC.h"

@interface KDC6SVC ()

@end

@implementation KDC6SVC

- (void)viewDidLoad {
    [super viewDidLoad];

 
    //1. 建立UIScrollView窗口，我们只打算用手机的上半屏显示图像，(这一步也可以在storyboard里完成)
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kwidth , kheight - 49 - kTopHeight)];
    //2.建立内容视图
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"6s_bg"]];
    
    UIButton *one_button = [UIButton buttonWithType:UIButtonTypeCustom];
    one_button.frame = CGRectMake(10, 1390 , 140, 170);
    one_button.backgroundColor = [UIColor clearColor];
    [one_button addTarget:self action:@selector(oneButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:one_button];
    
    
    UIButton *two_button = [UIButton buttonWithType:UIButtonTypeCustom];
    two_button.frame = CGRectMake(kwidth - 10 - 140 - 15, 1390 , 140, 170);
    two_button.backgroundColor = [UIColor clearColor];
    [two_button addTarget:self action:@selector(twoButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:two_button];
    
    bg.frame = CGRectMake(0, 0, kwidth, 1600);    //3.将内容视图作为scrollView的子视图
    [scrollview addSubview: bg];
    //4.当然了，还得把scrollView添加到视图结构中
    [self.view addSubview: scrollview];
    scrollview.contentSize = bg.bounds.size;
}

- (void)oneButtonTapAction
{
    FZWebViewController *webview = [[FZWebViewController alloc]init];
    webview.title = @"让天下没有难务之商";
    webview.loadUrl = @"https://mp.weixin.qq.com/s/dPpdgTCpQQRbziVVDqloHQ";
    [self.navigationController pushViewController:webview animated:YES];
 }

- (void)twoButtonTapAction
{
    FZWebViewController *webview = [[FZWebViewController alloc]init];
    webview.title = @"6s汽车馆功能";
    webview.loadUrl = @"https://mp.weixin.qq.com/s/fSyo96xIXwGzsHguZSb2Mg";
    [self.navigationController pushViewController:webview animated:YES];
}

@end
