//
//  SSPerkDetailNormalCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/29.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPerkDetailNormalCell.h"

@implementation SSPerkDetailNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
    
}

- (void)initCellWithModel:(SSPerkDetailListModel *)model index:(NSInteger )index
{
    if (index == 0) {
        self.one_label.textColor = kColor(@"D6B35B");
        self.two_label.textColor = kColor(@"D6B35B");
        self.three_label.textColor = kColor(@"D6B35B");
        self.four_label.textColor = kColor(@"D6B35B");
        self.one_label.text = @"日期";
        self.two_label.text = @"好友名称";
        self.three_label.text = @"联系方式";
        self.four_label.text = @"已支付";
        self.upline_view.hidden = NO;
    }else{
        self.one_label.textColor = kColor(@"333333");
        self.two_label.textColor = kColor(@"333333");
        self.three_label.textColor = kColor(@"333333");
        self.four_label.textColor = kColor(@"333333");
        self.one_label.text = model.dateString;
        self.two_label.text = model.nameString;
        self.three_label.text = model.phoneString;
        self.four_label.text = model.moneyString;
        self.upline_view.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
