//
//  AppDelegate.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "AppDelegate.h"
#import "FZNavigationController.h"
#import "FZMainTabBarController.h"
#import <WXApi.h>
#import "SSUMShareTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self feltBaseConfig];
    [[SSPayTool share]initWechat];
    [[SSUMShareTool share]UMShare];
    [[SSLocationTool share]startLocation];
    [[SSJPushTool share] registJpush:application didFinishLaunchingWithOptions:launchOptions];

    FZMainTabBarController *nav =  [[FZMainTabBarController alloc]init];
    UIWindow *window                    = [[UIApplication sharedApplication].delegate window];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
    
    
    
    NSLog(@"a");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"b");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"c");
        });
        NSLog(@"4");
    });
    NSLog(@"d");

    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    [[SSPayTool share]application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    [[SSPayTool share]application:app openURL:url options:options];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
   return [[SSUMShareTool share]application:application handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[SSJPushTool share]resetBadgeNum];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[SSJPushTool share]resetBadgeNum];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[SSJPushTool share]resetBadgeNum];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[SSJPushTool share]application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[SSJPushTool share]application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[SSJPushTool share] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [[SSJPushTool share]application:application didReceiveLocalNotification:notification];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;



#pragma mark - Core Data Saving support

- (void)feltBaseConfig
{
    [FZHttpTool get:BaseConfigUrl parameters:nil isShowHUD:YES httpToolSuccess:^(id json) {
        [[NSUserDefaults standardUserDefaults]setObject:json[@"data"][@"bookMoney"] forKey:KConfigNoticeKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } failure:^(NSError *error) {
     }];
    
    
    [FZHttpTool get:BaseRemainOwner parameters:nil isShowHUD:YES httpToolSuccess:^(id json) {
        NSString *num = [NSString stringWithFormat:@"%@",json[@"data"][@"remainNum"]];
        [[NSUserDefaults standardUserDefaults]setObject:num forKey:KConfigRemainNumKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } failure:^(NSError *error) {
        
     }];
    
    
    [FZHttpTool get:UserLocationData parameters:nil isShowHUD:YES httpToolSuccess:^(id json) {
        NSArray *location_array = json[@"data"];
        [[NSUserDefaults standardUserDefaults]setObject:location_array forKey:KLocationData];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } failure:^(NSError *error) {
        
    }];
    
    [FZHttpTool get:[NSString stringWithFormat:@"%@/base/dictionary?type=19",BaseUrl] parameters:nil isShowHUD:YES httpToolSuccess:^(id json) {
        NSDictionary *dicData = json[@"data"][0];
        NSString *numString = [NSString stringWithFormat:@"%@",dicData[@"dicValue"]];
        NSString *num = [NSString stringWithFormat:@"%@",numString];
        [[NSUserDefaults standardUserDefaults]setObject:num forKey:KIsReview];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } failure:^(NSError *error) {
        
    }];
}


- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
