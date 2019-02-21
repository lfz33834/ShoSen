//
//  UIApplication+CurrentTopViewController.h
//  qingsongchou
//
//  Created by CaoPing on 15/3/9.
//  Copyright (c) 2015年 qschou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIApplicationReleaseMode) {
    UIApplicationReleaseUnknown,
    UIApplicationReleaseSim,
    UIApplicationReleaseDev,
    UIApplicationReleaseAdHoc,
    UIApplicationReleaseAppStore,
    UIApplicationReleaseEnterprise,
};

@interface UIApplication (Extension)

// releaseMode
- (UIApplicationReleaseMode)releaseMode;

- (UIViewController *)topViewController;
- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController;

@end
