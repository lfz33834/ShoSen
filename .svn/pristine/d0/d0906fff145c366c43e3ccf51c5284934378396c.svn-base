//
//  FZRouteUrlTool.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZRouteUrlTool.h"

@implementation FZRouteUrlTool

static FZRouteUrlTool * handler = nil;
+(instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[FZRouteUrlTool alloc]init];
    });
    return handler;
}

-(void)setupAppRootCtrl:(UIViewController *)rootVC
{
    UIViewController *windowRootCtrl = nil;
    windowRootCtrl = rootVC;

//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"first"]) {
//        WCUserModel *model = [WCUserTool sharedWCUserTool].userInfo;
//        if (model) {
//
//        }else{
//            windowRootCtrl = [self loginCtrl];
//        }
//    }else{
//        windowRootCtrl = [self guideCtrl];
//    }
    if (windowRootCtrl){
        UIWindow *window = ((AppDelegate *)([UIApplication sharedApplication].delegate)).window;
        UIView *lastView = window.rootViewController.view;
        UIView *newView = windowRootCtrl.view;
        [UIView transitionFromView:lastView toView:newView duration:1 options:(UIViewAnimationOptionTransitionCrossDissolve) completion:^(BOOL finished) {
        }];
        window.rootViewController = windowRootCtrl;
        window.backgroundColor = [UIColor blackColor];
        [window makeKeyAndVisible];
    }
}

//获取当前屏幕显示的viewcontroller
-(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    // 如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder     = appRootVC.presentedViewController;
    }else{
        UIView *frontView = window.subviews.firstObject;
        nextResponder     = [frontView nextResponder];
    }
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar  = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}

//- (void)gologin
//{
//    [[WCUserTool sharedWCUserTool] logoutWCAccount];
//    [self setupAppRootCtrl];
//}

//// 获取当前nav
//- (QSCNavigationController *)getCurrentNav{
//    if ([QSCAppDelegate.window.rootViewController isKindOfClass:[QSCMainTabBarController class]]) {
//        QSCMainTabBarController *tabVC = (QSCMainTabBarController *)QSCAppDelegate.window.rootViewController;
//        QSCNavigationController *nav = (QSCNavigationController *)[tabVC.childViewControllers objectAtIndex:tabVC.selectedIndex];
//        return nav;
//    }else{
//        QSCNavigationController *nav = (QSCNavigationController *)QSCAppDelegate.window.rootViewController;
//        return nav;
//    }
//}


@end
