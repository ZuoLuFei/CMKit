//
//  CMBaseViewController.h
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBaseViewController : UIViewController

/**
 *  屏幕的宽
 */
@property (nonatomic) CGFloat  width;

/**
 *  屏幕的高
 */
@property (nonatomic) CGFloat  height;

/**
 *  基础配置
 */
- (void)setup;


/**
 设置导航栏返回按钮
 */
- (void)addLeftNavButton;


/**
 设置导航栏返回按钮

 @param normalImageName             普通图片
 @param highLightImageName          高亮图片
 @param normalBackgroundImageName   普通背景图片
 @param highLightBackgroudImageName 高亮背景图片
 @param normaltext                  普通文字
 @param highLightText               高亮文字
 @param normalTextColor             普通文字颜色
 @param highLightTextColor          高亮文字颜色
 */
- (void)addLeftNavBarBtnByNormalImage:(NSString * _Nullable)normalImageName highLightImage:(NSString * _Nullable)highLightImageName normalBackgroundImage:(NSString * _Nullable)normalBackgroundImageName highLightBackgroudImage:(NSString * _Nullable)highLightBackgroudImageName normalText:(NSString * _Nullable)normaltext highLightText:(NSString * _Nullable)highLightText normalTextColor:(UIColor * _Nullable)normalTextColor highLightTextColor:(UIColor * _Nullable)highLightTextColor;

/**
 设置控制器背景图片
 */
- (void)setBackgroundView;

/**
 设置控制器背景图片

 @param imageName 背景图片
 */
- (void)setBackgroundViewWithImage:(NSString * _Nullable)imageName;

/**
 *  仅当前控制器为UINavigationController的根控制器的时候才可使用这个方法
 */
- (void)useInteractivePopGestureRecognizer;

/**
 *  仅当前控制器是被UINavigationController push出来的时候才可使用这个属性
 */
@property (nonatomic)  BOOL  enableInteractivePopGestureRecognizer;

/**
 *  如果你的控制器是被一个UINavigationController管理，你可以使用这个方法去返回上一个控制器
 *
 *  @param animated Animated or not.是否需要返回动画
 */
- (void)popViewControllerAnimated:(BOOL)animated;

/**
 *  如果你的控制器是被一个UINavigationController管理，你可以使用这个方法返回根控制器
 *
 *  @param animated 是否需要返回动画
 */
- (void)popToRootViewControllerAnimated:(BOOL)animated;



@end
