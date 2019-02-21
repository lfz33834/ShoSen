//
//  SSOrderDetailCancelCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSOrderDetailCancelCell.h"

@implementation SSOrderDetailCancelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initWithCellWithModel:(SSOrderListModel *)model isSelected:(BOOL)isSelected
{
    self.content_label.text = model.titleString;
    if (isSelected) {
        self.select_imageview.image = [UIImage imageNamed:@"mine_order_select"];
    }else{
        self.select_imageview.image = [UIImage imageNamed:@"mine_order_normal"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
