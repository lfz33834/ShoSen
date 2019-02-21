//
//  NSDate+Extend.m
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import "NSDate+Extension.h"
#import "NSDateFormatter+Extension.h"

@interface NSDate ()


/*
 *  清空时分秒，保留年月日
 */
@property (nonatomic,strong,readonly) NSDate *ymdDate;

@end
@implementation NSDate (Extension)


/*
 *  时间戳
 */
-(NSString *)timestamp{

    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f",timeInterval];
    
    return [timeString copy];
}

/*
 *  时间成分
 */
-(NSDateComponents *)components{
    
    //创建日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    
    //定义成分
    NSCalendarUnit unit=NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    return [calendar components:unit fromDate:self];
}

/*
 *  是否是今年
 */
-(BOOL)isThisYear{
    
    //取出给定时间的components
    NSDateComponents *dateComponents=self.components;
    
    //取出当前时间的components
    NSDateComponents *nowComponents=[NSDate date].components;
    
    //直接对比年成分是否一致即可
    BOOL res = dateComponents.year==nowComponents.year;
    
    return res;
}


/*
 *  是否是今天
 */
-(BOOL)isToday{

    //差值为0天
    return [self calWithValue:0];
}


/*
 *  是否是昨天
 */
-(BOOL)isYesToday{
    
    //差值为1天
    return [self calWithValue:1];
}


-(BOOL)calWithValue:(NSInteger)value{
    
    //得到给定时间的处理后的时间的components
    NSDateComponents *dateComponents=self.ymdDate.components;
    
    //得到当前时间的处理后的时间的components
    NSDateComponents *nowComponents=[NSDate date].ymdDate.components;
    
    //比较
    BOOL res=dateComponents.year==nowComponents.year && dateComponents.month==nowComponents.month && (dateComponents.day + value)==nowComponents.day;
    
    return res;
}

/*
 *  清空时分秒，保留年月日
 */
-(NSDate *)ymdDate{
    
    //定义fmt
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    
    //设置格式:去除时分秒
    fmt.dateFormat=@"yyyy-MM-dd";
    
    //得到字符串格式的时间
    NSString *dateString=[fmt stringFromDate:self];
    
    //再转为date
    NSDate *date=[fmt dateFromString:dateString];
    
    return date;
}


/**
 *  两个时间比较
 *
 *  @param unit     成分单元
 *  @param fromDate 起点时间
 *  @param toDate   终点时间
 *
 *  @return 时间成分对象
 */
+(NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    
    //创建日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    
    //直接计算
    NSDateComponents *components = [calendar components:unit fromDate:fromDate toDate:toDate options:0];
    
    return components;
}

+(BOOL )isValidTime:(NSString *)timestamps withSeconds:(NSInteger)seconds;
{
//    MYLog(@"\n系统时间- %@ \n保存时间- %@",[NSDate date].timestamp,timestamps);
    BOOL isTime =  ([[NSDate date].timestamp integerValue] - [timestamps integerValue]) > seconds;
    return !isTime;
}



+ (NSString *)changeNumsTimeHour:(NSString *)time
{//1396454400
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd hh:mm"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

+ (NSString *)changeNumsTimeForYMD:(NSString *)time
{//1396454400
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}


+ (NSDate *)changeNumsTimeForYMD_ss:(NSString *)time
{//1396454400
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
//    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimesp;
}




- (NSString *)stringByDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    return [formatter stringFromDate:self];
}

- (NSString *)stringByInsurance
{
    return [self stringByDateFormat:@"yyyy-MM-dd HH:mm"];//@"yyyy-MM-dd HH:mm:ss zzz"
}

- (NSString *)string
{
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    return [self stringByDateFormat:@"yyyy-MM-dd HH:mm:ss"];//@"yyyy-MM-dd HH:mm:ss zzz"
}

/*! yyyy/mm/dd 形式*/
- (NSString *)stringBySlashing{
    return [self stringByDateFormat:@"yyyy/MM/dd"];//@"yyyy-MM-dd HH:mm:ss zzz"
}
/*! yyyy-mm-dd 形式*/
- (NSString *)shortStringByLine{
    return [self stringByDateFormat:@"yyyy-MM-dd"];//@"yyyy-MM-dd HH:mm:ss zzz"
}

/*! yyyy-mm-dd 形式*/
- (NSString *)shortStringByString{
    return [self stringByDateFormat:@"MM月dd日"];//@"yyyy-MM-dd HH:mm:ss zzz"
}

/*! 周1 12-12 形式*/
- (NSString *)billDateFormat{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil ];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    
    NSString *weekString =  [weekdays objectAtIndex:theComponents.weekday];
    
    NSString *date = [self stringByDateFormat:@"MM-dd"];
    
    return [NSString stringWithFormat:@"%@%@",weekString,date];
}


+ (NSString *)billDateFormatMMDD:(NSString *)time
{//1396454400
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}


#pragma mark -

