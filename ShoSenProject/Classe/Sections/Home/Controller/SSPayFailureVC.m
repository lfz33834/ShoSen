
//
//  SSPayFailureVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPayFailureVC.h"
#import "FZMainTabBarController.h"
#import "FZNavigationController.h"
#import "SSMineOrderListVC.h"
#import "SSMineShopAllOrderVC.h"

@interface SSPayFailureVC ()

@end

@implementation SSPayFailureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"支付失败"];
    self.bg_view.layer.cornerRadius = 5;
    self.bg_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.bg_view.userInteractionEnabled=YES;
    self.bg_view.layer.shadowOpacity=0.15;
    [self.bg_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bg_view.bounds] CGPath]];
    self.bg_view.layer.shadowRadius = 5.0;//半径
    self.bg_view.layer.shadowOffset = CGSizeMake(5, 5);
    
    self.lookButton.layer.cornerRadius = 5;
    self.lookButton.layer.borderColor = kColor(@"D6B35B").CGColor;
    self.lookButton.layer.borderWidth = 1;
    
    [self setback];
    
    if (self.vcType == SSPayFailureVCTypeShopOrder){
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0,0, 23,38);
        [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(backs)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItems =@[leftItem];
        
        [self wr_setNavBarTintColor:kColor(@"111113")];
        [self wr_setNavBarBarTintColor:kColor(@"111113")];
        [self wr_setNavBarTitleColor:kColor(@"ffffff")];
        [self wr_setNavBarBackgroundAlpha:1.0];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
}

- (void)backs
{
    if (self.vcType == SSPayFailureVCTypeShopOrder){
        FZMainTabBarController *tabVC = (FZMainTabBarController *)FZAppDelegate.window.rootViewController;
        FZNavigationController *nav = (FZNavigationController *)[tabVC.childViewControllers objectAtIndex:tabVC.selectedIndex];
        for (UIViewController *vc in nav.childViewControllers) {
            if ([vc isKindOfClass:[SSMineShopAllOrderVC class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
        [tabVC setSelectedIndex:4];
        [self.navigationController popToRootViewControllerAnimated:YES];
        SSMineShopAllOrderVC *listVC = [[SSMineShopAllOrderVC alloc]init];
        [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:listVC animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
    }else{
        FZMainTabBarController *tabVC = (FZMainTabBarController *)FZAppDelegate.window.rootViewController;
        FZNavigationController *nav = (FZNavigationController *)[tabVC.childViewControllers objectAtIndex:tabVC.selectedIndex];
        for (UIViewController *vc in nav.childViewControllers) {
            if ([vc isKindOfClass:[SSMineOrderListVC class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
        [tabVC setSelectedIndex:4];
        [self.navigationController popToRootViewControllerAnimated:YES];
        SSMineOrderListVC *listVC = [[SSMineOrderListVC alloc]init];
        [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:listVC animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
    }
}

- (IBAction)lookButtonTapAction:(UIButton *)sender {
    
    if (self.vcType == SSPayFailureVCTypeShopOrder) {
        
        FZMainTabBarController *tabVC = (FZMainTabBarController *)FZAppDelegate.window.rootViewController;
        FZNavigationController *nav = (FZNavigationController *)[tabVC.childViewControllers objectAtIndex:tabVC.selectedIndex];
        for (UIViewController *vc in nav.childViewControllers) {
            if ([vc isKindOfClass:[SSMineShopAllOrderVC class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
        [tabVC setSelectedIndex:4];
        [self.navigationController popToRootViewControllerAnimated:YES];
        SSMineShopAllOrderVC *listVC = [[SSMineShopAllOrderVC alloc]init];
        [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:listVC animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
        
    }else{
     
        FZMainTabBarController *tabVC = (FZMainTabBarController *)FZAppDelegate.window.rootViewController;
        FZNavigationController *nav = (FZNavigationController *)[tabVC.childViewControllers objectAtIndex:tabVC.selectedIndex];
        for (UIViewController *vc in nav.childViewControllers) {
            if ([vc isKindOfClass:[SSMineOrderListVC class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
        [tabVC setSelectedIndex:4];
        [self.navigationController popToRootViewControllerAnimated:YES];
        SSMineOrderListVC *listVC = [[SSMineOrderListVC alloc]init];
        [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:listVC animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
