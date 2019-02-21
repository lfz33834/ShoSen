//
//  SSCircleFriendRecommendCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/30.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCircleListModel.h"

typedef NS_ENUM(NSInteger, SSCircleFriendRecommendCellType) {
    SSCircleFriendRecommendCellTypeTuiJian,
    SSCircleFriendRecommendCellTypeGuanzhu,
    SSCircleFriendRecommendCellTypeFans,
};

typedef void(^SSCircleFriendRecommendCellBlock)(SSCircleListModel *model);

@interface SSCircleFriendRecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIButton *guanzhu_button;
@property (nonatomic, strong) SSCircleListModel *model;
@property (nonatomic, assign) SSCircleFriendRecommendCellType type;

@property (nonatomic, copy) SSCircleFriendRecommendCellBlock block;

- (void)initCellWithModel:(SSCircleListModel *)model;

@end
