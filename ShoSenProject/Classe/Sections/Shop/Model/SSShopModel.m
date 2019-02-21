//
//  SSShopModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopModel.h"

@implementation SSShopModel

//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{@"ID" : @"id"
//             };
//}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"banner" : @"SSShopBannerModel",
             @"floorGoodsList" : @"SSFloorGoodsList"
             };
}

@end

@implementation SSShopBannerModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

@end

@implementation SSFloorGoodsList

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"goodsList" : @"SSGoodsListModel"
             };
}

@end

@implementation SSGoodsListModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

@end

