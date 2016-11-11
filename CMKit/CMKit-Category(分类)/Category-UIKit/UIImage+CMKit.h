//
//  UIImage+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIImage的有用方法
 */
@interface UIImage (CMKit)

#pragma mark - 画带边框圆图
/**
 *  画带边框圆图
 *
 *  @param name        指定画圆图的Image
 *  @param borderWidth 边框宽
 *  @param borderColor 边框颜色
 *
 *  @return 处理后的Image
 */
+ (UIImage * _Nonnull)circleImageWithName:(NSString * _Nonnull)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nonnull)borderColor;

/**
 *  给图片增加圆角
 *
 *  @param radius 圆角弧度
 *
 *  @return 处理后的Image
 */
- (UIImage * _Nonnull)imageByRoundCornerRadius:(CGFloat)radius;
/**
 *  给图片增加圆角及边框
 *
 *  @param radius 圆角弧度
 *
 *  @param borderWidth 边框宽
 *
 *  @param borderColor 边框颜色
 *
 *  @return 处理后的Image
 */
- (UIImage * _Nonnull)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor * _Nullable)borderColor;

#pragma mark - 创建、处理图片

/**
 *  根据image本身创建指定rect的image
 *
 *  @param rect 指定的rect
 *
 *  @return 返回指定rect所创建的image
 */
- (UIImage * _Nonnull)imageAtRect:(CGRect)rect;

/**
 *  创建指定color的image
 *
 *  @param color 指定color
 *
 *  @return 返回创建的image
 */
+ (UIImage * _Nonnull)imageWithColor:(UIColor * _Nonnull)color;

/**
 *  将图片剪裁至目标尺寸(将图片直接重绘入目标尺寸画布，原长/宽比例为目标尺寸长/宽比例)
 *
 *  @param targetSize 目标size
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nullable)imageByScalingToSize:(CGSize)targetSize;

/**
 *  将图片剪裁至目标尺寸(将图片按比例压缩后重绘入目标尺寸画布，并裁剪掉多余部分，原长/宽比例不变)
 *
 *  @param targetSize 目标size
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nullable)imageByScalingAndCroppingToTargetSize:(CGSize)targetSize;


/**
 * 内切处理图片
 *
 *  @param insets 内切值
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nonnull)edgeInsetsImage:(UIEdgeInsets)insets;

/**
 * 按比例拉伸/缩放图片
 *
 *  @param scale 拉伸/缩放 比例
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nullable)imageByResizeToScale:(CGFloat)scale;

/**
 * 按目标尺寸以最大边缩小图片
 * 若给出的size.width和size.height均大于图片原本原本的宽和高，则返回原图
 *
 *  @param size 目标缩小尺寸
 *
 *  @return 返回处理后的image
 */
- (UIImage * _Nullable)imageByNarrowWithMaxSize:(CGSize)size;


/**
 *  根据指定radians旋转image
 *
 *  @param radians 目标radians
 *
 *  @return 返回旋转后的image
 */
- (UIImage * _Nonnull)imageRotatedByRadians:(CGFloat)radians;

/**
 *  根据指定degrees旋转image
 *
 *  @param degrees 目标degrees
 *
 *  @return 返回旋转后的image
 */
- (UIImage * _Nonnull)imageRotatedByDegrees:(CGFloat)degrees;



#pragma mark - 设置图片alpha
/**
 *  设置图片alpha
 *
 *  @param image 图片
 *  @param alpha alpha
 *
 *  @return 图片
 */
+ (UIImage * _Nonnull)setImageAlpha:(UIImage * _Nonnull)image alpha:(CGFloat)alpha;

/**
 *  检查image是否有alpha属性
 *
 *  @return Returns YES有，NO无
 */
- (BOOL)hasAlpha;

/**
 *  移除image的alpha属性
 *
 *  @return 没有alpha属性的image
 */
- (UIImage * _Nonnull)removeAlpha;

/**
 *  使用白色填充alpha属性
 *
 *  @return 填充后的image
 */
- (UIImage * _Nonnull)fillAlpha;

/**
 *  使用指定color填充alpha属性
 *
 *  @param color 指定的color
 *
 *  @return 填充指定颜色alpha属性后的图片
 */
- (UIImage * _Nonnull)fillAlphaWithColor:(UIColor * _Nonnull)color;


#pragma mark - 图片重绘颜色
/**
 *  纯色图重绘颜色
 *
 *  @param tintColor 目标颜色
 *
 *  @return 重绘颜色后的Image
 */
- (UIImage * _Nonnull)imageWithTintColor:(UIColor * _Nonnull)tintColor;

/**
 *  渐变色图重绘颜色
 *
 *  @param tintColor 目标颜色
 *
 *  @return 重绘颜色后的Image
 */
- (UIImage * _Nonnull)imageWithGradientTintColor:(UIColor * _Nonnull)tintColor;



#pragma mark - 翻转图片
/**
 *  水平翻转image
 *
 *  @return 返回翻转后的image
 */
- (UIImage * _Nonnull)flipImageHorizontally;

/**
 *  垂直翻转image
 *
 *  @return 返回翻转后的iamge
 */
- (UIImage * _Nonnull)flipImageVertically;

/**
 *  垂直并水平翻转image
 *
 *  @return 返回翻转后的iamge
 */
- (UIImage * _Nullable)flipImageVerticallyAndHorizontally;


#pragma mark - 图片效果
/**
 * 图片light效果
 *
 *  @return 返回处理后的iamge
 */
- (UIImage * _Nonnull)imageLightEffect;
/**
 * 图片light+效果
 */
- (UIImage *_Nonnull)imageExtraLightEffect;
/**
 * 图片dark效果
 */
- (UIImage *_Nonnull)imageDarkEffect;
/**
 * 图片模糊效果
 */
- (UIImage *_Nonnull)imageBlurEffect;



@end
