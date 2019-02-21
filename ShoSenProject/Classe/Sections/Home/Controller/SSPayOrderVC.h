//
//  SSPayOrderVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"
#import "SSShopOrderListModel.h"

typedef NS_ENUM(NSInteger, SSPayOrderVCType)
{
    SSPayOrderVCTypeShopOrder,
    SSPayOrderVCTypeCar,
    SSPayOrderVCTypeRecharge,
};

@interface SSPayOrderVC : FZBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *money_label;
@property (weak, nonatomic) IBOutlet UIImageView *weixin_imageview;
@property (weak, nonatomic) IBOutlet UIButton *weixin_button;
@property (weak, nonatomic) IBOutlet UIImageView *zhifubao_imageview;
@property (weak, nonatomic) IBOutlet UIButton *zhifubao_button;
@property (weak, nonatomic) IBOutlet UIButton *pay_button;
@property (weak, nonatomic) IBOutlet UILabel *title_label;

@property (nonatomic, copy) NSString *money_str;


@property (nonatomic, assign) SSPayOrderVCType viewType;
@property (nonatomic, strong) SSShopOrderListModel *orderModel;

@property (nonatomic, copy) NSString *bookID;
@end
