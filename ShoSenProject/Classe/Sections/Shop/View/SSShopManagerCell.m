//
//  SSShopManagerCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopManagerCell.h"

@implementation SSShopManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initCellWithModel:(SSLocationModel *)model
{
    self.info_label.text = [NSString stringWithFormat:@"%@  %@",model.name,model.mobile];
    self.location_label.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.province,model.city,model.area,model.address];
    if (model.isDefault) {
        self.default_label.hidden = NO;
        self.leading_layout.constant = 59;
    }else{
        self.default_label.hidden = YES;
        self.leading_layout.constant = 20;
    }
}
- (IBAction)editButtonTapAction:(UIButton *)sender {
    self.block();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
