//
//  SSMineAssetItemCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSMineAssetItemCell.h"

@implementation SSMineAssetItemCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)initCellWithModel:(SSAssetModel *)model index:(NSInteger )index
{
    if (index == 0) {
        self.one_label.textColor = kColor(@"D6B35B");
        self.two_label.textColor = kColor(@"D6B35B");
//        self.three_label.textColor = kColor(@"D6B35B");
        self.foure_label.textColor = kColor(@"D6B35B");
        self.five_label.textColor = kColor(@"D6B35B");
        
        self.one_label.font = [UIFont systemFontOfSize:13];
        self.two_label.font = [UIFont systemFontOfSize:13];
//        self.three_label.font = [UIFont systemFontOfSize:13];
        self.foure_label.font = [UIFont systemFontOfSize:13];
        self.five_label.font = [UIFont systemFontOfSize:13];

        self.one_label.text = @"日期";
        self.two_label.text = @"好友名称";
//        self.three_label.text = @"联系方式";
        self.foure_label.text = @"已支付金额";
        self.five_label.text = @"奖励 资产";

        self.upline_view.hidden = NO;
    }else{
        self.one_label.textColor = kColor(@"333333");
        self.two_label.textColor = kColor(@"333333");
//        self.three_label.textColor = kColor(@"333333");
        self.foure_label.textColor = kColor(@"333333");
        self.five_label.textColor = kColor(@"333333");

        
        self.one_label.font = [UIFont systemFontOfSize:12];
        self.two_label.font = [UIFont systemFontOfSize:12];
//        self.three_label.font = [UIFont systemFontOfSize:12];
        self.foure_label.font = [UIFont systemFontOfSize:12];
        self.five_label.font = [UIFont systemFontOfSize:12];
        
        self.one_label.text = [NSString timestampSwitchTime:model.createTime andFormatter:@"yyyy-MM-dd"];
        self.two_label.text = model.bookName;
//        self.three_label.text = model.bookPhone;
        self.foure_label.text = model.payValue;
        
        if ([model.typeValue intValue] == 0) {
            self.five_label.text = @"---";
        }else{
            self.five_label.text = model.typeValue;
        }

        self.upline_view.hidden = YES;
    }
}

@end
