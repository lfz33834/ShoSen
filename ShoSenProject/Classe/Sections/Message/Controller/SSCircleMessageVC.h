//
//  SSCircleMessageVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/10/22.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

typedef NS_ENUM(NSInteger,SSCircleMessageVCType)
{
    SSCircleMessageVCTypeMessage,
    SSCircleMessageVCTypeNotices,
};

@interface SSCircleMessageVC : FZBaseViewController

@property (nonatomic, assign) SSCircleMessageVCType type;

@end
