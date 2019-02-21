//
//  SSPayOrderVC.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPayOrderVC.h"
#import "SSPayFailureVC.h"
#import "SSPayTool.h"
#import "SSPayFailureVC.h"
#import "SSPaySuccessVC.h"
#import "FZMainTabBarController.h"
#import "FZNavigationController.h"
#import "SSMineOrderListVC.h"
#import "SSShopViewModel.h"
#import "SSShopDeleteView.h"
#import "SSMineShopAllOrderVC.h"
#import "SSMyPurseVC.h"

@interface SSPayOrderVC ()

@property (nonatomic, assign) NSInteger payType;
@property (nonatomic, assign) NSInteger payBackType;
@property (nonatomic, strong) SSShopViewModel *viewModel;
@property (nonatomic, strong) SSPayTool *payTool;
@property (nonatomic, strong) SSShopDeleteView *shopDeleteView;

@end

@implementation SSPayOrderVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.payType = 1;
    self.payBackType = 0;
    self.pay_button.layer.cornerRadius = 5;
    [self setTitle:@"确认支付"];
    
    [SSPayTool share].block = ^(id obj) {
        if (self.viewType == SSPayOrderVCTypeShopOrder) {
            if ([obj isEqualToString:@"失败"]){
                SSPayFailureVC *suVC = [[SSPayFailureVC alloc]init];
                suVC.vcType = SSPayFailureVCTypeShopOrder;
                [self.navigationController pushViewController:suVC animated:YES];
            }else if ([obj isEqualToString:@"成功"]){
                SSPaySuccessVC *suVC = [[SSPaySuccessVC alloc]init];
                suVC.vcType = SSPayOrderVCTypeShopOrder;
                [self.navigationController pushViewController:suVC animated:YES];
            }else{
                [ProgressHUD showSuccess:@"支付取消"];
            }
        }else if (self.viewType == SSPayOrderVCTypeRecharge)
        {
            if ([obj isEqualToString:@"失败"]){
                [self returnPurseVC];
            }else if ([obj isEqualToString:@"成功"]){
                [self returnPurseVC];
            }else{
                [ProgressHUD showSuccess:@"支付取消"];
            }
        }
    };
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccess) name:@"PaySuccess" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payFailure) name:@"PayFailure" object:nil];

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0, 23,38);
    if (self.viewType == SSPayOrderVCTypeShopOrder || self.viewType == SSPayOrderVCTypeRecharge) {
        if (self.viewType == SSPayOrderVCTypeShopOrder) {
            self.money_label.text = [NSString stringWithFormat:@"￥%@",self.orderModel.actualPrice];
        }else{
            self.money_label.text = [NSString stringWithFormat:@"￥%@",self.money_str];
        }
        [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
        self.title_label.text = @"需支付金额";
    }
    else{
        self.money_label.text = [NSString stringWithFormat:@"￥%@",@"25000"];
        [leftBtn setImage:[[UIImage imageNamed:@"home_left_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    }
    [leftBtn addTarget:self action:@selector(backsVC)forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems =@[leftItem];
}

- (void)backsVC
{
    [self.shopDeleteView initViewWithType:SSShopDeleteViewTypePay];
    [self.shopDeleteView showView];
}

- (IBAction)payButtonTapAction:(UIButton *)sender {
    
    if (self.viewType == SSPayOrderVCTypeShopOrder) {
        if(self.payType == 1)
        {
            [self.viewModel payOrderWithOrderId:self.orderModel.ID payType:@"wxAppPay" total:self.orderModel.actualPrice callback:^(id  _Nonnull object) {
                [[SSPayTool share] weixinPay:object[@"data"][@"data"] result:^(id obj) {
                    if ([obj isEqualToString:@"成功"]) {
                        SSPaySuccessVC *successVC = [[SSPaySuccessVC alloc]init];
                        [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:successVC animated:YES];
                    }else if ([obj isEqualToString:@"取消"])
                    {
                         [ProgressHUD showSuccess:@"支付取消"];
                    }else if ([obj isEqualToString:@"失败"])
                    {
                        SSPayFailureVC *successVC = [[SSPayFailureVC alloc]init];
                        [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:successVC animated:YES];
                    }
                }];
            }];
        }else if (self.payType == 2)
        {
            [self.viewModel payOrderWithOrderId:self.orderModel.ID payType:@"aliPay" total:self.orderModel.actualPrice callback:^(id  _Nonnull object) {
                [[SSPayTool share] aliPay:object[@"data"][@"data"][@"payStr"] result:^(id obj) {
                    if ([obj isEqualToString:@"成功"]) {
                        SSPaySuccessVC *successVC = [[SSPaySuccessVC alloc]init];
                        [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:successVC animated:YES];
                    }else if ([obj isEqualToString:@"取消"])
                    {
                        [ProgressHUD showSuccess:@"支付取消"];
                    }else if ([obj isEqualToString:@"失败"])
                    {
                        SSPayFailureVC *successVC = [[SSPayFailureVC alloc]init];
                        [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:successVC animated:YES];
                    }
                }];
            }];
        }
    }else if(self.viewType == SSPayOrderVCTypeCar){
        if(self.payType == 1)
        {
            [[SSPayTool share] wechatPayWithID:self.bookID];
        }else if (self.payType == 2)
        {
            [[SSPayTool share] aliPayWithID:self.bookID];
        }
    }else if (self.viewType == SSPayOrderVCTypeRecharge)
    {
        if(self.payType == 2)
        {
            [[SSPayTool share] aliRechargeWithOrderNo:self.bookID];
        }else if (self.payType == 1)
        {
            [[SSPayTool share] wechatRechargeWithOrderNo:self.bookID];
        }
    }
 }

- (IBAction)weixinButtonTapAction:(UIButton *)sender {
    self.payType = 1;
    [self changeImageViewWithIndex:self.payType];
}
- (IBAction)zhifubaoButtonTapAction:(UIButton *)sender {
    self.payType = 2;
    [self changeImageViewWithIndex:self.payType];
}

- (void)changeImageViewWithIndex:(NSInteger )index
{
    if (self.payType == 1) {
        self.weixin_imageview.image = [UIImage imageNamed:@"home_pay_select"];
        self.zhifubao_imageview.image = [UIImage imageNamed:@"mine_order_normal"];
    }else{
        self.weixin_imageview.image = [UIImage imageNamed:@"mine_order_normal"];
        self.zhifubao_imageview.image = [UIImage imageNamed:@"home_pay_select"];
    }
}

- (SSShopViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[SSShopViewModel alloc]init];
    }
    return _viewModel;
}

- (void)paySuccess
{
    if (self.viewType == SSPayOrderVCTypeShopOrder) {
        SSPaySuccessVC *suVC = [[SSPaySuccessVC alloc]init];
        suVC.vcType = SSPayOrderVCTypeShopOrder;
        [self.navigationController pushViewController:suVC animated:YES];
    }else{
        SSPaySuccessVC *suVC = [[SSPaySuccessVC alloc]init];
        [self.navigationController pushViewController:suVC animated:YES];
    }
}

- (void)payFailure
{
    if (self.viewType == SSPayOrderVCTypeShopOrder) {
        SSPayFailureVC *suVC = [[SSPayFailureVC alloc]init];
        suVC.vcType = SSPayFailureVCTypeShopOrder;
        [self.navigationController pushViewController:suVC animated:YES];
    }else{
        SSPayFailureVC *suVC = [[SSPayFailureVC alloc]init];
        [self.navigationController pushViewController:suVC animated:YES];
    }
}

- (SSShopDeleteView *)shopDeleteView
{
    if (_shopDeleteView == nil) {
        WEAKSELF
        _shopDeleteView = [[NSBundle mainBundle]loadNibNamed:@"SSShopDeleteView" owner:self options:nil].lastObject;
        _shopDeleteView.frame = CGRectMake(0, 0, kwidth, kheight);
        _shopDeleteView.block = ^(SSShopDeleteViewType viewType){
            //删除事件。多个删除直接重新请求数据！
            if (self.viewType == SSPayOrderVCTypeShopOrder) {
                FZMainTabBarController *tabVC = (FZMainTabBarController *)FZAppDelegate.window.rootViewController;
                FZNavigationController *nav = (FZNavigationController *)[tabVC.childViewControllers objectAtIndex:tabVC.selectedIndex];
                for (UIViewController *vc in nav.childViewControllers) {
                    if ([vc isKindOfClass:[SSMineShopAllOrderVC class]]) {
                        [weakSelf.navigationController popToViewController:vc animated:YES];
                        return;
                    }
                }
                [tabVC setSelectedIndex:4];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                SSMineShopAllOrderVC *listVC = [[SSMineShopAllOrderVC alloc]init];
                [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:listVC animated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                });
            }else if (self.viewType == SSPayOrderVCTypeRecharge){
                [weakSelf returnPurseVC];
            }else{
//                if (weakSelf.payBackType == 1) {
                    FZMainTabBarController *tabVC = (FZMainTabBarController *)FZAppDelegate.window.rootViewController;
                    FZNavigationController *nav = (FZNavigationController *)[tabVC.childViewControllers objectAtIndex:tabVC.selectedIndex];
                    for (UIViewController *vc in nav.childViewControllers) {
                        if ([vc isKindOfClass:[SSMineOrderListVC class]]) {
                            [weakSelf.navigationController popToViewController:vc animated:YES];
                            return;
                        }
                    }
                    [tabVC setSelectedIndex:4];
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                    SSMineOrderListVC *listVC = [[SSMineOrderListVC alloc]init];
                    [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:listVC animated:YES];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    });
//                }else{
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                }
            }
        };
    }
    return _shopDeleteView;
}

- (void)returnPurseVC
{
    FZMainTabBarController *tabVC = (FZMainTabBarController *)FZAppDelegate.window.rootViewController;
    FZNavigationController *nav = (FZNavigationController *)[tabVC.childViewControllers objectAtIndex:tabVC.selectedIndex];
    for (UIViewController *vc in nav.childViewControllers) {
        if ([vc isKindOfClass:[SSMyPurseVC class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    [tabVC setSelectedIndex:4];
    [self.navigationController popToRootViewControllerAnimated:YES];
    SSMyPurseVC *listVC = [[SSMyPurseVC alloc]init];
    [[[FZRouteUrlTool share]getCurrentVC].navigationController pushViewController:listVC animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
