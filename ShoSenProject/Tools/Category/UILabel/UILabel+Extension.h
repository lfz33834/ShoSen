//
//  UILabel+Extension.h
//  ShoSenProject
//
//  Created by lifuzhou on 2018/9/5.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/*
 通过便利构造函数生成一个label的对象
 */
+ (UILabel *)itemLabelWithFream:(CGRect)fream withTextString:(NSString *)textStr withTextColor:(UIColor *)textColor withFontSize:(CGFloat)size withBold:(BOOL)boldState withTextAlignment:(NSTextAlignment)textAlignment;
- (UILabel *)labelWithFream:(CGRect)fream withTextString:(NSString *)textStr withTextColor:(UIColor *)textColor withFontSize:(CGFloat)size withBold:(BOOL)boldState withTextAlignment:(NSTextAlignment)textAlignment;
/**
 *  通过便利构造函数生成一个label的对象
 *
 *  @param text                    文本内容
 *  @param frame                   大小
 *  @param font                    字号
 *  @param color                   文本颜色
 *  @param backgroundColor         文本背景色
 *  @param textAlignment           对齐方式
 *  @param val                行间距
 *  @return 返回一个格式化的lab对象
 */
- (UILabel *)formatlabelWithtext:(NSString *)text frame:(CGRect)frame font:(NSInteger)font textColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor textAlignment:(NSTextAlignment)textAlignment interval:(CGFloat)val;
/*
 通过此函数生成一个富文本的label对象
 */
- (void)transFormwithSettingDic:(NSDictionary *)paramDic withchangeColor:(UIColor *)changeColor withChangeFontSize:(CGFloat)changeSize withChangeRange:(NSRange)range;
/**
 *  添加删除线
 */
- (void)addDeleteLine;


//正常lable
+ (UILabel*)C:(NSArray*)A;

//mutablestring
+ (NSAttributedString*)text:(NSString*)text conditions:(NSArray <NSArray*> *)condition;;

+ (CGFloat)hight:(NSString*)text font:(UIFont*)font w:(CGFloat)w;
+ (CGFloat)width:(NSString*)text font:(UIFont*)font h:(CGFloat)h;

/**
 *  改变行间距
 */
+ (CGFloat)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;
+ (CGFloat)changeLineSpaceForLabelRight:(UILabel *)label WithSpace:(float)space;//右对齐

/**
 *  改变字间距
 */
+ (CGFloat)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;
/**
 *  改变行间距和字间距
 */
+ (CGFloat)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
+ (CGFloat)changeSpaceForLabelForMidlle:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;//居中

@end
