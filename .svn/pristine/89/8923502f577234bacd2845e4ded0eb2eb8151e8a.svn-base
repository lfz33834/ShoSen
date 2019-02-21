//
//  NSAttributedString+ConvenienceInitializer.m
//  qingsongchou
//
//  Created by CaoPing on 15/3/17.
//  Copyright (c) 2015年 qschou. All rights reserved.
//

#import "NSAttributedString+Extension.h"
#import "NSDictionary+Extension.h"
#import "NSParagraphStyle+Extension.h"


@implementation NSAttributedString (Extension)

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                   foregroundColor:(UIColor *)foregroundColor
                                         alignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle *style = [NSParagraphStyle paragraphStyleWithLineSpacing:0];
    style.alignment = alignment;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    return [self attributedStringWithString:string
                                       font:font
                            foregroundColor:foregroundColor
                            backgroundColor:nil
                                       kern:0
                             paragraphStyle:style];
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                   foregroundColor:(UIColor *)foregroundColor
                                       lineSpacing:(CGFloat)lineSpacing
                                     lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self attributedStringWithString:string
                                       font:font
                            foregroundColor:foregroundColor
                            backgroundColor:nil
                                       kern:0
                             paragraphStyle:[NSParagraphStyle paragraphStyleWithLineSpacing:lineSpacing
                                                                              lineBreakMode:lineBreakMode]];
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                   foregroundColor:(UIColor *)foregroundColor
                                   backgroundColor:(UIColor *)backgroundColor
                                              kern:(CGFloat)kern
                                    paragraphStyle:(NSParagraphStyle *)paragraphStyle
{
    if (!string) {
        return nil;
    }
    NSDictionary *attributes = [[NSDictionary attributesForAttributedStringWithFont:font
                                                                    foregroundColor:foregroundColor
                                                                    backgroundColor:backgroundColor
                                                                               kern:kern
                                                                     paragraphStyle:paragraphStyle] copy];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    return attrString;
}

@end
