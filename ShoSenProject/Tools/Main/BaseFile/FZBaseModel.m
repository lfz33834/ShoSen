//
//  FZBaseModel.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "FZBaseModel.h"

@implementation FZBaseModel
MJCodingImplementation

//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{@"ID" : @"id"
//             };
//}

//+ (NSDictionary *)objectClassInArray
//{
//    return @{
//             @"attachment" : @"QSCPublicDetailDict"
//             };
//}

//+ (instancetype)share {
//    static self *manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[[self class] alloc] init];
//    });
//    return manager;
//}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//
//}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    unsigned int count = 0;
//    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
//
//    for (int i = 0 ; i < count; i ++)
//    {
//        objc_property_t pro = propertyList[i];
//        const char *name = property_getName(pro);
//        NSString *key = [NSString stringWithUTF8String:name];
//        if ([aDecoder decodeObjectForKey:key])
//        {
//            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
//        }
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    unsigned int count = 0;
//    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
//    for (int i = 0; i < count; i++)
//    {
//        objc_property_t pro = propertyList[i];
//        const char *name = property_getName(pro);
//        NSString *key = [NSString stringWithUTF8String:name];
//        [aCoder encodeObject:[self valueForKey:key] forKey:key];
//    }
//}

@end
