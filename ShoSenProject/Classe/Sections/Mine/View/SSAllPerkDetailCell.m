//
//  SSAllPerkDetailCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/8.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSAllPerkDetailCell.h"

@implementation SSAllPerkDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SSPartnerItemModel *)model
{
    _money_label.text = [NSString stringWithFormat:@"+%@",model.reward];
    _content_label.text =  [NSString stringWithFormat:@"累计邀请%@位车主",model.invitSum];
    _date_label.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"yyyy-MM-dd hh:mm:ss"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
