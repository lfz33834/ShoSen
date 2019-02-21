//
//  SSPayFailureVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/19.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

typedef NS_ENUM(NSInteger, SSPayFailureVCType)
{
    SSPayFailureVCTypeShopOrder,
    SSPayFailureVCTypeCar,
};

@interface SSPayFailureVC : FZBaseViewController

@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UIButton *lookButton;
@property (nonatomic, assign) SSPayFailureVCType vcType;

@end
