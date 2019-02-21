//
//  SSShopOrderCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderCell.h"

@implementation SSShopOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.header_imageview.layer.cornerRadius = 5;
}

- (void)initCellWithModel:(ShopModel *)model cellType:(SSShopOrderCellType)type
{
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
    self.title_label.text = model.shopTitle;
    if (type == SSShopOrderCellTypeYue) {
        self.money_label.text = [NSString stringWithFormat:@"￥%.2f",model.singlePrice];
    }else if (type == SSShopOrderCellTypeJiFen){
        self.money_label.text = [NSString stringWithFormat:@"%.2f积分",model.singlePrice];
    }
    self.num_label.text = [NSString stringWithFormat:@"X %d",model.count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
