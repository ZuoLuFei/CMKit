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



@end
