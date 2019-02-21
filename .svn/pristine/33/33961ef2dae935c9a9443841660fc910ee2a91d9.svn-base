//
//  SSCircleReportCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSCircleReportCell.h"

@implementation SSCircleReportCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)initCellWithModel:(SSCircleListModel *)model
{
    self.content_label.text = model.name;
    if (model.isSelect) {
        self.left_imageview.image = [UIImage imageNamed:@"mine_order_select"];
    }else{
        self.left_imageview.image = [UIImage imageNamed:@"mine_order_normal"];
    }
}

@end
