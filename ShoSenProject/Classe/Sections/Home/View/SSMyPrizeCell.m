//
//  SSMyPrizeCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMyPrizeCell.h"

@implementation SSMyPrizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bg_view.layer.cornerRadius = 10;
    self.bg_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.bg_view.layer.shadowOpacity=0.15;
    [self.bg_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bg_view.bounds] CGPath]];
    self.bg_view.layer.shadowRadius = 5.0;//半径
    self.bg_view.layer.shadowOffset = CGSizeMake(5, 5);
}

- (void)initCellWithModel:(SSPrizeModel *)model
{
//    4优惠券5贡献值123实物
    _time_label.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"yyyy-MM-dd hh:mm"];
    NSArray *dataArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"jiangpin"];
    WEAKSELF
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj[@"dicCode"] intValue] == [model.rewardTitle intValue])
        {
            NSArray *contentArray = [obj[@"dicValue"] componentsSeparatedByString:@","];
            if (contentArray.count == 2) {
                weakSelf.subTiltle_label.text = [NSString stringWithFormat:@"%@%@",contentArray[0],contentArray[1]];
            }else{
                weakSelf.subTiltle_label.text = obj[@"dicValue"];
            }
//            weakSelf.subTiltle_label.text = obj[@"dicValue"];
        }
    }];
    
    if([model.dicCode intValue] == 4)
    {
        self.title_label.text = @"优惠券";
    }else if ([model.dicCode intValue]  == 5)
    {
        self.title_label.text = @"贡献值";
    }else{
        self.title_label.text = @"实物";
    }
    
    if ([model.getType intValue] == 1) {
        _subContent_label.text = @"已发放到账户中";
    }else if ([model.getType intValue] == 2)
    {
        _subContent_label.text = @"请联系客服";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
