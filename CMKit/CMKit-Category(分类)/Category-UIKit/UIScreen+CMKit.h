//
//  UIScreen+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIScreen的有用方法
 */
@interface UIScreen (CMKit)

/**
 *  检查当前设备是否是视网膜显示屏
 *
 *  @return YES视网膜显示屏，NO非视网膜显示屏
 */
+ (BOOL)isRetina;

/**
 *  检查当前设备是否是视网膜高清显示屏
 *
 *  @return YES视网膜高清显示屏，NO非视网膜高清显示屏
 */
+ (BOOL)isRetinaHD;


/**
 *  获取当前设备的亮度
 *
 *  @return 返回当前设备的亮度
 */
+ (CGFloat)brightness;

/**
 *  设置当前设备的亮度
 *
 *  @param brightness 新的亮度值
 */
+ (void)setBrightness:(CGFloat)brightness;

@end
