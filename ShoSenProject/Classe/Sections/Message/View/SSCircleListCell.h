//
//  SSCircleListCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/22.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

typedef NS_ENUM(NSInteger, SSCircleListCellType) {
   SSCircleListCellTypeMessage,
    SSCircleListCellTypeDianzan,
    SSCircleListCellTypeUserInfo,
    SSCircleListCellTypeUserDel,
    SSCircleListCellTypeUserZhanKai,
};

#import "SSCircleListImageCell.h"
#import <UIKit/UIKit.h>
#import "SSCircleListModel.h"
typedef void(^SSCircleListCellBlock)(SSCircleListCellType cellType, SSCircleListModel *model,NSInteger index);

@interface SSCircleListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_lable;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet UICollectionView *image_collection;
@property (weak, nonatomic) IBOutlet UILabel *location_label;
@property (weak, nonatomic) IBOutlet UIButton *message_button;
@property (weak, nonatomic) IBOutlet UIButton *dianzan_button;
@property (weak, nonatomic) IBOutlet UIView *bg_view;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *location_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_view_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *message_button_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dianzan_button_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_label_height;
@property (nonatomic, copy) SSCircleListCellBlock block;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bg_view_height;
@property (weak, nonatomic) IBOutlet UIButton *del_button;

@property (weak, nonatomic) IBOutlet UIButton *zhankai_button;
@property (nonatomic, strong) SSCircleListModel *model;

@property (nonatomic, assign) NSInteger index;
- (void)initCellWithModel:(SSCircleListModel *)model index:(NSInteger)index;
@end
