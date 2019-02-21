//
//  NSMutableAttributedString+zhou.m
//  label
//
//  Created by Alvin on 14-6-27.
//  Copyright (c) 2014年 aimeizhuyi. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)


/**
 *  五段文字不同颜色字体大小设置
 *
 *  @param font1  第一段文字的font
 *  @param color1 第一段文字的color
 *  @param font2  第二段文字的font
 *  @param color2 第二段文字的color
 *  @param font3  第三段文字的font
 *  @param color3 第三段文字的color
 *  @param text1  第一段文字内容
 *  @param text2  第二段文字内容
 *  @param text3  第三段文字内容
 *  @param text4  第四段文字内容
 *  @param text5  第四段文字内容
 
 *
 *  @return NSMutableAttributedString 类型文本
 */

+ (NSMutableAttributedString *)attributeStringWithFont1:(UIFont *)font1
                                                 color1:(UIColor *)color1
                                                  Font2:(UIFont *)font2
                                                 color2:(UIColor *)color2
                                                  Font3:(UIFont *)font3
                                                 color3:(UIColor *)color3
                                                  Font4:(UIFont *)font4
                                                 color4:(UIColor *)color4
                                                  Font5:(UIFont *)font5
                                                 color5:(UIColor *)color5
                                                  text1:(NSString *)text1
                                                  text2:(NSString *)text2
                                                  text3:(NSString *)text3
                                                  text4:(NSString *)text4
                                                  text5:(NSString *)text5
{
    
    NSDictionary *normalFont = [NSDictionary dictionaryWithObjectsAndKeys:font1, NSFontAttributeName, color1,
                                NSForegroundColorAttributeName, nil];
    
    NSDictionary *otherFont = [NSDictionary dictionaryWithObjectsAndKeys:font2, NSFontAttributeName, color2,
                               NSForegroundColorAttributeName, nil];
    
    NSDictionary *thirdFont = [NSDictionary dictionaryWithObjectsAndKeys:font3, NSFontAttributeName, color3,
                               NSForegroundColorAttributeName, nil];
    
    NSDictionary *fourthFont = [NSDictionary dictionaryWithObjectsAndKeys:font4, NSFontAttributeName, color4,
                                NSForegroundColorAttributeName, nil];
    
    NSDictionary *fiveFont = [NSDictionary dictionaryWithObjectsAndKeys:font5, NSFontAttributeName, color5,
                                NSForegroundColorAttributeName, nil];
    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    if (text1.length && text2.length && text3.length && text4.length && text5.length) {
        
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:text1 attributes:normalFont];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:text2 attributes:otherFont];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:text3 attributes:thirdFont];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:text4 attributes:fourthFont];
    NSAttributedString *str5 = [[NSAttributedString alloc] initWithString:text5 attributes:fiveFont];
    
    [str appendAttributedString:str1];
    [str appendAttributedString:str2];
    [str appendAttributedString:str3];
    [str appendAttributedString:str4];
    [str appendAttributedString:str5];
    }
    return str;
    
}



/**
 *  四段文字不同颜色字体大小设置
 *
 *  @param font1  第一段文字的font
 *  @param color1 第一段文字的color
 *  @param font2  第二段文字的font
 *  @param color2 第二段文字的color
 *  @param font3  第三段文字的font
 *  @param color3 第三段文字的color
 *  @param text1  第一段文字内容
 *  @param text2  第二段文字内容
 *  @param text3  第三段文字内容
 *  @param text4  第四段文字内容
 *
 *  @return NSMutableAttributedString 类型文本
 */

+ (NSMutableAttributedString *)attributeStringWithFont1:(UIFont *)font1
                                                 color1:(UIColor *)color1
                                                  Font2:(UIFont *)font2
                                                 color2:(UIColor *)color2
                                                  Font3:(UIFont *)font3
                                                 color3:(UIColor *)color3
                                                  Font4:(UIFont *)font4
                                                 color4:(UIColor *)color4
                                                  text1:(NSString *)text1
                                                  text2:(NSString *)text2
                                                  text3:(NSString *)text3
                                                  text4:(NSString *)text4
{
    
    NSDictionary *normalFont = [NSDictionary dictionaryWithObjectsAndKeys:font1, NSFontAttributeName, color1,
                                NSForegroundColorAttributeName, nil];
    
    NSDictionary *otherFont = [NSDictionary dictionaryWithObjectsAndKeys:font2, NSFontAttributeName, color2,
                               NSForegroundColorAttributeName, nil];
    
    NSDictionary *thirdFont = [NSDictionary dictionaryWithObjectsAndKeys:font3, NSFontAttributeName, color3,
                               NSForegroundColorAttributeName, nil];
    
    NSDictionary *fourthFont = [NSDictionary dictionaryWithObjectsAndKeys:font4, NSFontAttributeName, color4,
                               NSForegroundColorAttributeName, nil];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:text1 attributes:normalFont];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:text2 attributes:otherFont];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:text3 attributes:thirdFont];
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:text4 attributes:fourthFont];
    
    [str appendAttributedString:str1];
    [str appendAttributedString:str2];
    [str appendAttributedString:str3];
    [str appendAttributedString:str4];
    return str;
    
}




