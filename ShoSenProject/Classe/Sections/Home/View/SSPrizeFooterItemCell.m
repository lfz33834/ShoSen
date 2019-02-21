//
//  SSPrizeFooterItemCell.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/16.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSPrizeFooterItemCell.h"

@implementation SSPrizeFooterItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)initCellWithModel:(SSPrizeModel *)model
{
    NSString *phoneString = [model.phone stringByReplacingCharactersInRange:NSMakeRange(2, 7) withString:@"***"];
    _phone_label.text = phoneString;
    
    WEAKSELF
    NSArray *dataArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"jiangpin"];
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj[@"dicCode"] isEqualToString:model.rewardTitle])
        {
            NSArray *contentArray = [obj[@"dicValue"] componentsSeparatedByString:@","];
           if (contentArray.count == 2) {
               weakSelf.content_label.text = [NSString stringWithFormat:@"%@%@",contentArray[0],contentArray[1]];
           }else{
               weakSelf.content_label.text = obj[@"dicValue"];
           }
//            weakSelf.content_label.text = obj[@"dicValue"];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
