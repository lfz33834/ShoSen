//
//  SSJPushTool.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/8.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSJPushTool : NSObject


@property(nonatomic,assign)int unReadCount; //app的未读消息数

+ (instancetype)share;

- (void)resetBadgeNum;

- (void)registerForRemoteNotifications;//注册APNS

- (void)registJpush:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;//注册JPush

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;//注册成功

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;//注册失败

//7.0-10.0 收到远程推送
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

//7.0-10.0本地推送
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)setTagAndAlias:(id)profile;

@end