/**
 *  三段文字不同颜色字体大小设置
 *
 *  @param font1  第一段文字的font
 *  @param color1 第一段文字的color
 *  @param font2  第二段文字的font
 *  @param color2 第二段文字的color
 *  @param font3  第三段文字的font
 *  @param color3 第三段文字的color
 *  @param text1  第一段文字内容
 *  @param text2  第二段文字内容
 *  @param text3  第三段文字内容
 *
 *  @return NSMutableAttributedString 类型文本
 */

+ (NSMutableAttributedString *)attributeStringWithFont1:(UIFont *)font1
                                                 color1:(UIColor *)color1
                                                  Font2:(UIFont *)font2
                                                 color2:(UIColor *)color2
                                                  Font3:(UIFont *)font3
                                                 color3:(UIColor *)color3
                                                  text1:(NSString *)text1
                                                  text2:(NSString *)text2
                                                  text3:(NSString *)text3
{
    text1 = text1?text1:@"";
    text2 = text2?text2:@"";
    text3 = text3?text3:@"";

    NSDictionary *normalFont = [NSDictionary dictionaryWithObjectsAndKeys:font1, NSFontAttributeName, color1,
       NSForegroundColorAttributeName, nil];
    
    NSDictionary *otherFont = [NSDictionary dictionaryWithObjectsAndKeys:font2, NSFontAttributeName, color2,
     NSForegroundColorAttributeName, nil];
    
    NSDictionary *thirdFont = [NSDictionary dictionaryWithObjectsAndKeys:font3, NSFontAttributeName, color3,
                               NSForegroundColorAttributeName, nil];
    

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:text1 attributes:normalFont];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:text2 attributes:otherFont];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:text3 attributes:thirdFont];
    
    [str appendAttributedString:str1];
    [str appendAttributedString:str2];
    [str appendAttributedString:str3];
    return str;
 
}

/**
 *  两段文字不同颜色字体大小设置
 *
 *  @param font1  第一段文字的font
 *  @param color1 第一段文字的color
 *  @param font2  第二段文字的font
 *  @param color2 第二段文字的color
 *  @param text1  第一段文字内容
 *  @param text2  第二段文字内容
 *
 *  @return NSMutableAttributedString 类型文本
 */

+ (NSMutableAttributedString *)attributeStringWithFont1:(UIFont *)font1
                                                 color1:(UIColor *)color1
                                                  Font2:(UIFont *)font2
                                                 color2:(UIColor *)color2
                                                  text1:(NSString *)text1
                                                  text2:(NSString *)text2
{

    NSDictionary *normalFont = [NSDictionary dictionaryWithObjectsAndKeys:font1, NSFontAttributeName, color1,
                                NSForegroundColorAttributeName, nil];
    
    NSDictionary *otherFont = [NSDictionary dictionaryWithObjectsAndKeys:font2, NSFontAttributeName, color2,
                               NSForegroundColorAttributeName, nil];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str1;
    if (text1) {
         str1 = [[NSAttributedString alloc] initWithString:text1 attributes:normalFont];
        [str appendAttributedString:str1];


    }
    NSAttributedString *str2;
    if (text2) {
         str2 = [[NSAttributedString alloc] initWithString:text2 attributes:otherFont];
        [str appendAttributedString:str2];
    }
    
    
    
  
    return str;
    
}

/**
 *  拼接两段文字
 *
 *  @param text1 第一段文本内容
 *  @param text2 第二段文本内容
 *
 *  @return NSMutableAttributedString 类型文本
 */

+ (NSMutableAttributedString *)attributeStringWithText1:(NSString *)text1 text2:(NSString *)text2

{
    NSDictionary *normalFont = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18], NSFontAttributeName,
                                [UIColor colorWithRed:123/255.0 green:119/255.0 blue:116/255.0 alpha:1.0], NSForegroundColorAttributeName, nil];
    
    NSDictionary *otherFont = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName,
                               [UIColor colorWithRed:162/255.0 green:157/255.0 blue:154/255.0 alpha:1.0], NSForegroundColorAttributeName, nil];
    
  
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:text1 attributes:normalFont];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:text2 attributes:otherFont];
    
    [str appendAttributedString:str1];
    [str appendAttributedString:str2];

    return str;

}








@end
