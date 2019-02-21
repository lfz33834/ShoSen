//
//  SSShopCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopCell.h"

@implementation SSShopCell

- (void)initCellWithModel:(SSGoodsListModel *)model section:(NSInteger )section
{
    self.title_label.text = model.name;
    if (section == 1) {
        self.subtitle_label.text = [NSString stringWithFormat:@"%.2f积分",[model.retailPrice floatValue]];
    }else{
        self.subtitle_label.text = [NSString stringWithFormat:@"￥%.2f",[model.retailPrice floatValue]];
    }
    [self.header_imageview sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
}

@end
