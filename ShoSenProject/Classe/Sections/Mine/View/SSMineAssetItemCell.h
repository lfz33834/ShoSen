//
//  SSMineAssetItemCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/11/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPerkDetailListModel.h"
#import "SSAssetModel.h"

@interface SSMineAssetItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *upline_view;
@property (weak, nonatomic) IBOutlet UIView *downline_view;
@property (weak, nonatomic) IBOutlet UILabel *one_label;
@property (weak, nonatomic) IBOutlet UILabel *two_label;
@property (weak, nonatomic) IBOutlet UILabel *three_label;
@property (weak, nonatomic) IBOutlet UILabel *foure_label;
@property (weak, nonatomic) IBOutlet UILabel *five_label;

- (void)initCellWithModel:(SSAssetModel *)model index:(NSInteger )index;

@end
