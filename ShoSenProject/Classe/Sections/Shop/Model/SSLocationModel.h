//
//  SSLocationModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/13.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSLocationModel : NSObject

@property (nonatomic, copy) NSString *area;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *ID;

@end

NS_ASSUME_NONNULL_END
