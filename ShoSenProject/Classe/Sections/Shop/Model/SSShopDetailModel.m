//
//  SSShopDetailModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/10.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSShopDetailModel.h"

@implementation SSShopDetailModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"productList" : @"SSProductListModel",
             };
}

@end

@implementation SSProductListModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

@end

@implementation SSGoodSInfoModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"
             };
}

@end
