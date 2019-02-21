//
//  SSCircleMessageCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/22.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleMessageCell.h"

@implementation SSCircleMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.header_imageview.layer.cornerRadius = 25;
    self.header_imageview.clipsToBounds = YES;
    self.right_imageview.layer.cornerRadius = 5;
}

- (void)initCellWithListModel:(SSCircleListModel *)listModel
{
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:listModel.headImg] placeholderImage:[UIImage imageNamed:@"mine_header_normal"]];
    self.content_label.text = listModel.content;
    if ([listModel.content intValue] == 666) {
        self.content_label.hidden = YES;
        self.dianzan_imageview.hidden = NO;
    }else{
        self.content_label.hidden = NO;
        self.dianzan_imageview.hidden = YES;
    }
    
    self.title_label.text = listModel.userName;
    self.right_imageview.hidden = NO;
    self.right_label.hidden = YES;
    [self.right_imageview sd_setImageWithURL:[NSURL URLWithString:listModel.picture] placeholderImage:[UIImage imageNamed:@"circle_placeholder_2"]];
    
    self.time_label.text = [NSString timestampSwitchTime:listModel.createTime andFormatter:@"HH:mm"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
