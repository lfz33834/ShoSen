//
//  FZJavaScriptRootModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/5.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol XBJavaScriptProtocol <JSExport>
- (void)showMessage:(NSString *)paramStr;

- (void)getCommonParams;
@end
@interface FZJavaScriptRootModel : NSObject<XBJavaScriptProtocol>
//当前controller
@property(nonatomic,weak)UIViewController * controller;
//js上下文
@property(nonatomic,weak)JSContext * jsContext;
@end
