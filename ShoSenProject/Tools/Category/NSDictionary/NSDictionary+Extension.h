//
//  NSDictionary+QueryString.h
//  qingsongchou
//
//  Created by CaoPing on 15/3/9.
//  Copyright (c) 2015年 qschou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "NSParagraphStyle+Extension.h"

@interface NSDictionary (Extension)

- (NSString *)queryString;
- (NSString *)jsonEncodedString;

+ (NSMutableDictionary *)attributesForAttributedStringWithFont:(UIFont *)font
                                               foregroundColor:(UIColor *)foregroundColor
                                               backgroundColor:(UIColor *)backgroundColor
                                                          kern:(CGFloat)kern
                                                paragraphStyle:(NSParagraphStyle *)paragraphStyle;

@end
