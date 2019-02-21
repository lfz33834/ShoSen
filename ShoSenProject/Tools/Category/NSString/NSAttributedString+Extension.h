//
//  NSAttributedString+ConvenienceInitializer.h
//  qingsongchou
//
//  Created by CaoPing on 15/3/17.
//  Copyright (c) 2015年 qschou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Extension)

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                   foregroundColor:(UIColor *)foregroundColor
                                         alignment:(NSTextAlignment)alignment;

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                   foregroundColor:(UIColor *)foregroundColor
                                       lineSpacing:(CGFloat)lineSpacing
                                     lineBreakMode:(NSLineBreakMode)lineBreakMode;

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                   foregroundColor:(UIColor *)foregroundColor
                                   backgroundColor:(UIColor *)backgroundColor
                                              kern:(CGFloat)kern
                                    paragraphStyle:(NSParagraphStyle *)paragraphStyle;
@end