- (NSString *)stringFromNow
{
    NSDate *now = [NSDate date];
    int interval = [now timeIntervalSinceDate:self];
    
    NSString *timeStamp = nil;
    if (interval < 60) {
        //一分钟内显示刚刚
        timeStamp = [NSString stringWithFormat:@"刚刚"];
    }else if(60<=interval && interval<60*60){
        //一分钟以上且一个小时之内的，显示“多少分钟前”，例如“5分钟前”
        timeStamp = [NSString stringWithFormat:@"%i分钟前",interval/60];
    }else if (60*60<=interval && interval<60*60*24*3){
        //1小时以上三天以内的显示“今天/昨天/前天+具体时间”
        NSString *dayStr ;
        int gapDay = interval/(60*60*24) ;
        switch (gapDay) {
            case 0:
            {
                //在24小时内,存在跨天的现象. 判断两个时间是否在同一天内.
                BOOL idSameDay = [NSDate isSameDay:now date2:self];
                if (idSameDay == YES) {
                    dayStr = @"";
                    //                    dayStr = [NSString stringWithFormat:@"今天"];
                }else{
                    dayStr = [NSString stringWithFormat:@"昨天"];
                }
            }
                break;
            case 1:
                dayStr = [NSString stringWithFormat:@"昨天"];
                break;
            case 2:
                dayStr = [NSString stringWithFormat:@"前天"];
                break;
            default:
                break;
        }
        //    timeStamp = [dayStr stringByAppendingString:[DSUtils smallTimewithTimeStr:timeStrs]];
        timeStamp = [NSString stringWithFormat:@"%@%@",dayStr,[self stringBy24HourClockFormatterInOneDay]];
    }else{
        //前天以后的显示"日期+具体时间",如"2月11日 20:19"
        //        timeStamp = [NSString stringWithString:[self stringByChineseCalendarFormatter]];
        timeStamp = [self stringByDateFormat:@"yyyy-MM-dd"];
    }
    return [timeStamp copy];
}

//返回"日期+具体时间",如"2月11日 20:19"
- (NSString *)stringByChineseCalendarFormatter
{
    NSCalendarUnit unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *timeComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:self];
    
    if (timeComponents.year != nowComponents.year) {
        return [self stringByDateFormat:@"YY年MM月dd日"];
    }else{
        return [self stringByDateFormat:@"MM月dd日"];//@"MM月dd日 HH:mm:ss"
    }
}

//返回时间所在日期当天的准确时间. (20:19)
- (NSString *)stringBy24HourClockFormatterInOneDay
{
    return [self stringByDateFormat:@" HH:mm:ss"];
}

//判断两个日期是否是同一天
+ (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year] == [comp2 year];
}


- (NSString *)intervalStringFromNow
{
    NSUInteger unitFlags = NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:unitFlags
                                                                   fromDate:[NSDate date]
                                                                     toDate:self
                                                                    options:0];
    
    NSInteger days = [difference day];
    if (days>0) {
        return [@"" stringByAppendingFormat:@"%ld天",days];
    }
    
    NSInteger hour = [difference hour];
    if (hour>0) {
        return [@"" stringByAppendingFormat:@"%ld小时",hour];
    }
    
    NSInteger minute = [difference minute];
    if (minute>0) {
        return [@"" stringByAppendingFormat:@"%ld分钟",minute];
    }
    
    NSInteger second = [difference second];
    if (second>0) {
        return [@"" stringByAppendingFormat:@"%ld秒",second];
    }
    
    return @"";
}

- (NSString *)timeIntervalDescription
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:@"%.f天前", timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"M月d日"];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:@"%.f年前", timeInterval / 31536000];
    }
}

- (NSString *)intervalSinceNow:(NSString *) theDate // 时间差，精确到秒
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d  timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    timeString=[NSString stringWithFormat:@"%.0f",cha];
    
    //
    //    if (cha/3600<1) {
    //        timeString = [NSString stringWithFormat:@"%f", cha];
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //        timeString=[NSString stringWithFormat:@"%@秒前", timeString];
    //
    //    }
    //
    //    if (cha/3600<1) {
    //        timeString = [NSString stringWithFormat:@"%f", cha/60];
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    //
    //    }
    //    if (cha/3600>1&&cha/86400<1) {
    //        timeString = [NSString stringWithFormat:@"%f", cha/3600];
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    //    }
    //    if (cha/86400>1)
    //    {
    //        timeString = [NSString stringWithFormat:@"%f", cha/86400];
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    //    }
    return timeString;
}


+ (NSString *)intervalSinceNow:(NSString *)Now toDate:(NSString *) theDate // 时间差，精确到秒
{
    NSDate *d= [NSDate changeNumsTimeForYMD_ss:theDate];
    
    NSTimeInterval late=[d  timeIntervalSince1970]*1;
    NSDate* dat = [NSDate changeNumsTimeForYMD_ss:Now];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=late -now;
        if (cha/86400>1)
        {
            timeString = [NSString stringWithFormat:@"%f", cha/86400];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@天后", timeString];
        }else{
        
            timeString = [[theDate date]shortStringByLine];
        }
    return timeString;
}







@end
