//
//  SSMessageDetailListCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/23.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCircleMessageDetailModel.h"
#import "SSCircleListModel.h"

typedef NS_ENUM(NSInteger, SSMessageDetailType)
{
    SSMessageDetailTypeDel,
    SSMessageDetailTypeCellTap,
};

typedef void(^SSMessageDetailListCellBlock)(SSCircleMessageDetailModel *model, SSMessageDetailType type);

@interface SSMessageDetailListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (nonatomic, strong) SSCircleMessageDetailModel *model;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UITableView *comment_tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableview_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_label_height;
@property (weak, nonatomic) IBOutlet UIButton *dianzan_button;
@property (nonatomic, copy) SSMessageDetailListCellBlock block;
@property (weak, nonatomic) IBOutlet UIButton *del_button;
- (void)initCellWithModel:(SSCircleMessageDetailModel *)model;

@end
