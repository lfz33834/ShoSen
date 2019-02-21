//
//  SSShopOrderListViewModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderListViewModel.h"

@implementation SSShopOrderListViewModel

//订单列表
- (void)getShopOrderListWithType:(NSInteger )type callback:(void(^)(id  object))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"userId":account.uid,@"showType":[NSNumber numberWithInteger:type]};
    [FZHttpTool get:kShopOrderListUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        block(json);
    } failure:^(NSError *error) {
    }];
}

//查询订单列表
- (void)searchShopOrderListWithType:(NSInteger )type goodsName:(NSString *)goodsName callback:(void(^)(id  object))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"userId":account.uid,@"showType":[NSNumber numberWithInteger:type],@"goodsName":goodsName};
    [FZHttpTool get:kSearchShopOrderListUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        block(json);
    } failure:^(NSError *error) {
    }];
}



//取消订单
- (void)cancelOrderWithOrderID:(NSString *)orderId cancelDescrip:(NSString *)cancelDescrip callback:(void(^)(id  object))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"userId":account.uid,@"orderId":orderId,@"userPhone":account.phone,@"cancelDescrip":cancelDescrip};
    [FZHttpTool post:kShopcCancelOrdeUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        block(json);
    } failure:^(NSError *error) {
    }];
}

//订单详情
- (void)orderDetailWithOrderID:(NSString *)orderID callback:(void(^)(id  object))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"userId":account.uid,@"orderId":orderID};
    [FZHttpTool get:kShopcOrderDetailUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        block(json);
    } failure:^(NSError *error) {
        
    }];
}


//确认收货
- (void)confirmReceiveGoodsWithId:(NSString *)orderID callback:(void(^)(id  object))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"userId":account.uid,@"orderId":orderID};
    [FZHttpTool post:kShopcOrderConfirmReceiveUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        block(json);
    } failure:^(NSError *error) {
    }];
}

//删除订单
- (void)deleteOrderWithId:(NSString *)orderID callback:(void(^)(id  object))block
{
    SSAccount *account = [SSAccountTool share].account;
    NSDictionary *params = @{@"userId":account.uid,@"orderId":orderID};
    [FZHttpTool post:kShopcOrderDeleteUrl parameters:params isShowHUD:YES httpToolSuccess:^(id json) {
        block(json);
    } failure:^(NSError *error) {
    }];
}

@end
