//
//  SSCircleMessageCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/22.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCircleListModel.h"

@interface SSCircleMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIImageView *right_imageview;
@property (weak, nonatomic) IBOutlet UIImageView *dianzan_imageview;
@property (weak, nonatomic) IBOutlet UILabel *content_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *right_label;

@property (nonatomic, strong) SSCircleListModel *model;

- (void)initCellWithListModel:(SSCircleListModel *)listModel;

@end
