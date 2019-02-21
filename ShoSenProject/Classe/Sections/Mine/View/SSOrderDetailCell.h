//
//  SSOrderDetailCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSOrderListModel.h"

@interface SSOrderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *phnone_label;
@property (weak, nonatomic) IBOutlet UILabel *location_label;
@property (weak, nonatomic) IBOutlet UILabel *orderno_label;
@property (weak, nonatomic) IBOutlet UILabel *ordertime_label;
@property (weak, nonatomic) IBOutlet UILabel *ordermoney_label;
@property (weak, nonatomic) IBOutlet UILabel *status_label;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;

@property (nonatomic, strong) SSOrderListModel *orderModel;
@end
