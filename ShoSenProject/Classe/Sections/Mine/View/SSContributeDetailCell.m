//
//  SSContributeDetailCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/26.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSContributeDetailCell.h"

@implementation SSContributeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initCellWithModle:(SSFlagsModel *)model
{
    self.time_label.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"yyyy-MM-dd"];
    self.title_label.text = model.type;
    self.value_label.text = [NSString stringWithFormat:@"+%@贡献值",model.typeValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
