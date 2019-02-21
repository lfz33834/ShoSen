//
//  SSMinePerkCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/20.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMinePerkCell.h"

@implementation SSMinePerkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bg_view.layer.cornerRadius = 5;
    self.bg_view.layer.shadowColor= kColor(@"333333").CGColor;
    self.bg_view.userInteractionEnabled=YES;
    self.bg_view.layer.shadowOpacity=0.15;
    [self.bg_view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bg_view.bounds] CGPath]];
    self.bg_view.layer.shadowRadius = 5.0;//半径
    self.bg_view.layer.shadowOffset = CGSizeMake(5, 5);
    
    self.content_label.attributedText =  [NSMutableAttributedString attributeStringWithFont1:[UIFont systemFontOfSize:14] color1:kColor(@"666666") Font2:[UIFont systemFontOfSize:16] color2:kColor(@"333333") text1:@"A成功邀请1位车主B，A就会得到6个月的奖励, 每月奖励1000元。邀请人数增加，对应月份及 金额一并增加" text2:@"   查看详情"];
    
}
- (IBAction)pertDetailButtonTap:(UIButton *)sender {
    self.block();
}

- (void)setDicData:(NSDictionary *)dicData
{
    _invitsum_label.text = [NSString stringWithFormat:@"%@",dicData[@"invitSum"]];
    _remard_label.text = [NSString stringWithFormat:@"%@",dicData[@"reward"]];
    _rewardMonth_label.text = [NSString stringWithFormat:@"%@",dicData[@"rewardMonth"]];
    _rewardedMoney_label.text = [NSString stringWithFormat:@"%@",dicData[@"rewardedMoney"]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
