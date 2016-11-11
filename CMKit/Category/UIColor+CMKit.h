//
//  UIColor+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIColor的有用方法
 */
@interface UIColor (CMKit)

/**
 *  根据指定的HEX字符串创建一种颜色
 *  HEX支持下面的格式:
 *  - #RGB
 *  - #ARGB
 *  - #RRGGBB
 *  - #AARRGGBB
 *
 *  @param hexString HEX字符串
 *
 *  @return 返回创建的UIColor实例
 */
+ (UIColor * _Nonnull)hex:(NSString * _Nonnull)hexString;

/**
 *  根据指定的HEX创建一个颜色
 *
 *  @param hex HEX值，默认alpha值为1
 *
 *  @return 返回创建的UIColor实例
 */
+ (UIColor * _Nonnull)colorWithHex:(unsigned int)hex;

/**
 *  根据指定HEX和alpha值创建一种颜色
 *
 *  @param hex   HEX值
 *  @param alpha Alpha值
 *
 *  @return 返回创建的UIColor实例
 */
+ (UIColor * _Nonnull)colorWithHex:(unsigned int)hex
                             alpha:(float)alpha;


/**
 *  根据指定的String创建一种颜色(如@"blue"或@"ff00ff")
 *
 *  @param colorString 颜色String
 *
 *  @return 返回创建的UIColor实例
 */
+ (UIColor * _Nonnull)colorForColorString:(NSString * _Nonnull)colorString;

/**
 *  随机创建一种颜色
 *
 *  @return 返回创建的随机色
 */
+ (UIColor * _Nonnull)randomColor;

/**
 *  创建并且返回一种具有与给出颜色相同space和component值，但是具有特殊alpha值的颜色
 *
 *  @param color UIColor值
 *  @param alpha Alpha值
 *
 *  @return 返回创建的UIColor实例
 */
+ (UIColor * _Nonnull)colorWithColor:(UIColor * _Nonnull)color
                               alpha:(float)alpha;


@end
