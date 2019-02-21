//
//  SSConfirmOrderDetailVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"
#import "SSOrderListModel.h"

@interface SSConfirmOrderDetailVC : FZBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *pay_button;
@property (weak, nonatomic) IBOutlet UILabel *money_label;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *phone_label;
@property (weak, nonatomic) IBOutlet UILabel *location_label;
@property (nonatomic, strong) SSOrderListModel *model;
@end
