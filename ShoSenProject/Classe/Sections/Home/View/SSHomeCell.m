//
//  SSHomeCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSHomeCell.h"

@implementation SSHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.header_imageview.layer.cornerRadius = 5;
    self.header_imageview.clipsToBounds = YES;
}

- (void)setModel:(SSNewsModel *)model
{
    [_header_imageview sd_setImageWithURL:[NSURL URLWithString:model.news_Picture] placeholderImage:[UIImage imageNamed:@""]];
    _content_label.text = model.news_Title;
    _time_label.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"yyyy-MM-dd"];
    [_look_button setTitle:model.news_ReadNum forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
