//
//  SSMineShopOrderDetailCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineShopOrderDetailCell.h"

@implementation SSMineShopOrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.header_imageview.layer.cornerRadius = 5;
}

- (void)initCellWithModel:(SSShopOrderGoodsListModel *)goodsModel cellType:(SSMineShopOrderDetailCellType)type
{
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:goodsModel.picUrl] placeholderImage:nil];
    self.title_label.text = goodsModel.goodsName;
    
    if (type == SSMineShopOrderDetailCellTypeYue) {
        self.num_label.text = [NSString stringWithFormat:@"￥%.2f",[goodsModel.price floatValue]];
    }else{
        self.num_label.text = [NSString stringWithFormat:@"%.2f积分",[goodsModel.price floatValue]];
    }
    
    self.number_label.text = [NSString stringWithFormat:@"X%@",goodsModel.number];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
