//
//  SSUMShareTool.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSUMShareTool.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import <WXApi.h>

static SSUMShareTool * handler = nil;

@implementation SSUMShareTool


+(SSUMShareTool *)share{
    static SSUMShareTool *shareInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstace=[[SSUMShareTool alloc] init];
    });
    return shareInstace;
}

-(void)UMShare
{
    //设置友盟社会化组件appkey
    [UMConfigure initWithAppkey:UMengKey channel:@"App Store"];
    //开发者需要显式的调用此函数，日志系统才能工作
//    [UMCommonLogManager setUpUMCommonLogManager];
//    [UMConfigure setLogEnabled:YES];
     //设置微信AppId、appSecret，分享url
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWechatAppID appSecret:kWechatAppSecret redirectURL:@"http://mobile.umeng.com/social"];
  }

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
