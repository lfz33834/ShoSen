//
//  NSString+Extension.m
//  qingsongchou
//
//  Created by bluehedgehog on 16/5/23.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import "NSString+Extension.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)
/**
 
 *是否包含表情符号
 
 */
+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}


- (BOOL)validateIDCardNumber {
    NSString *value = self;
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSUInteger length = 0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41",@"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year %4 == 0 || (year %100 == 0 && year %4 == 0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 == 0 || (year %100 == 0 && year %4 == 0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                     
                                                                          error:nil];//测试出生日期的合法性
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                
                NSString *JYM1 =@"10x98765432";
                NSString *M1 = [JYM1 substringWithRange:NSMakeRange(Y,1)];
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]|| [M1 isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

- (BOOL)validatePhone{

    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";

    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isValidateEmail{
    //    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *emailRegex = @"^[a-z0-9A-Z]+([\\-_\\.][a-z0-9A-Z]+)*@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)*?\\.)+[a-zA-Z]{2,4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


- (BOOL)isUsername
{
    if ([self isValidOnlyLettersAndNumbers] && [self isValidWithMinimumCharacters:5 maximumCharacters:20]) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)isPassword
{
    if ([self isValidOnlyLettersAndNumbers] && [self isValidWithMinimumCharacters:8 maximumCharacters:20]) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)isValidOnlyLettersAndNumbers
{
    NSString *LNRegex = @"^[A-Z0-9a-z]+$"; // only letters and numbers.
    NSPredicate *LNTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", LNRegex];
    return [LNTest evaluateWithObject:self];
}


- (BOOL)isValidWithRegexString:(NSString *)regexString
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSInteger num_matches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return (num_matches == 1);
}

NSInteger const kValidationIgnoreLengthConstraint = -1;

- (BOOL)isValidWithMinimumCharacters:(NSInteger)minimumCharacters maximumCharacters:(NSInteger)maximumCharacters
{
    BOOL min_valid = YES;
    BOOL max_valid = YES;
    if (minimumCharacters == kValidationIgnoreLengthConstraint) {
        min_valid = YES;
    } else if (minimumCharacters >= 0) {
        (self.length >= minimumCharacters) ? (min_valid = YES) : (min_valid = NO);
    }
    
    if (maximumCharacters == kValidationIgnoreLengthConstraint) {
        max_valid = YES;
    } else if (maximumCharacters >= 0) {
        (self.length <= maximumCharacters) ? (max_valid = YES) : (max_valid = NO);
    }
    
    if (min_valid == YES && max_valid == YES) {
        return YES;
    } else {
        return NO;
    }
}


//判断是否为整形：
- (BOOL)isPureInts{
    
    if (self.length >= 3) {
        
        //.00后端返回 当做整形处理
        NSString *subString = [self substringFromIndex:self.length -3];
        if ([subString isEqualToString:@".00"]) {
            return YES;
        }
    }
    
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
- (BOOL)isPureFloat{
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


//银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber
{
    NSString *regex2 = @"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

+ (BOOL) matchNumbersInTextfield:(NSString*)text
{
    NSString *numbersRegex= @"^[1-9]?[0-9]{0,100}[.]?[0-9]?[0-9]?$";
    NSPredicate *numbersRule = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numbersRegex];
    
    return [numbersRule evaluateWithObject:text];
}


+ (BOOL) validateOnlyNumber: (NSString *)text{
    NSString *soliderIDRegex = @"^[1-9][0-9]{0,}$";
    NSPredicate *soliderID = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",soliderIDRegex];
    
    return [soliderID evaluateWithObject:text];
}


#pragma mark xxx


//文字拼接方法
- (NSString *)filenameAppend:(NSString *)append
{
    //1获取有拓展名的文件名
    NSString *filename = [self stringByDeletingPathExtension];
    
    //2拼接append
    filename = [filename stringByAppendingString:append];
    
    //3得到拓展名
    NSString *pathExtension = [self pathExtension];
    
    //拼接上拓展名
    return [filename stringByAppendingPathExtension:pathExtension];
    
    
}



-(id)JSONValue;
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return result;
}

#pragma mark 属性相关

-(UIColor *)tintColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setTintColor:(UIColor *)tintColor{
    objc_setAssociatedObject(self, @selector(tintColor), tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - trim whitespace

- (NSString *)stringByTrimmingWhitespace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)stringByTrimmingLeadingWhitespace
{
    NSInteger i = 0;
    
    while ((i < [self length])
           && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
        i++;
    }
    return [self substringFromIndex:i];
}

- (NSString *)stringByTrimmingLeadingAndTrailingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - trim whitespace and newline

- (NSString *)stringByTrimmingWhitespaceAndNewline
{
    return [[self trimmingBackslashNR] stringByTrimmingWhitespace];
}

- (NSString *)stringByTrimmingLeadingAndTrailingWhitespaceAndNewline
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - trim html tags

- (NSString *)stringByTrimmingHTMLTags
{
    NSRange r;
    NSString *s = self;
    while ((r = [s rangeOfString:@"<[^>]+>|&[^;]+;" options:NSRegularExpressionSearch]).location != NSNotFound){
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    }
    return s;
}

- (NSString *)trimmingBackslashNR
{
    NSString *str = self;
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    return str;
}

#pragma mark 解析相关

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}

- (NSString *)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}

- (NSDate *)dateFromDateStringTimezone:(NSString *)timezone
{
    //2014-06-03 15:44:47 PRC
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (timezone && timezone.length == 3) {
        NSTimeZone *timeZone=[NSTimeZone timeZoneWithAbbreviation:timezone];//PRC是表示取中国时区
        [dateFormatter setTimeZone:timeZone];
    }
    
    NSDate *date = [dateFormatter dateFromString:self];
    
    return date;
}


/*
 *  时间戳对应的NSDate
 */
-(NSDate *)date{
    
    NSTimeInterval timeInterval=self.floatValue;
    
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}


+(NSString *)timestampSwitchTime:(NSString*)timestamp andFormatter:(NSString *)format
{
    // timeStampString 是服务器返回的13位时间戳
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timestamp doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

#pragma mark - 将某个时间戳转化成 时间

- (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSLog(@"1296035591  = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}

- (NSInteger)getAgeWithCardNum:(NSString *)idCardNum
{
    // 年份
    int strYear = [[idCardNum substringWithRange:NSMakeRange(6, 4)] intValue];
    // 月份
    int strMonth = [[idCardNum substringWithRange:NSMakeRange(10, 2)] intValue];
    // 日
    int strDay = [[idCardNum substringWithRange:NSMakeRange(12, 2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                strYear, strMonth, strDay]];
    
    MYLog(@"%@",date);
    
    NSInteger age =  [self ageWithDateOfBirth:date];
    return age;
}

- (int)getBirthDataNum:(NSString *)idCardNum
{
    // 年份
    int strYear = [[idCardNum substringWithRange:NSMakeRange(6, 4)] intValue];
    // 月份
    int strMonth = [[idCardNum substringWithRange:NSMakeRange(10, 2)] intValue];
    // 日
    int strDay = [[idCardNum substringWithRange:NSMakeRange(12, 2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr =[NSString stringWithFormat:@"%d-%d-%d 12:01",
                                                strYear, strMonth, strDay];
   return  (int)[self getUTCFormateDate:dateStr];
    
}

-(int )getUTCFormateDate:(NSString *)newsDate
{
    //    newsDate = @"2013-08-09 17:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSLog(@"newsDate = %@",newsDate);
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    int month=((int)time)/(3600*24*30);
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    
    NSString *dateContent;
    
    if(month!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",month,@"个月前"];
        
    }else if(days!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",days,@"天前"];
    }else if(hours!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",hours,@"小时前"];
    }else {
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",minute,@"分钟前"];
    }
    
    //    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    
    
     return days;
}


- (NSInteger)ageWithDateOfBirth:(NSDate *)date;
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}


-  (int)stringConvertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    
    return (strlength+1)/2;
}

+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    for(int i = 0; i<CC_MD2_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (BOOL)cp_containsString:(NSString *)aString
{
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:aString];
    }
    return [self rangeOfString:aString].location != NSNotFound;
}

- (NSMutableAttributedString*)stringToAtrribute

{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    return str;
}

//慎用
- (int )blankToString
{
    int num = 0;
    NSMutableString *str = [[NSMutableString alloc] initWithString:self];
    NSString *search = @"\n";
    NSString *replace = @"a";
    NSRange substr = [str rangeOfString:search];
    
    while (substr.location != NSNotFound) {
        [str replaceCharactersInRange:substr withString:replace];
        substr = [str rangeOfString:search];
        num ++;
    }
    
    return num;
}

- (CGFloat)calculateHeightWithWidth:(CGFloat)width Font:(CGFloat)font
{
    return [self calculateSizeWithWidth:width Font:font].height;
}
- (CGSize)calculateSizeWithWidth:(CGFloat)width Font:(CGFloat)font
{
    CGSize size = CGSizeMake(width, 0);
    CGSize tempSize;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    tempSize = [self boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return tempSize;
}


#pragma mark --- 根据身份证号码来获取年龄
- (NSTimeInterval)ageForUserCardNum:(NSString *)idCardNum
{
    // 年份
    NSInteger strYear = [[idCardNum substringWithRange:NSMakeRange(6, 4)] intValue];
    // 月份
    NSInteger strMonth = [[idCardNum substringWithRange:NSMakeRange(10, 2)] intValue];
    // 日
    NSInteger strDay = [[idCardNum substringWithRange:NSMakeRange(12, 2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *brithDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 12:01:01",
                                                     (long)strYear, (long)strMonth, (long)strDay]];
    
    
    NSTimeInterval brithSecends = [brithDate timeIntervalSinceNow];
    if (brithSecends < 0) {
        brithSecends = brithSecends * (-1);
    }else {
        brithSecends = brithSecends * (1);
    }
    
    return brithSecends;
}


/**
 *  32位MD5加密
 */
-(NSString *)md5{
    
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result copy];
}




/**
 *  SHA1加密
 */
-(NSString *)sha1{
    
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result copy];
}



#pragma mark size 
+(CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font  maxSize:(CGSize)maxSize{
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [text boundingRectWithSize:maxSize
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    rect.size.height += 1;
    textSize = rect.size;
    return textSize;
}


+(CGSize)sizeForNoticeTitle:(NSString*)text font:(UIFont*)font  maxSize:(CGSize)maxSize spacing:(CGFloat)spacing
{
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    [style setLineSpacing:spacing];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [text boundingRectWithSize:maxSize
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    rect.size.height += 1;
    textSize = rect.size;
    return textSize;
}


- (NSMutableAttributedString*)stringToAttribute

{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    return str;
}


+ (NSString *)HideNumberWithPhone:(NSString *)phoneNum
{
    if (phoneNum.length == 11) {
        NSString *rangeStr = [phoneNum substringWithRange:NSMakeRange(3, 4)];
        return [phoneNum stringByReplacingOccurrencesOfString:rangeStr withString:@"****" options:NSCaseInsensitiveSearch range:NSMakeRange(3, 4)];
    }else if(phoneNum.length >4){
        NSString *rangeStr = [phoneNum substringWithRange:NSMakeRange(0, phoneNum.length-4)];
        NSMutableString *replacingStr = [NSMutableString string];
        for (int i = 0 ; i< rangeStr.length; i++) {
            [replacingStr appendString:@"*"];
        }
        return [phoneNum stringByReplacingOccurrencesOfString:rangeStr withString:replacingStr options:NSCaseInsensitiveSearch range:NSMakeRange(0, phoneNum.length-4)];
    }else{ // 直接显示
        return phoneNum;
    }
}

+ (NSString *)getCurentTimeDate
{
    NSDate *senddate = [NSDate date];
    
    MYLog(@"date1时间戳 = %ld",time(NULL));
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    MYLog(@"date2时间戳 = %@",date2);
    
//    NSDateFormatter *dateformatter = [[NSDateFormatteralloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString *date1 = [dateformatter stringFromDate:senddate];
//    NSLog(@"获取当前时间   = %@",date1);
//    
//    // 时间戳转时间
//    NSDate *confromTimesp = [NSDatedateWithTimeIntervalSince1970:[senddate timeIntervalSince1970]];
//    NSString *confromTimespStr = [dateformatterstringFromDate:confromTimesp];
//    NSLog(@"时间戳转时间   = %@",confromTimespStr);
//    
//    // 两个时间戳的间隔   返回的是秒
//    NSTimeInterval time = [now timeIntervalSinceDate:oldDate];
//    NSLog(@"time:%f",time/60/60/24);
    
    return date2;

}


+(NSString *)ChangeNumberFormat:(NSString *)num
{
    if (!num.length) {
        return @"";
    }
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}



//字典转化成json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}


+(NSString *)replaceUnicode:(NSString*)unicodeStr{
    NSString *tempStr1=[unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2=[tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3=[[@"\"" stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData=[tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr =[NSPropertyListSerialization propertyListFromData:tempData
                                                          mutabilityOption:NSPropertyListImmutable
                                                                    format:NULL
                                                          errorDescription:NULL];

    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
//    const char *jsonString = [unicodeStr UTF8String];   // goodStr 服务器返回的 json
//    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
//    NSString *goodMsg1 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
//
//    return goodMsg1;
    
    
}


+ (NSString *)removeFloatAllZero:(NSString *)string{
    NSString * testNumber = string;
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    //价格格式化显示
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString * formatterString = [formatter stringFromNumber:[NSNumber numberWithFloat:[outNumber doubleValue]]];
    //获取要截取的字符串位置
    NSRange range = [formatterString rangeOfString:@"."];
    if (range.length >0 ) {
        NSString * result = [formatterString substringFromIndex:range.location];
        if (result.length >= 4) {
            formatterString = [formatterString substringToIndex:formatterString.length - 1];
        }
    }
    return  formatterString;
}


@end
