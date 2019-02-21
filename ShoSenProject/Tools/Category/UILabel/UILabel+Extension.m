

//
//  UILabel+Extension.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/5.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)itemLabelWithFream:(CGRect)fream withTextString:(NSString *)textStr withTextColor:(UIColor *)textColor withFontSize:(CGFloat)size withBold:(BOOL)boldState withTextAlignment:(NSTextAlignment)textAlignment
{
    UILabel * lab = [[UILabel alloc]initWithFrame:fream];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = textStr;
    lab.textColor = textColor;
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:size];
    if (boldState) {
        lab.font = [UIFont boldSystemFontOfSize:size];
    }
    lab.textAlignment = textAlignment;
    return lab;
}

- (UILabel *)labelWithFream:(CGRect)fream withTextString:(NSString *)textStr withTextColor:(UIColor *)textColor withFontSize:(CGFloat)size withBold:(BOOL)boldState withTextAlignment:(NSTextAlignment)textAlignment
{
    UILabel * lab = [[UILabel alloc]initWithFrame:fream];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = textStr;
    lab.textColor = textColor;
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:size];
    if (boldState) {
        lab.font = [UIFont boldSystemFontOfSize:size];
    }
    lab.textAlignment = textAlignment;
    return lab;
}
- (UILabel *)formatlabelWithtext:(NSString *)text frame:(CGRect)frame font:(NSInteger)font textColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor textAlignment:(NSTextAlignment)textAlignment interval:(CGFloat)val
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = textAlignment;
    label.textColor = color;
    label.numberOfLines = 0;
    label.backgroundColor = backgroundColor;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = val;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragraphStyle};
    label.attributedText = [[NSAttributedString alloc]initWithString:label.text attributes:attributes];
    return label;
}
- (void)transFormwithSettingDic:(NSDictionary *)paramDic withchangeColor:(UIColor *)changeColor withChangeFontSize:(CGFloat)changeSize withChangeRange:(NSRange)range
{
    NSDictionary * tempDic = nil;
    if (paramDic == nil) {
        tempDic = @{NSForegroundColorAttributeName : changeColor,
                    NSFontAttributeName : [UIFont systemFontOfSize:changeSize]
                    };
    }else{
        tempDic = paramDic;
    }
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString setAttributes:tempDic range:range];
    self.attributedText = attributedString;
}
- (void)addDeleteLine
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, self.text.length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:rgba(255.0f, 255.0f, 255.0f, 0.5) range:NSMakeRange(0, self.text.length)];
    [self setAttributedText:attri];
}


+ (UILabel*)C:(NSArray*)A;{
    UILabel*lable = [UILabel new];
    lable.font = A[0];
    lable.textColor = A[1];
    if([A[2] isEqualToString:@"0"]){
        lable.textAlignment = NSTextAlignmentLeft;
    }else if([A[2] isEqualToString:@"1"]){
        lable.textAlignment = NSTextAlignmentCenter;
    }else{
        lable.textAlignment = NSTextAlignmentRight;
    }
    if(A.count==4){
        lable.text = A[3];
    }
    //lable.attributedText
    return lable;
}
+ (NSAttributedString*)text:(NSString*)text conditions:(NSArray <NSArray*> *)condition;
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    int startPoint = 0;
    for(int i=0;i<condition.count;i++){
        NSArray*item = condition[i];//长短 颜色 字体
        NSDictionary *nameSubAttributeDict =
        @{ NSForegroundColorAttributeName : item[1],
           NSFontAttributeName : item[2] };
        [attrStr setAttributes:nameSubAttributeDict range:NSMakeRange(startPoint,[item[0] intValue])];
        startPoint = startPoint + [item[0] intValue];
    }
    return attrStr;
}
+ (CGFloat)hight:(NSString*)text font:(UIFont*)font w:(CGFloat)w{
    CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(w, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return tmpRect.size.height+0.5;
}
+ (CGFloat)width:(NSString*)text font:(UIFont*)font h:(CGFloat)h;{
    CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(1000, h) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return tmpRect.size.width+0.5;
}




+ (CGFloat)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText]; NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init]; [paragraphStyle setLineSpacing:space]; [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])]; label.attributedText = attributedString;
    [label sizeToFit];
    
    NSDictionary *dic = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(label.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
+ (CGFloat)changeLineSpaceForLabelRight:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText]; NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    paragraphStyle.alignment = NSTextAlignmentRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
    NSDictionary *dic = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(label.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

+ (CGFloat)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    NSDictionary *dic = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(label.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
+ (CGFloat)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}]; NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init]; [paragraphStyle setLineSpacing:lineSpace]; [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])]; label.attributedText = attributedString;
    [label sizeToFit];
    NSDictionary *dic = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(label.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
    
}
+ (CGFloat)changeSpaceForLabelForMidlle:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;//居中
{
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init]; [paragraphStyle setLineSpacing:lineSpace]; [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])]; label.attributedText = attributedString;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [label sizeToFit];
    NSDictionary *dic = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(label.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

@end
