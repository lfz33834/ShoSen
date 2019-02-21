//
//  SSShopOrderListModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopOrderListModel.h"

@implementation SSShopOrderListModel

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"goodsList" : @"SSShopOrderGoodsListModel",
             @"handleOption" : @"SSHandleOptionModel",
             };
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

@end

@implementation SSShopOrderInfoModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"handleOption" : @"SSHandleOptionModel",
             };
}

@end

@implementation SSShopOrderGoodsListModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

@end

@implementation SSHandleOptionModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"deleteType" : @"delete"
             };
}

@end

