//
//  SSShopViewModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopViewModel.h"

@implementation SSShopViewModel

//获取商品列表
- (void)feltShopDataCallback:(void(^)(id object))callBack
{
 
    NSString *shopUrl = [NSString stringWithFormat:@"%@/wx/home/index",OrderBaseUrl];
    [FZHttpTool get:shopUrl parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//获取商品列表
- (void)feltShopDetailDataWithID:(NSString *)ID Callback:(void(^)(id object))callBack
{
    NSString *shopUrl = [NSString stringWithFormat:@"%@/wx/goods/detail?id=%@",OrderBaseUrl,ID];
    [FZHttpTool get:shopUrl parameters:nil isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//购物车的数量
- (void)getGoodsCountCallback:(void(^)(id object))callBack
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    SSAccount * account = [SSAccountTool share].account;
    params[@"userId"] = account.uid;
    [FZHttpTool get:kShopCarGoodsNumUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}


//添加购物车
- (void)addCarWithUserId:(NSString *)userId goodsId:(NSString *)goodsId num:(NSString *)num productId:(NSString *)productId countCallback:(void(^)(id object))callBack
{
    SSAccount * account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = account.uid;
    params[@"goodsId"] = @([goodsId intValue]);
    params[@"number"] = @([num intValue]);
    params[@"productId"] = @([productId intValue]);

    [FZHttpTool post:kShopAddCarUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//购物车列表
- (void)shopCarListCallback:(void(^)(id object))callBack
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = account.uid;
    [FZHttpTool get:kShopCarUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//购物车加减号修改
- (void)updateShopGoodsNumWithId:(NSString *)ID goodsId:(NSString*)goodsId number:(NSString *)number productId:(NSString *)productId callback:(void(^)(id object))callBack
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"id"] = [NSNumber numberWithInt: [ID intValue]];
    params[@"userId"] = [NSNumber numberWithInt: [account.uid intValue]];
    params[@"goodsId"] = [NSNumber numberWithInt: [goodsId intValue]] ;
    params[@"number"] = [NSNumber numberWithInt: [number intValue]];
    params[@"productId"] = [NSNumber numberWithInt: [productId intValue]];

    [FZHttpTool post:kShopCartUpdateUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//删除订单
- (void)deleteOrderWithProductIds:(NSMutableArray *)productIds callback:(void(^)(id object))callBack
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = account.uid;
    params[@"productIds"] = productIds;
    
    [FZHttpTool post:kShopCartDeleteUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}


//获取地址
- (void)locationListCallback:(void(^)(id object))callBack
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = account.uid;
    [FZHttpTool get:kShopLocationListUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//保存地址
- (void)saveLocationWithID:(NSString *)Id name:(NSString *)name mobile:(NSString *)mobile provinceId:(NSString *)provinceId cityId:(NSString *)cityId areaId:(NSString *)areaId address:(NSString *)address isdefault:(int)isdefault callback:(void(^)(id object))callBack
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = [NSNumber numberWithInt:[account.uid intValue]];
    if (Id.length > 0) {
        params[@"id"] = [NSNumber numberWithInt:[Id intValue]];
    }else{
        params[@"id"] = @0;
    }
    params[@"name"] = name;
    params[@"mobile"] = mobile;
    params[@"provinceId"] = provinceId;
    params[@"cityId"] = cityId;
    params[@"areaId"] = areaId;
    params[@"address"] = address;
    params[@"isDefault"] = [NSNumber numberWithInt:isdefault];

    [FZHttpTool post:kShopAddLocationUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//删除地址
- (void)delteLocationWithID:(NSString *)ID callback:(void(^)(id object))callBack
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = account.uid;
    params[@"id"] = ID;

    [FZHttpTool post:kShopDeleteLocationUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//选中计算费用
- (void)selectCheckedWithProductIds:(NSMutableArray *)productIds callback:(void(^)(id object))callBack
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = account.uid;
    params[@"isChecked"] = @1;
    params[@"productIds"] = productIds;

    [FZHttpTool post:kShopCartCheckedrUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//   orderType:integral 积分
//orderType:balance 余额
//orderType:actual 现金
//orderType:blend 余额+现金

//下单
- (void)creatOrderWithAddressId:(NSString *)addressId productIds:(NSMutableArray*)productIds integralPrice:(NSString *)integralPrice money:(NSString *)money actualPrice:(NSString *)actualPrice isNowBuy:(BOOL)isNowBuy   callback:(void(^)(id object))callBack
{
//
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = [NSNumber numberWithInt:[account.uid intValue]];
    params[@"userPhone"] = account.phone;
    params[@"addressId"] = [NSNumber numberWithInt:[addressId intValue]];
    params[@"cartId"] = @0;
    params[@"couponId"] = @0;
    params[@"message"] = @"";
    params[@"grouponRulesId"] = @0;
    params[@"grouponLinkId"] = @0;
    params[@"integralPrice"] = [NSNumber numberWithInt:[integralPrice intValue]];
    params[@"money"] = money;
    params[@"actualPrice"] = actualPrice;
    params[@"productIds"] = productIds;
    
    if (isNowBuy) {
        params[@"isBuy"] = [NSNumber numberWithInt:1];
    }else{
        params[@"isBuy"] = [NSNumber numberWithInt:0];
    }
    
    
    if ([integralPrice intValue] > 0) {
        params[@"orderType"] = @"integral";
    }else{
        if([money intValue] > 0 && [actualPrice intValue] > 0)
        {
            params[@"orderType"] = @"blend";
        }else if([money intValue] == 0 && [actualPrice intValue] > 0){
            params[@"orderType"] = @"actual";
        }else if([money intValue] > 0 && [actualPrice intValue] == 0){
            params[@"orderType"] = @"balance";
        }
    }
    [FZHttpTool post:kShopOrderSubmitUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//下单支付
- (void)payOrderWithOrderId:(NSString *)orderId payType:(NSString *)payType total:(NSString *)total callback:(void(^)(id object))callBack
{
//    支付宝:aliPay
//    微信:wxAppPay
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = account.uid;
    params[@"orderId"] = orderId;
    params[@"payType"] = payType;
    params[@"totalFee"] = total;
    [FZHttpTool post:kShopPayOrderUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//立即购买
- (void)atOnceBuyCarWithGoodsId:(NSString *)goodsId productId:(NSString *)productId callback:(void(^)(id object))callBack
{
    SSAccount *account = [SSAccountTool share].account;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"userId"] = account.uid;
    params[@"goodsId"] = goodsId;
    params[@"number"] = @"1";
    params[@"productId"] = productId;
    [FZHttpTool post:kShopFastAddUrl parameters:params isShowHUD:YES httpToolSuccess:^(id  _Nullable json) {
        callBack(json);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
