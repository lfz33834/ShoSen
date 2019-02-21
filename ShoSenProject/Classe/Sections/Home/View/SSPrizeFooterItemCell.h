//
//  SSPrizeFooterItemCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/16.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPrizeModel.h"

@interface SSPrizeFooterItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phone_label;
@property (weak, nonatomic) IBOutlet UILabel *content_label;

@property (nonatomic, strong) SSPrizeModel *model;
- (void)initCellWithModel:(SSPrizeModel *)model;

@end
