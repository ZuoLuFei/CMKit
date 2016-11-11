//
//  MBProgressHUD+CMKit.h
//  CMKit
//
//  Created by yons on 16/11/1.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (CMKit)
/**
 * 成功提示于指定View(带提示图片)
 *
 * @param success 提示文字
 *
 * @param view 显示View
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/**
 * 成功提示于Window(带提示图片)
 *
 * @param success 提示文字
 */
+ (void)showSuccess:(NSString *)success;


/**
 * 失败提示于指定View(带提示图片)
 *
 * @param error 提示文字
 *
 * @param view 显示View
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;

/**
 * 失败提示于Window(带提示图片)
 *
 * @param error 提示文字
 */
+ (void)showError:(NSString *)error;


/**
 * 信息提示于指定View
 *
 * @param message 提示文字
 *
 * @param view 显示View
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

/**
 * 信息提示于指定Window
 *
 * @param message 提示文字
 */
+ (MBProgressHUD *)showMessage:(NSString *)message;


/**
 * 隐藏HUD
 */
+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUD;

@end
