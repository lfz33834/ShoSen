//
//  SSShopDeleteView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopDeleteView.h"

@implementation SSShopDeleteView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bg_view.layer.cornerRadius = 5;
    self.cancel_button.layer.cornerRadius = 5;
    self.confirm_button.layer.cornerRadius = 5;
}

- (void)initViewWithType:(SSShopDeleteViewType)viewType
{
    self.viewType = viewType;
    if (viewType == SSShopDeleteViewTypeDelete) {
        self.title_label.text = @"是否确认删除所选商品";
        [self.cancel_button setTitle:@"取消" forState:UIControlStateNormal];
        [self.confirm_button setTitle:@"确认" forState:UIControlStateNormal];
    }else if (viewType == SSShopDeleteViewTypeExchange)
    {
        self.title_label.text = @"确认兑换后积分将从您的账户中直接扣除";
        [self.cancel_button setTitle:@"取消兑换" forState:UIControlStateNormal];
        [self.confirm_button setTitle:@"确认兑换" forState:UIControlStateNormal];
    }else if (viewType == SSShopDeleteViewTypePay)
    {
        self.title_label.text = @"是否离开支付页面";
        [self.cancel_button setTitle:@"继续支付" forState:UIControlStateNormal];
        [self.confirm_button setTitle:@"确认离开" forState:UIControlStateNormal];
    }else if (viewType == SSShopDeleteViewTypeYueExchange)
    {
        self.title_label.text = @"确认购买后余额将从您的账户中直接扣除";
        [self.cancel_button setTitle:@"取消购买" forState:UIControlStateNormal];
        [self.confirm_button setTitle:@"确认购买" forState:UIControlStateNormal];
    }
}

- (IBAction)confirmButtonTapAction:(UIButton *)sender {
    self.block(self.viewType);
    [self removeFromSuperview];
}

- (IBAction)cancelButtonTapAction:(UIButton *)sender {
    [self removeFromSuperview];
}

- (void)showView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

@end
