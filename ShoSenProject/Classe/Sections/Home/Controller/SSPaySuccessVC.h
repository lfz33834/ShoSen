//
//  SSPaySuccessVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/17.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

typedef NS_ENUM(NSInteger,SSPaySuccessVCType ) {
    SSPaySuccessVCTypeShopOrder,
    SSPaySuccessVCTypeCar,
};

@interface SSPaySuccessVC : FZBaseViewController

@property (nonatomic, assign) SSPaySuccessVCType vcType;
@property (weak, nonatomic) IBOutlet UIView *center_view;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *subTitle_label;
@property (weak, nonatomic) IBOutlet UIButton *checkOrder_button;

@end
