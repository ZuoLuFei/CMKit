//
//  UIView+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIView的有用方法
 */
@interface UIView (CMKit)

/**
 *  创建一个指定frame和背景色的UIView
 *
 *  @param frame           UIView的frame
 *  @param backgroundColor UIView的背景色
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                       backgroundColor:(UIColor * _Nonnull)backgroundColor;

/**
 *  设置当前view的边界周边
 *
 *  @param color  边界的颜色
 *  @param radius 边界的拐角半径
 *  @param width  边界的宽
 */
- (void)createBordersWithColor:(UIColor * _Nonnull)color
              withCornerRadius:(CGFloat)radius
                      andWidth:(CGFloat)width;

/**
 *  移除当前view的边界周边
 */
- (void)removeBorders;

/**
 *  设置当前view的阴影
 *
 *  @param offset  阴影的偏移量
 *  @param opacity 阴影的不透明度
 *  @param radius  阴影的半径
 */
- (void)createRectShadowWithOffset:(CGSize)offset
                           opacity:(CGFloat)opacity
                            radius:(CGFloat)radius;

/**
 *  设置当前view的拐角阴影
 *
 *  @param cornerRadius 拐角半径值
 *  @param offset       阴影的偏移量
 *  @param opacity      阴影的不透明度
 *  @param radius       阴影的半径
 */
- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius
                                          offset:(CGSize)offset
                                         opacity:(CGFloat)opacity
                                          radius:(CGFloat)radius;

/**
 *  移除当前view的阴影
 */
- (void)removeShadow;


/**
 *  设置当前view的拐角半径
 *
 *  @param radius 半径值
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  为当前view创建震动动画效果
 */
- (void)shakeView;

/**
 *  为当前view创建脉冲动画效果
 *
 *  @param duration 动画时间
 */
- (void)pulseViewWithDuration:(CGFloat)duration;

/**
 *  为当前view创建心跳动画效果
 *
 *  @param duration 动画时间
 */
- (void)heartbeatViewWithDuration:(CGFloat)duration;

/**
 *  为当前view增加运行效果
 */
- (void)applyMotionEffects;


/**
 *  获取当前view的屏幕截图
 *
 *  @return 返回UIimage格式的屏幕截图
 */
- (UIImage * _Nonnull)screenshot;

/**
 *  获取当前view的屏幕截图并保存到照片专辑中
 *
 *  @return 返回UIimage格式的屏幕截图
 */
- (UIImage * _Nonnull)saveScreenshot;

/**
 *  从当前view移除所有的子视图
 */
- (void)removeAllSubviews;

/**
 获取指定视图在window根控制器中的位置

 @param view 指定View
 @return 返回在window根控制器中的位置
 */
+ (CGRect)getFrameInWindow:(UIView * _Nonnull)view;

@end
