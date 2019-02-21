//
//  SSMineShopOrderDetailVC.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/12.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseViewController.h"
#import "SSShopOrderListModel.h"

typedef void(^SSMineShopOrderDetailVCBlock)(NSString *contectStr);

NS_ASSUME_NONNULL_BEGIN

@interface SSMineShopOrderDetailVC : FZBaseViewController

@property (nonatomic, strong) SSShopOrderListModel *orderModel;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) SSMineShopOrderDetailVCBlock block;

@end

NS_ASSUME_NONNULL_END
