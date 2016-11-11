//
//  CMBaseNavigationController.h
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBaseNavigationController : UINavigationController


/**
 设置NavigationBar的标题属性

 @param titleColor 标题字体颜色
 @param tintColor 导航栏字体颜色·
 */
+ (void)setNavigationBarTitleAttribute:(UIColor * _Nullable)titleColor tintColor:(UIColor * _Nullable)tintColor;

/**
 快速创建添加入TabBarController的导航控制器
 
 @param viewController      导航控制器的根控制器
 @param title               标题
 @param normalTitleColor    普通标题颜色
 @param highLightTitleColor 高亮标题颜色
 @param normalImage         普通图片
 @param selecteImage        选中后图片
 @param fontSize            标题字体大小
 
 @return 被创建的导航控制器
 */
+ (CMBaseNavigationController * _Nonnull)createNavigationController:(Class _Nonnull)viewController title:(NSString * _Nullable)title normalTitleColor:(UIColor * _Nullable)normalTitleColor highLightTitleColor:(UIColor * _Nullable)highLightTitleColor normalImage:(NSString * _Nullable)normalImage selectedImage:(NSString * _Nullable)selecteImage fontOfSize:(CGFloat)fontSize;


@end
