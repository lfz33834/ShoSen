//
//  FZWebViewController.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/5.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"
#import "FZJavaScriptRootModel.h"

@interface FZWebViewController : FZBaseViewController

//超时
@property(nonatomic, readonly)float timeout;
//请求地址
@property(nonatomic, copy)NSString * loadUrl;
//网页
@property(nonatomic, strong)UIWebView * webView;
//js上下文
@property(nonatomic, strong)JSContext * jsContext;
//jsModel
@property(nonatomic, strong)FZJavaScriptRootModel * jsModel;
 
@end
