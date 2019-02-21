//
//  SSShopOrderListViewModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSShopOrderListViewModel : NSObject

//订单列表
- (void)getShopOrderListWithType:(NSInteger )type callback:(void(^)(id  object))block;

//查询订单列表
- (void)searchShopOrderListWithType:(NSInteger )type goodsName:(NSString *)goodsName callback:(void(^)(id  object))block;

//取消订单
- (void)cancelOrderWithOrderID:(NSString *)orderId cancelDescrip:(NSString *)cancelDescrip callback:(void(^)(id  object))block;

//订单详情
- (void)orderDetailWithOrderID:(NSString *)orderID callback:(void(^)(id  object))block;

//确认收货
- (void)confirmReceiveGoodsWithId:(NSString *)orderID callback:(void(^)(id  object))block;

//删除订单
- (void)deleteOrderWithId:(NSString *)orderID callback:(void(^)(id  object))block;
@end

NS_ASSUME_NONNULL_END
