//
//  MacroDefinitionDevice.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#ifndef MacroDefinitionDevice_h
#define MacroDefinitionDevice_h

#define NUM @"0123456789"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define FZNotNilAndNull(_ref) (((_ref) != nil) && (![(_ref) isKindOfClass:[NSNull class]]))
#define FZDictionary(dict,key) ([dict objectForKey:key] == (NSString*)[NSNull null] ? @"" : [dict objectForKey:key])

#define kWidth           [[UIScreen mainScreen] bounds].size.width
#define kHeight          [[UIScreen mainScreen] bounds].size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceScale [UIScreen mainScreen].scale
#define KAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate
#define KDeviceHeight (iPhoneX ? ( [UIScreen mainScreen].bounds.size.height - 54): ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0?[UIScreen mainScreen].bounds.size.height - 20 : [UIScreen mainScreen].bounds.size.height))


#define WEAKSELF  typeof(self) __weak weakSelf=self;

#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
/**    从16进制颜色值转换为UIColor */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAlpha(rgbValue,alphaNum) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaNum]
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhoneX - 状态栏的高度
#define STATUS_HEIGHT          (KIsiPhoneX ? 44 : 20)
//iPhoneX - 安全区域下面的区域的高度
#define BOTTOM_SAFEAREA_HEIGHT (KIsiPhoneX ? 34 : 0)
//iPhoneX - 底部导航高度
#define TABBAR_HEIGHT          (KIsiPhoneX ? (49 + 34) : 49)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define iOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define iOS71s ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.1)

#define FZAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate

#define kNetworkStatusWiFi ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi)
#define kNetworkStatus3G ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN)
#define WINDOW [[[UIApplication sharedApplication] delegate] window]

///SVP
#define SHOW_SVP(title) \
[SVProgressHUD showWithStatus:title];

#define SHOW_ERROE(title) \
[SVProgressHUD showErrorWithStatus:title];

#define SHOW_SUCCESS(title) \
[SVProgressHUD showSuccessWithStatus:title];

#define DISMISS_SVP(time) \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
[SVProgressHUD dismiss]; \
});

#ifdef DEBUG // 调试状态, 打开LOG功能  pvxdm17jxalwr
#define MYLog(...) NSLog(__VA_ARGS__)

#else // 发布状态, 关闭LOG功能
#define MYLog(...)

#endif

#endif /* MacroDefinitionDevice_h */
