//
//  MBProgressHUD+CMKit.m
//  CMKit
//
//  Created by yons on 16/11/1.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "MBProgressHUD+CMKit.h"
#import "FLAnimatedImageView.h"
#import "UIImageView+WebCache.h"


@implementation MBProgressHUD (CMKit)


#pragma mark 信息显示
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }

    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: icon]];
    
//        FLAnimatedImageView *customView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        UIImage *image = [UIImage imageWithContentsOfFile:[NSFileManager getBundlePathForFile:@"请检查网络2.gif"]];
////        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
////        FLAnimatedImageView *customView = [[FLAnimatedImageView alloc] initWithFrame:rect];
//        customView.backgroundColor = [UIColor redColor];
//        NSURL *bundleUrl = [[NSBundle mainBundle] URLForResource:@"请检查网络2" withExtension:@"gif"];
//        [customView sd_setImageWithURL:bundleUrl];
//        hud.customView = customView;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

#pragma mark 显示错误或正确信息
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"MBProgressHUD+CMKit.bundle/error" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"MBProgressHUD+CMKit.bundle/success" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}


@end
