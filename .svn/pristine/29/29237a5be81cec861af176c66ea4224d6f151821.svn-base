//
//  SSLoginVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/6.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

typedef NS_ENUM(NSInteger, SSLoginVCFrom)
{
    SSLoginVCFromSetting,
    SSLoginVCFromOther,
};

typedef void(^SSLoginVCBlock)(void);

@interface SSLoginVC : FZBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *wechat_button;

@property (nonatomic, copy) SSLoginVCBlock block;

@property (nonatomic, assign) SSLoginVCFrom fromVC;

@end
