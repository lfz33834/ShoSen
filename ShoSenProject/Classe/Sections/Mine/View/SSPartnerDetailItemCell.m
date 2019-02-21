//
//  SSPartnerDetailItemCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/8.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPartnerDetailItemCell.h"

@implementation SSPartnerDetailItemCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.point_view.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
