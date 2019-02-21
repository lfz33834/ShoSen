//
//  NSDate+Extend.h
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/*
 *  时间戳
 */
@property (nonatomic,copy,readonly) NSString *timestamp;



/*
 *  时间成分
 */
@property (nonatomic,strong,readonly) NSDateComponents *components;




/*
 *  是否是今年
 */
@property (nonatomic,assign,readonly) BOOL isThisYear;




/*
 *  是否是今天
 */
@property (nonatomic,assign,readonly) BOOL isToday;




/*
 *  是否是昨天
 */
@property (nonatomic,assign,readonly) BOOL isYesToday;




/**
 *  两个时间比较
 *
 *  @param unit     成分单元
 *  @param fromDate 起点时间
 *  @param toDate   终点时间
 *
 *  @return 时间成分对象
 */
+(NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+(BOOL )isValidTime:(NSString *)timestamps withSeconds:(NSInteger)seconds;

+ (NSString *)changeNumsTimeHour:(NSString *)time;
+ (NSString *)changeNumsTimeForYMD:(NSString *)time;
+ (NSDate *)changeNumsTimeForYMD_ss:(NSString *)time;

// String Formate
- (NSString *)stringByDateFormat:(NSString *)dateFormat;
- (NSString *)string;
/*! yyyy/mm/dd 形式*/
- (NSString *)stringByInsurance;

- (NSString *)stringBySlashing;

- (NSString *)stringFromNow;
/*! yyyy-mm-dd 形式*/
- (NSString *)shortStringByLine;

- (NSString *)shortStringByString;
// 时间差

- (NSString *)intervalStringFromNow;
- (NSString *)timeIntervalDescription;

/*! 周1 12-12 形式*/
- (NSString *)billDateFormat;
/*! 12-12 形式*/
+ (NSString *)billDateFormatMMDD:(NSString *)time;
//利用时间戳来准确计算某个时间点具现在的时间差
- (NSString *)intervalSinceNow: (NSString *) theDate;
//  跟服务器时间对比多少天后
+ (NSString *)intervalSinceNow:(NSString *)Now toDate:(NSString *) theDate;


@end
