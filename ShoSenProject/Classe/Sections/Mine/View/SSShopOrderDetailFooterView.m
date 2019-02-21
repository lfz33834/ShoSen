//
//  SSShopOrderDetailFooterView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderDetailFooterView.h"

@implementation SSShopOrderDetailFooterView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)initViewWithModel:(SSShopOrderInfoModel *)model orderModel:(SSShopOrderListModel*)orderModel
{
    self.orderNo_label.text = model.orderSn;
    self.orderTime_label.text = model.addTime;
    CGFloat totalNum = [model.goodsPrice floatValue] + [model.freightPrice floatValue] - [model.balancePrice floatValue];
    if (totalNum < 1) {
        totalNum = 0;
    }

    if ([model.orderType isEqualToString:@"integral"]) {
        self.goodsPrice_label.text = [NSString stringWithFormat:@"%.2f 积分",[model.goodsPrice floatValue]];
        self.yunfei_label.text = [NSString stringWithFormat:@"￥ %.2f",[model.freightPrice floatValue]];
        int status = [orderModel.orderStatus intValue];
        if (status == 101) {//待支付
            self.total_lable.text = [NSString stringWithFormat:@"待付款: %.2f 积分",totalNum];
        }else{
            self.total_lable.text = [NSString stringWithFormat:@"总计: %.2f 积分",totalNum];
        }
        self.yue_label.text = [NSString stringWithFormat:@"%.2f 积分",[model.goodsPrice floatValue]];
        self.yue_title_label.text = @"积分支付:";
    }else{
        self.goodsPrice_label.text = [NSString stringWithFormat:@"￥ %.2f",[model.goodsPrice floatValue]];
        self.yunfei_label.text = [NSString stringWithFormat:@"￥ %.2f",[model.freightPrice floatValue]];
        int status = [orderModel.orderStatus intValue];
        
        
        if (status == 101) {//待支付
            self.total_lable.text = [NSString stringWithFormat:@"待付款:￥ %.2f",totalNum];
        }else if (status == 401 || status == 402 ||  status == 501 || status == 301 || status == 201)//已完成
        {
            self.total_lable.text = [NSString stringWithFormat:@"实付款:￥ %.2f",totalNum];

        }else if (status == 102  ||status == 103)//已取消
        {
            self.total_lable.text = [NSString stringWithFormat:@"应付款:￥ %.2f",totalNum];
        }
        
        self.yue_label.text = [NSString stringWithFormat:@"￥ %.2f",[model.balancePrice floatValue]];
        self.yue_title_label.text = @"余额支付:";
    }
}

@end
