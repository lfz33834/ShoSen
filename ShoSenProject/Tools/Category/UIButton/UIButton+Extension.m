//
//  UIButton+ImageBtn.m
//  4s
//
//  Created by muxi on 15/3/11.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "UIButton+Extension.h"
#import "UIImage+Extension.h"
#import <objc/runtime.h>
#import "NSString+Extension.h"
#import "UIButton+WebCache.h"

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (Extension)


/**
 *  快速生成一个含有图片的按钮：默认按钮在大小和图片一样大
 *
 *  @param imageName        图片名
 *  @param highlightedColor 按钮高亮的时候的颜色
 *
 *  @return 按钮
 */
+(UIButton *)buttonWithImageName:(NSString *)imageName highlightedColor:(UIColor *)highlightedColor{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *imageForNarmal=[UIImage imageNamed:imageName];
    UIImage *imageForhighlighted=[imageForNarmal rt_tintedImageWithColor:highlightedColor level:1.0];
    
    //设置不同状态下的图片
    [btn setImage:imageForNarmal forState:UIControlStateNormal];
    [btn setImage:imageForhighlighted forState:UIControlStateHighlighted];
    
    btn.frame=(CGRect){CGPointZero,imageForNarmal.size};
    
    return btn;
}


static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets {
    
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
//        return [super pointInside:point withEvent:event];
//    }
//
//    CGRect relativeFrame = self.bounds;
//    CGRect hitFrame = CGRectMake(relativeFrame.origin.x-self.hitTestEdgeInsets.left,
//                                 relativeFrame.origin.y-self.hitTestEdgeInsets.top,
//                                 relativeFrame.size.width+self.hitTestEdgeInsets.right+self.hitTestEdgeInsets.left,
//                                 relativeFrame.size.height+self.hitTestEdgeInsets.bottom+self.hitTestEdgeInsets.top);
//
//    return CGRectContainsPoint(hitFrame, point);
//}

#pragma mark -

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    
    if (inside && !self.highlighted)
    {
        self.highlighted = YES;
    }
    
    return inside;
}

#pragma mark -

- (void)setBackgroundColor:(UIColor *)color
                  forState:(UIControlState)state
                      size:(CGSize)size
                cornerSize:(NSInteger)cornerSize
{
    UIImage *image = [[UIImage imageWithColor:color size:size] roundedCornerImage:cornerSize borderSize:0];
    [self setBackgroundImage:image forState:state];
}

- (void)centerImageAndTitle:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    imageSize = CGSizeMake(floorf(imageSize.width), floorf(imageSize.height));
    titleSize = CGSizeMake(floorf(titleSize.width), floorf(titleSize.height));
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}

- (void)leftImageAndTitle
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    imageSize = CGSizeMake(floorf(imageSize.width), floorf(imageSize.height));
    titleSize = CGSizeMake(floorf(titleSize.width), floorf(titleSize.height));
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + 10);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}

- (void)rightImageAndTitle
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    imageSize = CGSizeMake(floorf(imageSize.width), floorf(imageSize.height));
    titleSize = CGSizeMake(floorf(titleSize.width), floorf(titleSize.height));
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + 10);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}

- (void)centerImageAndTitle
{
    const int DEFAULT_SPACING = 6.0f;
    [self centerImageAndTitle:DEFAULT_SPACING];
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                      titleFont:(UIFont *)titleFont
                     titleColor:(UIColor *)titleColor
                backgroundColor:(UIColor *)backgroundColor
     highlightedBackgroundColor:(UIColor *)highlightedBackgroundColor
                   cornerRadius:(NSInteger)cornerRadius
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = titleFont;
    button.titleLabel.userInteractionEnabled = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    [button setBackgroundColor:backgroundColor
                      forState:UIControlStateNormal
                          size:frame.size cornerSize:cornerRadius];
    [button setBackgroundColor:highlightedBackgroundColor
                      forState:UIControlStateHighlighted
                          size:frame.size cornerSize:cornerRadius];
    button.frame = frame;
    
    return button;
}
- (CGSize)setAllStateBg:(NSString *)icon
{
    UIImage *normal = [UIImage resizedImage:icon];
    UIImage *highlighted = [UIImage resizedImage:[icon filenameAppend:@"_highlighted"]];
    
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    [self setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    return normal.size;
}


/**
 *  imageView展示网络图片
 *
 *  @param urlStr  图片地址
 *  @param phImage 占位图片
 */
-(void)imageWithUrlStr:(NSString *)urlStr phImage:(UIImage *)phImage{
    
    if(urlStr==nil) {
        MYLog(@"错误：URL地址为空");
        return;
    }
    
    NSURL *url=[NSURL URLWithString:urlStr];
    
    [self sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:phImage];
}




/**
 *  带有进度的网络图片展示
 *
 *  @param urlStr         图片地址
 *  @param phImage        占位图片
 *  @param completedBlock 完成
 */
-(void)imageWithUrlStr:(NSString *)urlStr phImage:(UIImage *)phImage state:(UIControlState)state completedBlock:(SDExternalCompletionBlock)completedBlock{
    
    if(urlStr==nil) {
        MYLog(@"错误：URL地址为空");
        return;
    }
    
    NSURL *url=[NSURL URLWithString:urlStr];
    
    SDWebImageOptions options = SDWebImageLowPriority | SDWebImageRetryFailed;
    
    [self sd_setImageWithURL:url forState:state placeholderImage:phImage options:options completed:completedBlock];
}



+ (UIButton *)itemWithFream:(CGRect)fream withNormarlImg:(UIImage *)normalImg withHighImg:(UIImage *)highImg withSelectImg:(UIImage *)selectImg;
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = fream;
    [button setImage:normalImg forState:UIControlStateNormal];
    [button setImage:highImg forState:UIControlStateHighlighted];
    [button setImage:selectImg forState:UIControlStateSelected];
    return button;
}
+ (UIButton *)itemWithFream:(CGRect)fream withbackGroundColor:(UIColor *)backColor withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withTitleSize:(CGFloat)fontSize withIsBold:(BOOL)boldState
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backColor;
    button.frame = fream;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    if (boldState) {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }
    return button;
}
- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
