//
//  SSMyPurseViewModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/24.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSMyPurseViewModel : NSObject

- (void)myPurseYueCallback:(void(^)(id  object))block;

- (void)myPurseJiFenCallback:(void(^)(id  object))block;

- (void)chargeMoneyWithMoney:(NSString *)money callback:(void(^)(id  object))block;


@end

NS_ASSUME_NONNULL_END
