//
//  FZMainTabBarController.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZMainTabBarController.h"
#import "FZNavigationController.h"
#import "SSMineCtrl.h"
#import "SSLoveVC.h"
#import "SSHomeVC.h"
#import "SSMineCtrl.h"
#import "FZWebViewController.h"
#import "SSCircleVC.h"
#import "KDCShopVC.h"
#import "KDC6SVC.h"


#import "SSMineOrderListVC.h"

@interface FZMainTabBarController ()<UITabBarControllerDelegate>

@property(nonatomic, strong) SSHomeVC *homeVC;
//@property(nonatomic, strong) SSLoveVC *loveVC;
//@property(nonatomic, strong) SSMessageVC *messageVC;
@property(nonatomic, strong) FZWebViewController *loveVC;
@property(nonatomic, strong) SSCircleVC *messageVC;
@property(nonatomic, strong) KDCShopVC *shopVC;
@property(nonatomic, strong) KDC6SVC *guanVC;
@property(nonatomic, strong) SSMineCtrl *mineVC;
@end

@implementation FZMainTabBarController

-(SSMineCtrl *)mineVC
{
    if (_mineVC == nil) {
        _mineVC = [[SSMineCtrl alloc]init];
        _mineVC.title = @"我的";
        _mineVC.tabBarItem.title = @"我的";
        _mineVC.tabBarItem.image = [[UIImage imageNamed:@"mine_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"mine_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _mineVC;
}

-(SSCircleVC *)messageVC
{
    if (_messageVC == nil) {
        _messageVC = [[SSCircleVC alloc]init];
        _messageVC.title = @"圈子";
        _messageVC.tabBarItem.title = @"圈子";
        _messageVC.tabBarItem.image = [[UIImage imageNamed:@"message_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _messageVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"message_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _messageVC;
}

-(KDCShopVC *)shopVC
{
    if (_shopVC == nil) {
        _shopVC = [[KDCShopVC alloc]init];
        _shopVC.title = @"商城";
        _shopVC.tabBarItem.title = @"商城";
        _shopVC.tabBarItem.image = [[UIImage imageNamed:@"shop_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _shopVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"shop_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _shopVC;
}



-(KDC6SVC *)guanVC
{
    if (_guanVC == nil) {
        _guanVC = [[KDC6SVC alloc]init];
        _guanVC.title = @"汽车馆";
        _guanVC.tabBarItem.title = @"汽车馆";
        _guanVC.tabBarItem.image = [[UIImage imageNamed:@"6s_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _guanVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"6s_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _guanVC;
}


//-(FZWebViewController *)guanVC
//{
//    if (_guanVC == nil) {
//        _guanVC = [[FZWebViewController alloc]init];
//        _guanVC.title = @"汽车馆";
//        _guanVC.tabBarItem.title = @"汽车馆";
//        _guanVC.loadUrl = @"https://api.shosen.cn/news/6s.html";
//         _guanVC.tabBarItem.image = [[UIImage imageNamed:@"6s_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        _guanVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"6s_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
//    return _guanVC;
//}


//-(FZWebViewController *)loveVC
//{
//    if (_loveVC == nil) {
//        _loveVC = [[FZWebViewController alloc]init];
//        _loveVC.title = @"慈善";
//        _loveVC.tabBarItem.title = @"慈善";
//        _loveVC.loadUrl = @"https://api.shosen.cn/news/gy.html";
////        _messageVC.loadUrl = @"https://api.shosen.cn/news/news.html";
//        _loveVC.tabBarItem.image = [[UIImage imageNamed:@"charity_normal"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
//        _loveVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"charity_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
//    return _loveVC;
//}

-(SSHomeVC *)homeVC
{
    if (_homeVC == nil) {
        _homeVC = [[SSHomeVC alloc]init];
        _homeVC.tabBarItem.title = @"首页";
        _homeVC.tabBarItem.image = [[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _homeVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    FZNavigationController *mineNav = [[FZNavigationController alloc]initWithRootViewController:self.mineVC];
    FZNavigationController *messageNav = [[FZNavigationController alloc]initWithRootViewController:self.messageVC];
        FZNavigationController *guanNav = [[FZNavigationController alloc]initWithRootViewController:self.guanVC];
    FZNavigationController *loveNav = [[FZNavigationController alloc]initWithRootViewController:self.shopVC];
    FZNavigationController *homeNav = [[FZNavigationController alloc]initWithRootViewController:self.homeVC];
    //加载tabbar
    self.viewControllers = @[homeNav,messageNav,guanNav,loveNav
                             ,mineNav];
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.translucent = false;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(@"ffffff")} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(@"D6B35B")} forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:kColor(@"111113")]];
    self.delegate = self;
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.title isEqualToString:@"圈子"]) {
        SSAccount *account = [SSAccountTool share].account;
        if (!account) {
            SSLoginVC *loginVC = [[SSLoginVC alloc]init];
            [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:loginVC animated:YES];
            return NO;
        }
    }
    return YES;
}

@end
