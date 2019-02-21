//
//  SSOrderDetailCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSOrderDetailCell.h"

@implementation SSOrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bg_view.layer.cornerRadius = 5;
    self.bg_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.bg_view.userInteractionEnabled=YES;
    self.bg_view.layer.shadowOpacity=0.15;
    [self.bg_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bg_view.bounds] CGPath]];
    self.bg_view.layer.shadowRadius = 5.0;//半径
    self.bg_view.layer.shadowOffset = CGSizeMake(5, 5);
    self.bg_view.clipsToBounds = NO;
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:@"https://api.shosen.cn/wx/images/reservation/banner.png"] placeholderImage:[UIImage imageNamed:@"home_confirm_bg"]];

}

- (void)setOrderModel:(SSOrderListModel *)orderModel
{
    _name_label.text = orderModel.bookUserName;
    _phnone_label.text = orderModel.bookUserPhone;
    _location_label.text = [NSString stringWithFormat:@"%@-%@",orderModel.province,orderModel.city];
    _orderno_label.text = orderModel.orderNo;
//    _ordertime_label.text = [orderModel.bookTime timeStampTransform];
    _ordertime_label.text = [NSString timestampSwitchTime:orderModel.bookTime andFormatter:@"yyyy-MM-dd hh:mm"];

    _ordermoney_label.text = orderModel.bookMoney;
    if ([orderModel.bookStatus intValue] == 1) {
        _status_label.text = @"待支付";
    }else if ([orderModel.bookStatus intValue] == 2)
    {
        _status_label.text = @"交易成功";
    }else if ([orderModel.bookStatus intValue] == 3)
    {
        _status_label.text = @"已缴全款";
    }else if ([orderModel.bookStatus intValue] == 4)
    {
        _status_label.text = @"交易关闭";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
