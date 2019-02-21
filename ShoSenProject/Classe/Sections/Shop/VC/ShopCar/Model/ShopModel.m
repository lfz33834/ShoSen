//
//  ShopModel.m
//  ShopCarDemo
//
//  Created by 周智勇 on 16/7/25.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id",
             @"shopTitle" : @"goodsName",
             @"singlePrice" : @"price",
             @"count" : @"number",
             };
}

@end
