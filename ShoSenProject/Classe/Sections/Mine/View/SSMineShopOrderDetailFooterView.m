//
//  SSMineShopOrderDetailFooterView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/13.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineShopOrderDetailFooterView.h"

@implementation SSMineShopOrderDetailFooterView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setViewType:(ShopOrderDetaiViewType)viewType
{
    _viewType = viewType;
    if (viewType == ShopOrderDetaiTypePay) {
        [self.cancel_button setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.confirm_butotn setTitle:@"继续支付" forState:UIControlStateNormal];
    }else if (viewType == ShopOrderDetaiTypeCancel){
        [self.cancel_button setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.confirm_butotn setTitle:@"再次购买" forState:UIControlStateNormal];
    }
}

- (IBAction)oneButtonTapAction:(UIButton *)sender {
    if (self.viewType == ShopOrderDetaiTypePay) {
        self.block(ShopOrderDetaiButtonTapTypePay);
    }else{
        self.block(ShopOrderDetaiButtonTapTypeBuy);
    }
}

- (IBAction)twoButtonTapAction:(UIButton *)sender {
    if (self.viewType == ShopOrderDetaiTypePay) {
        self.block(ShopOrderDetaiButtonTapTypeCancel);
    }else{
        self.block(ShopOrderDetaiButtonTapTypeDelete);
    }
}

@end
