//
//  SSShopOrderListCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderListCell.h"

@implementation SSShopOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bg_view.layer.cornerRadius = 5;
    self.bg_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.bg_view.layer.shadowOpacity=0.15;
    [self.bg_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bg_view.bounds] CGPath]];
    self.bg_view.layer.shadowRadius = 5.0;//半径
    self.bg_view.layer.shadowOffset = CGSizeMake(5, 5);
    
    self.one_button.layer.cornerRadius = 5;
    self.two_butotn.hidden = YES;
}

- (void)initViewWithModel:(SSShopOrderListModel *)model
{
    self.model = model;
    int status = [model.orderStatus intValue];
    if (status == 101) {//待支付
        self.trailing_layout.constant = 15;
        self.cancel_button.hidden = YES;
        self.status_label.text = @"待支付";
        self.two_butotn.hidden = NO;
        [self.one_button setBackgroundImage:[UIImage imageNamed:@"mine_shoporder_pay"] forState:UIControlStateNormal];
        [self.two_butotn setBackgroundImage:[UIImage imageNamed:@"mine_shoporder_cancel"] forState:UIControlStateNormal];
        [self.two_butotn setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.one_button setTitle:@"支付" forState:UIControlStateNormal];

    }else if (status == 401 || status == 402 ||  status == 501)//已完成
    {
        self.trailing_layout.constant = 37;
        self.cancel_button.hidden = NO;
        self.status_label.text = @"已完成";
        self.two_butotn.hidden = YES;
        self.one_button.hidden = YES;
        
        [self.two_butotn setBackgroundImage:[UIImage imageNamed:@"mine_shoporder_check"] forState:UIControlStateNormal];
        [self.one_button setBackgroundImage:[UIImage imageNamed:@"mine_shoporder_pay"] forState:UIControlStateNormal];
        [self.two_butotn setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.one_button setTitle:@"再次购买" forState:UIControlStateNormal];
        
    }else if (status == 102  ||status == 103)//已取消
    {
        self.trailing_layout.constant = 37;
        self.cancel_button.hidden = NO;
        self.status_label.text = @"已取消";
        self.two_butotn.hidden = YES;
        self.one_button.hidden = YES;

        [self.one_button setBackgroundImage:[UIImage imageNamed:@"mine_shoporder_pay"] forState:UIControlStateNormal];
        [self.one_button setTitle:@"再次购买" forState:UIControlStateNormal];

    }else if (status == 301)//卖家已发货
    {
        self.trailing_layout.constant = 15;
        self.cancel_button.hidden = YES;
        self.status_label.text = @"卖家已发货";
        self.two_butotn.hidden = YES;
        [self.two_butotn setBackgroundImage:[UIImage imageNamed:@"mine_shoporder_cancel"] forState:UIControlStateNormal];
        [self.one_button setBackgroundImage:[UIImage imageNamed:@"mine_shoporder_cancel"] forState:UIControlStateNormal];
        [self.two_butotn setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.one_button setTitle:@"确认收货" forState:UIControlStateNormal];

    }else if (status == 201)//买家已付款
    {
        self.trailing_layout.constant = 15;
        self.cancel_button.hidden = YES;
        self.status_label.text = @"买家已付款";
        self.two_butotn.hidden = YES;
        self.one_button.hidden = YES;

        
        [self.one_button setBackgroundImage:[UIImage imageNamed:@"mine_shoporder_pay"] forState:UIControlStateNormal];
        [self.one_button setTitle:@"再次购买" forState:UIControlStateNormal];
    }
    
//    _time_label.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"yyyy-MM-dd"];

    
    _time_label.text = model.updateTime;
    SSShopOrderGoodsListModel *goodsModel = model.goodsList[0];
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:goodsModel.picUrl] placeholderImage:nil];
    self.title_label.text = goodsModel.goodsName;
    
    if ([model.orderType isEqualToString:@"integral"]) {
        self.num_label.text = [NSString stringWithFormat:@"%.2f 积分",[goodsModel.price floatValue]];
    }else{
        self.num_label.text = [NSString stringWithFormat:@"￥ %.2f",[goodsModel.price floatValue]];
    }

    
    self.number_label.text = [NSString stringWithFormat:@"x%@",goodsModel.number];
}
- (IBAction)oneButtonTapAction:(UIButton *)sender {
  
    int status = [self.model.orderStatus intValue];
    if (status == 101) {//待支付
        self.block(SSShopOrderListCellTypePay);
    }else if (status == 401 || status == 402 ||  status == 501)//已完成
    {
        self.block(SSShopOrderListCellTypeBuy);
    }else if (status == 102  ||status == 103)//已取消
    {
        self.block(SSShopOrderListCellTypeBuy);
    }else if (status == 301)//卖家已发货
    {
        self.block(SSShopOrderListCellTypeReceiving);
    }else if (status == 201)//买家已付款
    {
        self.block(SSShopOrderListCellTypeBuy);
    }
}
- (IBAction)twoButtonTapAction:(UIButton *)sender {
    self.block(SSShopOrderListCellTypeCancel);
}
- (IBAction)deleteButtonTapAction:(UIButton *)sender {
    self.block(SSShopOrderListCellTypeDelete);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
