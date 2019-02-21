//
//  SSShopViewModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSShopViewModel : NSObject

//获取商品列表
- (void)feltShopDataCallback:(void(^)(id object))callBack;

//获取商品列表
- (void)feltShopDetailDataWithID:(NSString *)ID Callback:(void(^)(id object))callBack;

//购物车的数量
- (void)getGoodsCountCallback:(void(^)(id object))callBack;

//添加购物车
- (void)addCarWithUserId:(NSString *)userId goodsId:(NSString *)goodsId num:(NSString *)num productId:(NSString *)productId countCallback:(void(^)(id object))callBack;

//购物车列表
- (void)shopCarListCallback:(void(^)(id object))callBack;

//购物车加减号修改
- (void)updateShopGoodsNumWithId:(NSString *)ID goodsId:(NSString*)goodsId number:(NSString *)number productId:(NSString *)productId callback:(void(^)(id object))callBack;

//删除订单
- (void)deleteOrderWithProductIds:(NSMutableArray *)productIds callback:(void(^)(id object))callBack;

//获取地址
- (void)locationListCallback:(void(^)(id object))callBack;

//保存地址
- (void)saveLocationWithID:(NSString *)Id name:(NSString *)name mobile:(NSString *)mobile provinceId:(NSString *)provinceId cityId:(NSString *)cityId areaId:(NSString *)areaId address:(NSString *)address isdefault:(int)isdefault callback:(void(^)(id object))callBack;

//删除地址
- (void)delteLocationWithID:(NSString *)ID callback:(void(^)(id object))callBack;

//选中计算费用
- (void)selectCheckedWithProductIds:(NSMutableArray *)productIds callback:(void(^)(id object))callBack;

//下单
- (void)creatOrderWithAddressId:(NSString *)addressId productIds:(NSMutableArray*)productIds integralPrice:(NSString *)integralPrice money:(NSString *)money actualPrice:(NSString *)actualPrice isNowBuy:(BOOL)isNowBuy   callback:(void(^)(id object))callBack;

//支付
//下单支付
- (void)payOrderWithOrderId:(NSString *)orderId payType:(NSString *)payType total:(NSString *)total callback:(void(^)(id object))callBack;

//立即购买
- (void)atOnceBuyCarWithGoodsId:(NSString *)goodsId productId:(NSString *)productId callback:(void(^)(id object))callBack;

@end

NS_ASSUME_NONNULL_END
