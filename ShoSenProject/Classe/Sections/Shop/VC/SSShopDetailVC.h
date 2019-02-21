//
//  SSShopDetailVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SSShopDetailVCType)
{
    SSShopDetailVCTypeJiFen,
    SSShopDetailVCTypeMoney,
};

@interface SSShopDetailVC : FZBaseViewController

@property (nonatomic, copy) NSString *goodID;
@property (nonatomic, assign) SSShopDetailVCType vcType;

@end

NS_ASSUME_NONNULL_END
