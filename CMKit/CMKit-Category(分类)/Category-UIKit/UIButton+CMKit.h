//
//  UIButton+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIButton的有用方法
 */
@interface UIButton (CMKit)

/**
 *  创建一个指定frame的UIButton
 *
 *  @param frame Button的frame
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame;

/**
 *  创建一个指定frame且有title的UIButton
 *
 *  @param frame Button的frame
 *  @param title Button的title, title颜色是白色(white)
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nullable)title;

/**
 *  创建一个指定frame且有title、常规背景图片的UIButton
 *
 *  @param frame           Button的frame
 *  @param title           Button的title
 *  @param backgroundImage Button的background image
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nullable)title
                       backgroundImage:(UIImage * _Nullable)backgroundImage;

/**
 *  创建一个指定frame且有title、常规背景图片、高亮背景图片的UIButton
 *
 *  @param frame                      Button的frame
 *  @param title                      Button的title
 *  @param backgroundImage            Button的background image
 *  @param highlightedBackgroundImage Button的highlighted background image
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nullable)title
                       backgroundImage:(UIImage * _Nullable)backgroundImage
            highlightedBackgroundImage:(UIImage * _Nullable)highlightedBackgroundImage;

/**
 *  创建一个指定frame且有title、常规背景色的UIButton
 *
 *  @param frame Button的frame
 *  @param title Button的title
 *  @param color Button的常规背景color, 高亮背景color会被自动创建
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nonnull)title
                                 color:(UIColor * _Nonnull)color;

/**
 *  创建一个指定frame且有title、常规背景色、高亮背景色的UIButton
 *
 *  @param frame            Button的frame
 *  @param title            Button的title
 *  @param color            Button的常规color
 *  @param highlightedColor Button的高亮color
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 title:(NSString * _Nonnull)title
                                 color:(UIColor * _Nonnull)color
                      highlightedColor:(UIColor * _Nonnull)highlightedColor;

/**
 *  创建一个指定frame且有常规背景色的UIButton
 *
 *  @param frame Button的frame
 *  @param color Button的常规color, 高亮背景color会被自动创建
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 color:(UIColor * _Nonnull)color;

/**
 *  创建一个指定frame且有常规色、高亮背景色的UIButton
 *
 *  @param frame            Button的frame
 *  @param color            Button的常规背景color
 *  @param highlightedColor Button的高亮背景color
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 color:(UIColor * _Nonnull)color
                      highlightedColor:(UIColor * _Nonnull)highlightedColor;

/**
 *  创建一个指定frame且有常规图片的UIBUtton
 *
 *  @param frame Button的frame
 *  @param image Button的常规image
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 image:(UIImage * _Nonnull)image;

/**
 *  创建一个指定frame且有常规图片、高亮图片的UIBUtton
 *
 *  @param frame            Button的frame
 *  @param image            Button的常规image
 *  @param highlightedImage Button的高亮image
 *
 *  @return 返回创建的UIButton实例
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 image:(UIImage * _Nonnull)image
                      highlightedImage:(UIImage * _Nullable)highlightedImage;


/**
 *  设置Button的title的常规颜色
 *
 *  @param color 字体常规颜色, 高亮颜色会被自动创建
 */
- (void)setTitleColor:(UIColor * _Nonnull)color;

/**
 *  设置Button的title的常规颜色和高亮颜色
 *
 *  @param color            Button的常规color
 *  @param highlightedColor Button的高亮color
 */
- (void)setTitleColor:(UIColor * _Nonnull)color
     highlightedColor:(UIColor * _Nullable)highlightedColor;




@end
