//
//  SSShopSubmitOrderVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/11.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"
#import "BottomModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, SSShopSubmitOrderVCType)
{
    SSShopSubmitOrderVCJiFen,
    SSShopSubmitOrderVCYuE,
};

@interface SSShopSubmitOrderVC : FZBaseViewController

@property (nonatomic, assign) SSShopSubmitOrderVCType orderType;
@property (nonatomic, strong) NSMutableArray *data_array;
@property (nonatomic, strong) BottomModel *bottomModel;

@property (nonatomic, assign) BOOL isNowBuy;
@end

NS_ASSUME_NONNULL_END
