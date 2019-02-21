//
//  SSMineShopAllOrderVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SSMineShopAllOrderVCType)
{
    SSMineShopAllOrderVCTypeAll,
    SSMineShopAllOrderVCTypePay,
    SSMineShopAllOrderVCTypeReceive,
    SSMineShopAllOrderVCTypeFinish,
    SSMineShopAllOrderVCTypeCancel,
};

@interface SSMineShopAllOrderVC : FZBaseViewController

@property (nonatomic, assign) SSMineShopAllOrderVCType type;

@end

NS_ASSUME_NONNULL_END
