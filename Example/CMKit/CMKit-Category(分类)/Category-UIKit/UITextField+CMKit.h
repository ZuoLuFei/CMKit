//
//  UITextField+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UITextField的有用方法
 */
@interface UITextField (CMKit)

/**
 *  设置UITextField左边距
 *
 *  @param leftWidth 边距
 */
- (void)setTextFieldLeftPadding:(CGFloat)leftWidth;


/**
 设置UITextField 右侧清除按钮图片

 @param normalButtonName      常规图片名
 @param highlightedButtonName 高亮图片名
 */
- (void)setTextFieldClearButtonNormal:(NSString *)normalButtonName Highlighted:(NSString *)highlightedButtonName;


/**
 *  设置UITextField Placeholder颜色
 *
 *  @param color 颜色值
 */
- (void)setTextFieldPlaceholderColor:(UIColor *)color;

/**
 *  设置全局共用UITextField对象的指定格式
 *  
 *  注意：此是对setTextFieldClearButtonNormal:Highlighted:方法的再封装，需要到.m文件中去自己设置图片
 *
 */
+ (void)setTextFieldSpecifiedformat;

@end
