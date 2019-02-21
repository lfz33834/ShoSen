//
//  SSShopOrderDetailHeaderView.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderDetailHeaderView.h"

@implementation SSShopOrderDetailHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)initViewWithModel:(SSShopOrderInfoModel *)model
{
    self.user_label.text = [NSString stringWithFormat:@"%@ %@",model.consignee,model.mobile];
    self.location_label.text = model.address;
}

@end
