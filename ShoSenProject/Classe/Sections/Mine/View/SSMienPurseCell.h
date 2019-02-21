//
//  SSMienPurseCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/21.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMyPurseListModel.h"

typedef NS_ENUM(NSInteger ,SSMienPurseCellType)
{
    SSMienPurseCellTypeYue,
    SSMienPurseCellTypeJiFen,
};

NS_ASSUME_NONNULL_BEGIN

@interface SSMienPurseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *time_lable;
@property (weak, nonatomic) IBOutlet UILabel *num_label;

- (void)initCellWithModel:(SSMyPurseListModel *)model cellType:(SSMienPurseCellType)type;

@end

NS_ASSUME_NONNULL_END
