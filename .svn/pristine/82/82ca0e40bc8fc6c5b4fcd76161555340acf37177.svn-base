//
//  UILabel+size.m
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "UILabel+size.h"

@implementation UILabel (size)

-(CGSize)sizeOfMultiLineLabel{
    
    NSAssert(self, @"UILabel was nil");
    
    NSString *aLabelTextString = [self text];
    
    UIFont *aLabelFont = [self font];
    
    CGFloat aLabelSizeWidth = self.frame.size.width;
    
    if (iOS7) {
        //version >= 7.0
        
        return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{
                                                        NSFontAttributeName : aLabelFont
                                                        }
                                              context:nil].size;
    }
    return [self bounds].size;
}
+(CGSize)siezeOfMultiLineLabelWithText:(NSString *)text font:(UIFont *)font labelWidth:(CGFloat)labelWidth{
    NSString *aLabelTextString = text;
    
    UIFont *aLabelFont = font;
    
    CGFloat aLabelSizeWidth = labelWidth;
    
    
    return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName : aLabelFont
                                                    }
                                          context:nil].size;
}
+ (CGSize)siezeOfSingleLineLabelWithText:(NSString *)text
                                    font:(UIFont *)font
                             labelHeight:(CGFloat)labelHeight{
    NSString *aLabelTextString = text;
    
    UIFont *aLabelFont = font;
    
    CGFloat aLabelSizeHeight = labelHeight;
    
    
    return [aLabelTextString boundingRectWithSize:CGSizeMake(MAXFLOAT, aLabelSizeHeight)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName : aLabelFont
                                                    }
                                          context:nil].size;
}
+ (UILabel *)setLabelWithFrame:(CGRect)frame font:(UIFont*)font text:(NSString*)text textColor:(UIColor *)textColor textAlignment:(NSInteger)textAlignment
{
    CGRect tempFrame;
    if(frame.origin.x == 0 && textAlignment==NSTextAlignmentLeft){
        tempFrame = CGRectMake(0, frame.origin.y, frame.size.width-10, frame.size.height);
    }else{
        tempFrame = frame;
    }
    UILabel * label = [[UILabel alloc] initWithFrame:tempFrame];
    label.font = font;
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.userInteractionEnabled = YES;
    return label;
}
+ (UILabel *)setLabelWithFrame:(CGRect)frame font:(UIFont*)font attributedString:(NSAttributedString*)attributedString textColor:(UIColor *)textColor textAlignment:(NSInteger)textAlignment
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:font.pointSize];
    label.textColor = textColor;
    label.attributedText = attributedString;
    label.textAlignment = textAlignment;
    return label;
}

- (void)setParagraphText:(NSString*)text andLineSpacing:(CGFloat)spacing{
    if(text == nil || text.length == 0){
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
}

- (CGRect)getRectWithText:(NSString *)text
                textWidth:(CGFloat)textWidth
                 fontSize:(CGFloat)fontSize
                    lines:(NSInteger)lines
              lineSpacing:(CGFloat)spacing {
    
    if (nil == text || text.length <= 0) return CGRectZero;
    
    self.size = CGSizeMake(textWidth, MAXFLOAT);
    self.font = [UIFont systemFontOfSize:fontSize];
    self.numberOfLines = lines;
    
    //计算宽度
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = spacing;
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:text
                                                                                 attributes:@{NSParagraphStyleAttributeName : style}];
    [self setAttributedText:attriStr];
    [self sizeToFit];
    
    return self.frame;
    
}

@end
