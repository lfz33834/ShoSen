//
//  UIImage+Extension.h
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 sunlijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 * 加载图片，不能加载放到xcassets中得图片
 */
+ (UIImage*)imageFromMainBundleFile:(NSString*)aFileName;


/**
 * 指定颜色值，生成一张纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 * 生成一张缩略图:65*65
 */
+ (UIImage *) thumbnailImageForImage:(UIImage *) image;

/**
 * 拍摄的图片有时候是侧着的或者倒着，将这样的照片调整方向
 */
+ (UIImage *)rotateImage:(UIImage *)aImage;


/**
 * 压缩图片宽度高度
 */
- (UIImage *)transformtoSize:(CGSize)Newsize;

- (UIImage *)maskedWithMaskingImage:(UIImage *)maskingImage;
/**
 *  生成一张圆形图片
 *
 *  @param name        需要生成的图片名称
 *  @param borderWidth 生成的圆形图片的边框
 *  @param borderColor 边框的颜色
 *
 *  @return 圆形图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  生成一张圆形图片
 *
 *  @param image        图片
 *  @param borderWidth 生成的圆形图片的边框
 *  @param borderColor 边框的颜色
 *
 *  @return 圆形图片
 */

+ (instancetype)circleImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


/**
 *  将当前图片变成圆形图片
 *
 *  @param borderWidth 生成的圆形图片的边框
 *  @param borderColor 边框的颜色
 *
 *  @return 圆形图片
 */
- (instancetype)circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  告诉这张图片保持原有的图片样式
 *
 *  @param imageName 图片
 *
 *  @return 原有图片
 */
+ (UIImage *)imageWithOriginalMode:(NSString *)imageName;


/**
 *  拉伸图片:自定义比例
 */
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;





/**
 *  拉伸图片
 */
+(UIImage *)resizeWithImageName:(NSString *)name;


/**
 *  获取启动图片
 */
+(UIImage *)launchImage;


// 修改图片大小
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size opaque:(BOOL)opaque;

// + alpha
- (BOOL)hasAlpha;

- (UIImage *)imageWithAlpha;

- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;

// Resize

- (UIImage *)croppedImage:(CGRect)bounds;

- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

// RouundedCorner
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;

// FixOrientation
- (UIImage *)fixOrientation;

//stretch 
+ (UIImage *)resizedImage:(NSString *)name;
+ (UIImage *)resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
+ (UIImage *)stretchImageWithName:(NSString *)name;
+ (UIImage *)stretchImageWithNames:(NSString *)name;
+ (UIImage *)createImageWithColor:(UIColor *)color;

// Cut

/**
 *  从给定UIView中截图：UIView转UIImage
 */
+(UIImage *)cutFromView:(UIView *)view;


/**
 *  直接截屏
 */
+(UIImage *)cutScreen;

/**
 *  从给定UIImage和指定Frame截图：
 */
-(UIImage *)cutWithFrame:(CGRect)frame;
// Effects

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
// 着色
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color level:(CGFloat)level;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level;

-(UIImage*)rt_lightenWithLevel:(CGFloat)level;
-(UIImage*)rt_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)rt_lightenRect:(CGRect)rect withLevel:(CGFloat)level;

-(UIImage*)rt_darkenWithLevel:(CGFloat)level;
-(UIImage*)rt_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)rt_darkenRect:(CGRect)rect withLevel:(CGFloat)level;

/*** 依据中间点填充扩展 **/
+ (UIImage *)resizableImageWithName:(NSString *)name;



//+ (void )analysisImageDadaSize:(NSString *)imageUrl qscsuccess:(QSCSuccess)success;
@end
