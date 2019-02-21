//
//  SSMienPurseCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/21.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMienPurseCell.h"

@implementation SSMienPurseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initCellWithModel:(SSMyPurseListModel *)model cellType:(SSMienPurseCellType)type
{
    if (type == SSMienPurseCellTypeYue) {
        if ([model.type intValue] == 1) {
            self.title_label.text = @"商城消耗";
        }else if ([model.type intValue] == 2)
        {
            self.title_label.text = @"社区管理平台转入";
        }else if ([model.type intValue] == 3)
        {
            self.title_label.text = @"退款";
        }else if ([model.type intValue] == 4)
        {
            self.title_label.text = @"充值";
        }
        self.num_label.text = model.changeMoney;

    }else if (type == SSMienPurseCellTypeJiFen)
    {
        if ([model.type intValue] == 3) {
            self.title_label.text = @"商城消耗";
        }else if ([model.type intValue] == 5)
        {
            self.title_label.text = @"社区管理平台转入";
        }
        self.num_label.text = model.typeValue;
    }
    self.time_lable.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"yyyy-MM-dd"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
