//
//  UILabel+size.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/4.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (size)

- (CGSize)sizeOfMultiLineLabel;

+ (CGSize)siezeOfMultiLineLabelWithText:(NSString *)text
                                   font:(UIFont *)font
                             labelWidth:(CGFloat)labelWidth;

+ (CGSize)siezeOfSingleLineLabelWithText:(NSString *)text
                                    font:(UIFont *)font
                             labelHeight:(CGFloat)labelHeight;

+ (UILabel *)setLabelWithFrame:(CGRect)frame
                          font:(UIFont*)font
                          text:(NSString*)text
                     textColor:(UIColor *)textColor
                 textAlignment:(NSInteger)textAlignment;

+ (UILabel *)setLabelWithFrame:(CGRect)frame
                          font:(UIFont*)font
              attributedString:(NSAttributedString*)attributedString
                     textColor:(UIColor *)textColor
                 textAlignment:(NSInteger)textAlignment;


- (void)setParagraphText:(NSString*)text
          andLineSpacing:(CGFloat)spacing;


- (CGRect)getRectWithText:(NSString *)text
                textWidth:(CGFloat)textWidth
                 fontSize:(CGFloat)fontSize
                    lines:(NSInteger)lines
              lineSpacing:(CGFloat)spacing;

@end
