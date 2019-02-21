//
//  UIButton+ImageBtn.h
//  4s
//
//  Created by muxi on 15/3/11.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"

@interface UIButton (Extension)

@property(nonatomic) UIEdgeInsets hitTestEdgeInsets;


/**
 *  快速生成一个含有图片的按钮:默认按钮在大小和图片一样大
 *
 *  @param imageName        图片名
 *  @param highlightedColor 按钮高亮的时候的颜色
 *
 *  @return 按钮
 */
+(UIButton *)buttonWithImageName:(NSString *)imageName highlightedColor:(UIColor *)highlightedColor;



- (void)setBackgroundColor:(UIColor *)color
                  forState:(UIControlState)state
                      size:(CGSize)size
                cornerSize:(NSInteger)cornerSize;

//设置按钮样式为 图片与title居中，并且title位于文字下方
- (void)centerImageAndTitle:(float)space;

- (void)centerImageAndTitle;

- (void)leftImageAndTitle;

- (void)rightImageAndTitle;

+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                      titleFont:(UIFont *)titleFont
                     titleColor:(UIColor *)titleColor
                backgroundColor:(UIColor *)backgroundColor
     highlightedBackgroundColor:(UIColor *)highlightedBackgroundColor
                   cornerRadius:(NSInteger)cornerRadius;


// 设置按钮所有状态下的背景
- (CGSize)setAllStateBg:(NSString *)icon;


/**
 *  普通网络图片展示
 *
 *  @param urlStr  图片地址
 *  @param phImage 占位图片
 */
-(void)imageWithUrlStr:(NSString *)urlStr phImage:(UIImage *)phImage;


/**
 *  带有进度的网络图片展示
 *
 *  @param urlStr         图片地址
 *  @param phImage        占位图片
 *  @param completedBlock 完成
 */
-(void)imageWithUrlStr:(NSString *)urlStr phImage:(UIImage *)phImage state:(UIControlState)state completedBlock:(SDExternalCompletionBlock)completedBlock;


/*
 通过图片来生成一个button的实例对象
 */
+ (UIButton *)itemWithFream:(CGRect)fream withNormarlImg:(UIImage *)normalImg withHighImg:(UIImage *)highImg withSelectImg:(UIImage *)selectImg;
/*
 通过文字来生成一个button的实例对象
 */
+ (UIButton *)itemWithFream:(CGRect)fream withbackGroundColor:(UIColor *)backColor withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withTitleSize:(CGFloat)fontSize withIsBold:(BOOL)boldState;

//设置按钮的边距
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
