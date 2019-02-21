//
//  NSParagraphStyle+ConvenienceInitializer.m
//  qingsongchou
//
//  Created by CaoPing on 15/3/17.
//  Copyright (c) 2015年 qschou. All rights reserved.
//

#import "NSParagraphStyle+Extension.h"

@implementation NSParagraphStyle (Extension)

+ (NSMutableParagraphStyle *)paragraphStyleWithLineSpacing:(CGFloat)lineSpacing
{
    return [self paragraphStyleWithLineSpacing:lineSpacing
                                 lineBreakMode:NSLineBreakByWordWrapping
                           firstLineHeadIndent:0
                             minimumLineHeight:0];
}

+ (NSMutableParagraphStyle *)paragraphStyleWithLineSpacing:(CGFloat)lineSpacing
                                             lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self paragraphStyleWithLineSpacing:lineSpacing
                                 lineBreakMode:lineBreakMode
                           firstLineHeadIndent:0
                             minimumLineHeight:0];
}

+ (NSMutableParagraphStyle *)paragraphStyleWithLineSpacing:(CGFloat)lineSpacing
                                             lineBreakMode:(NSLineBreakMode)lineBreakMode
                                       firstLineHeadIndent:(CGFloat)firstLineHeadIndent
                                         minimumLineHeight:(CGFloat)minimumLineHeight
{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.lineBreakMode = lineBreakMode;
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    minimumLineHeight>0 ? paragraphStyle.minimumLineHeight = minimumLineHeight : 0;
    paragraphStyle.paragraphSpacing = 0;
    
    return paragraphStyle;
}

@end
