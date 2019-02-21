//
//  SSOrderListPayCell.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSOrderListModel.h"

typedef void(^OrderListPayBlock)(SSOrderListModel *model);

@interface SSOrderListPayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *status_label;
@property (weak, nonatomic) IBOutlet UIImageView *header_imageview;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIButton *pay_button;
@property (weak, nonatomic) IBOutlet UIView *paycell_view;
@property (nonatomic, copy) OrderListPayBlock block;

@property (nonatomic, strong) SSOrderListModel *listModel;


@end
