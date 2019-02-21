//
//  SSShopOrderListVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"

typedef NS_ENUM(NSInteger, SSShopOrderListVCType)
{
    SSShopOrderListVCTypeAll,//0:全部
    SSShopOrderListVCTypePay,//1:未支付
    SSShopOrderListVCTypeReceive,//3:待收货
    SSShopOrderListVCTypeFinish,//5:已完成
    SSShopOrderListVCTypeCancel,//6:已取消
};

NS_ASSUME_NONNULL_BEGIN

@interface SSShopOrderListVC : FZBaseViewController

@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
