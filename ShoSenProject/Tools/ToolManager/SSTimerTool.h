//
//  SSTimerTool.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/21.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSTimerTool : NSObject

//获取单利对象
+ (instancetype)share;
//创建一个timer
-(void)createTimer:(NSTimeInterval)pramTime isTime:(BOOL)state resultBlock:(void (^)(NSString *))resultBlock;
//创建一个timer
-(void)createTimer:(NSTimeInterval)pramTime isTimeType:(NSString *)typeStr isTime:(BOOL)state resultBlock:(void (^)(NSString *))resultBlock;

@end

NS_ASSUME_NONNULL_END
