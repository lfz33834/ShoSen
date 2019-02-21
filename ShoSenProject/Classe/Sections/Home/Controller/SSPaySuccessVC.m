//
//  SSPaySuccessVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPaySuccessVC.h"
#import "FZMainTabBarController.h"
#import "FZNavigationController.h"
#import "SSMineOrderListVC.h"
#import "SSMineShopAllOrderVC.h"

@interface SSPaySuccessVC ()

@end

@implementation SSPaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"支付成功";
    self.center_view.layer.cornerRadius = 5;
    self.center_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.center_view.userInteractionEnabled=YES;
    self.center_view.layer.shadowOpacity=0.15;
    [self.center_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.center_view.bounds] CGPath]];
    self.center_view.layer.shadowRadius = 5.0;//半径
    self.center_view.layer.shadowOffset = CGSizeMake(5, 5);
    
    
    self.checkOrder_button.layer.cornerRadius = 5;
    self.checkOrder_button.layer.borderColor = kColor(@"D6B35B").CGColor;
    self.checkOrder_button.layer.borderWidth = 1;
    
    
    [self setback];

    
    if (self.vcType == SSPaySuccessVCTypeShopOrder){
        
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
        
        self.subTitle_label.hidden = YES;
        self.checkOrder_button.hidden = NO;
        self.title_label.text = @"恭喜你支付成功";
    }else{
        self.subTitle_label.hidden = NO;
        self.checkOrder_button.hidden = YES;
    }
    
}

- (void)backs
{
    
    if (self.vcType == SSPaySuccessVCTypeShopOrder){
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
- (IBAction)checkOrderButtonTapAction:(UIButton *)sender {
    
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
