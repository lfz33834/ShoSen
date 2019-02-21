//
//  SSMessageDetailCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/23.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCircleListModel.h"

@interface SSMessageDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UICollectionView *image_collection;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomview_height;
@property (weak, nonatomic) IBOutlet UIButton *dianzan_button;
@property (weak, nonatomic) IBOutlet UILabel *loction_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *location_lable_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_label_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionimage_height;

@property (nonatomic, strong) SSCircleListModel *model;
- (void)initCellWithModel:(SSCircleListModel *)model;

@end
