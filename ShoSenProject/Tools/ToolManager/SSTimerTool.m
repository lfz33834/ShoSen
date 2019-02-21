//
//  SSTimerTool.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/12/21.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "SSTimerTool.h"

@interface SSTimerTool()

@property (nonatomic, strong)dispatch_source_t timer;
@property (nonatomic, assign) int timeType;

@end

@implementation SSTimerTool

+(instancetype)share
{
    static SSTimerTool * timer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timer = [[SSTimerTool alloc]init];
    });
    return timer;
}
- (void)newTimer:(NSTimeInterval)pramTime isTimeType:(NSString *)type isTime:(BOOL)state resultBlock:(void (^)(NSString *))resultBlock
{
    weak_Self(self);
    if (pramTime <= 0) {
        return;
    }
    __block NSTimeInterval tempVal = pramTime;
    dispatch_queue_t queue = dispatch_queue_create("gcdTimer", DISPATCH_QUEUE_CONCURRENT);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0);
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(_timer, start, interval, 0);
    dispatch_source_set_event_handler(_timer, ^{
        tempVal--;
        NSString * resultStr = @"";
        if (state) {
            resultStr = [weakSelf countdowntTime:tempVal withType:type];
        }else{
            resultStr = [NSString stringWithFormat:@"%ld",[[NSString stringWithFormat:@"%f",tempVal] integerValue]];
        }
        if (tempVal <= 0) {
            [weakSelf descorveryTimer];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            resultBlock(resultStr);
        });
    });
    dispatch_resume(_timer);
}
-(void)createTimer:(NSTimeInterval)pramTime isTime:(BOOL)state resultBlock:(void (^)(NSString *))resultBlock
{
    [self newTimer:pramTime isTimeType:@"1" isTime:state resultBlock:resultBlock];
}

-(void)createTimer:(NSTimeInterval)pramTime isTimeType:(NSString *)typeStr isTime:(BOOL)state resultBlock:(void (^)(NSString *))resultBlock
{
    //  4天时分  1 时分秒 2 时分  3分秒
    [self newTimer:pramTime isTimeType:typeStr isTime:state resultBlock:resultBlock];
}

- (void)descorveryTimer
{
    if (_timer) {
        dispatch_source_cancel(self.timer);
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
}
- (NSString *)countdowntTime:(NSTimeInterval)paramVal withType:(NSString *)type
{
    NSInteger tempVal = [[NSString stringWithFormat:@"%f",paramVal] integerValue];
//    NSString *str_hour = [NSString stringWithFormat:@"%02ld",tempVal/3600];//时

    NSString *str_hour = [NSString stringWithFormat:@"%02ld",tempVal/3600];//时
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(tempVal%3600)/60];//分
    NSString *str_second = [NSString stringWithFormat:@"%02ld",tempVal%60];//秒
    NSString *format_time_1 = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    NSString *format_time_2 = [NSString stringWithFormat:@"%@:%@",str_hour,str_minute];
    NSString *format_time_3 = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    NSString *format_time_4 = [NSString stringWithFormat:@"%ld",(long)tempVal];
    
    if ([type isEqualToString:@"1"]) {
        return format_time_1;
    }else if ([type isEqualToString:@"2"])
    {
        return format_time_2;
    }else if ([type isEqualToString:@"3"]){
        return format_time_3;
    }
    return format_time_4;
}
-(void)dealloc
{
    [self descorveryTimer];
}

@end
