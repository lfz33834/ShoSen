//
//  SSHomeViewModel.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/14.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSHomeModel.h"

@interface SSHomeViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

//咨询列表
- (void)newsCallBack:(void(^)(id json))back;

//获奖列表
- (void)prizeListCallBack:(void(^)(id json))back;

//获得奖项
- (void)feltPrizeWithPhoneCallBack:(void(^)(id json))back;

//奖品列表
- (void)gameRewardListWithPhoneCallBack:(void(^)(id json))back;

//抽奖次数接口
- (void)gameintReTimeWithPhoneCallBack:(void(^)(id json))back;

//抽奖的说明
- (void)prizeGameInfoCallBack:(void(^)(id json))back;

//中奖名单接口
- (void)gamerewardRecordCallBack:(void(^)(id json))back;

- (void)homeSignInWithPhoneCallBack:(void(^)(id json))back;

- (void)psqLookinWithModel:(NSMutableArray *)dataArray callBack:(void(^)(id json))back;

@end
