//
//  SSPayTool.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/28.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <AlipaySDK/AlipaySDK.h>


typedef void(^payToolsBlock)(id obj);
typedef void(^payBackeBlock)(id obj);


@interface SSPayTool : NSObject

//支付授权回调
@property(nonatomic, copy)payToolsBlock toolBlock;
@property(nonatomic, copy)payBackeBlock block;

+ (instancetype)share;

- (void)initWechat;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

- (void)processAuthResult:(NSURL *)resultUrl standbyCallback:(CompletionBlock)completionBlock;
//微信授权
- (void)weixinAuth:(payToolsBlock)block;
//支付宝
- (void)aliPayAuth:(payToolsBlock)block;
//微信支付
- (void)weixinPay:(NSDictionary *)paramDic result:(payToolsBlock)block;
//支付宝支付
- (void)aliPay:(NSString *)paramStr result:(payToolsBlock)block;
//微信接口
- (void)wechatPayWithID:(NSString *)bookID;
//支付宝接口
- (void)aliPayWithID:(NSString *)bookID;
//微信充值
- (void)wechatRechargeWithOrderNo:(NSString *)orderNo;
//支付宝充值
- (void)aliRechargeWithOrderNo:(NSString *)orderNo;

- (void)getAuthWithUserInfoFromWechat:(UIViewController *)shareVC callBack:(void(^)(NSDictionary *dicData))block;
@end
