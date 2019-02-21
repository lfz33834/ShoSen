//
//  NSDictionary+QueryString.m
//  qingsongchou
//
//  Created by CaoPing on 15/3/9.
//  Copyright (c) 2015年 qschou. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSString *)queryString
{
    NSString *queryString = @"";
    for (NSString *qValue in self) {
        if (queryString.length > 0) {
            queryString = [queryString stringByAppendingString:@"&"];
        }
        NSString *qStr = [qValue stringByAppendingFormat:@"=%@",self[qValue]];
        
        queryString = [queryString stringByAppendingString:qStr];
    }
    
    return queryString;
}

- (NSString *)jsonEncodedString
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    
    if (error) {
        return @"";
    }
    
    NSString *encodedString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return encodedString;
}



+ (NSMutableDictionary *)attributesForAttributedStringWithFont:(UIFont *)font
                                               foregroundColor:(UIColor *)foregroundColor
                                               backgroundColor:(UIColor *)backgroundColor
                                                          kern:(CGFloat)kern
                                                paragraphStyle:(NSParagraphStyle *)paragraphStyle
{
    NSMutableDictionary *attributes = [@{} mutableCopy];
    attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    attributes[NSFontAttributeName] = font;
    attributes[NSKernAttributeName] = [NSNumber numberWithFloat:kern];
    foregroundColor ? attributes[NSForegroundColorAttributeName] = foregroundColor : nil;
    backgroundColor ? attributes[NSBackgroundColorAttributeName] = backgroundColor : nil;
    return attributes;
}

+ (NSDictionary *)attributesForAttributedString:(UIFont *)font
                                foregroundColor:(UIColor *)foregroundColor
                                backgroundColor:(UIColor *)backgroundColor
                                           kern:(CGFloat)kern
                                 paragraphStyle:(NSParagraphStyle *)paragraphStyle
                                  hasDeleteline:(BOOL)hasDeleteline
                                   hasUnderline:(BOOL)hasUnderline
                                    strokeColor:(UIColor *)strokeColor
                                    strokeWidth:(CGFloat)strokeWidth
                                         shadow:(NSShadow *)shadow
                                 superscripting:(CGFloat)superscripting
{
    NSMutableDictionary *attributes = [@{} mutableCopy];
    
    //字体
    attributes[NSFontAttributeName] = font;
    //段落样式
    attributes[NSParagraphStyleAttributeName] = paragraphStyle ? paragraphStyle:[NSParagraphStyle defaultParagraphStyle];
    //文字色
    attributes[NSForegroundColorAttributeName] = foregroundColor;
    //背景区域色
    backgroundColor ? attributes[NSBackgroundColorAttributeName] = backgroundColor:nil;
    //连字
    attributes[NSLigatureAttributeName] = @1;
    //文间距
    attributes[NSKernAttributeName] = [NSNumber numberWithFloat:kern];
    //删除线
    attributes[NSStrikethroughStyleAttributeName] = hasDeleteline ? @1:@0;
    //下划线
    attributes[NSUnderlineStyleAttributeName] = hasUnderline ? @1:@0;
    //描边颜色
    strokeColor ? attributes[NSStrokeColorAttributeName] = strokeColor:nil;
    //描边线条粗细，正数描边，负数描边加填满
    attributes[NSStrokeWidthAttributeName] = [NSNumber numberWithFloat:strokeWidth];
    //阴影 NSShadow
    shadow ? attributes[NSShadowAttributeName] = shadow:nil;
    //水平0与垂直1排列，在iOS中，永远处于水平排列
    attributes[NSVerticalGlyphFormAttributeName] = @0;
    //下标 与 上标
    if (superscripting==-1||superscripting==1) {
        attributes[(NSString*)kCTSuperscriptAttributeName] = [NSNumber numberWithFloat:superscripting];
    }
    
    //ios7新增
    
    //文本特效 NSTextEffectLetterpressStyle凸版印刷效果
    attributes[NSTextEffectAttributeName] = nil;
    //附件 NSTextAttachment对象
    attributes[NSAttachmentAttributeName] = nil;
    //超链接 NSURL(优先) 或者 NSString 对象
    attributes[NSLinkAttributeName] = nil;
    //基线偏移
    attributes[NSBaselineOffsetAttributeName] = [NSNumber numberWithFloat:0];
    
    //下划线颜色,默认为nil,取foreground color
    attributes[NSUnderlineColorAttributeName] = nil;
    //删除线颜色,默认为nil,取foreground color
    attributes[NSStrikethroughColorAttributeName] = nil;
    
    //倾斜
    attributes[NSObliquenessAttributeName] = [NSNumber numberWithFloat:0];
    //扩展
    attributes[NSExpansionAttributeName] = [NSNumber numberWithFloat:0];
    //书写方向
    //    attributes[NSWritingDirectionAttributeName] = @[@0,@1,@2,@3];
    
    return attributes;
}
@end
