//
//  
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//

/*
 作用-->
 全局宏使用
 
 使用场景-->
 函数宏定义
 
 */

/**
 *  函数宏定义
 */
#ifndef CMFuctionMacroDefinition_h
#define CMFuctionMacroDefinition_h

/*-----------------------------分割线-------------------------------*/
#pragma mark - 调试DEBUG
//调试打印
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif


/*-----------------------------分割线-------------------------------*/

#pragma mark - 当前屏幕尺寸
/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *  主屏的size
 */
#define DEF_SCREEN_SIZE   [[UIScreen mainScreen] bounds].size

/**
 *  主屏的frame
 */
#define DEF_SCREEN_FRAME  [UIScreen mainScreen].applicationFrame


/*-----------------------------分割线-------------------------------*/

#pragma mark - 当前设备
/**
 *  iPhone4_4s设备
 */
#define DEF_iPhone4_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  iPhone5_5s设备
 */
#define DEF_iPhone5_5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  iPhone6_6s_7设备
 */
#define DEF_iPhone6_6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  iPhone6Plus_6sPlus_7Plus设备
 */
#define DEF_iPhone6Plus_6sPlus_7Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)

/*-----------------------------分割线-------------------------------*/

#pragma mark - 当前系统版本
/**
 *  iOS7以上版本
 */
#define DEF_iOS7_OR_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
/**
 *  iOS8以上版本
 */
#define DEF_iOS8_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
/**
 *  iOS9以上版本
 */
#define DEF_iOS9_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
/**
 *  iOS10以上版本
 */
#define DEF_iOS10_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0


/*-----------------------------分割线-------------------------------*/
#pragma mark - 自定义颜色
/**
 *	生成RGB颜色
 *
 *	@param 	_red 	red值（0~255）
 *	@param 	_green 	green值（0~255）
 *	@param 	_blue 	blue值（0~255）
 *
 *	@return	UIColor对象
 */
#define DEF_RGB_COLOR(_red, _green, _blue) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:1]

/**
 *	生成RGBA颜色
 *
 *	@param 	_red 	red值（0~255）
 *	@param 	_green 	green值（0~255）
 *	@param 	_blue 	blue值（0~255）
 *	@param 	_alpha 	blue值（0~1）
 *
 *	@return	UIColor对象
 */
#define DEF_RGBA_COLOR(_red, _green, _blue, _alpha) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:(_alpha)]

/**
 *	生成RGB颜色
 *
 *	@param 	rgb 	RGB颜色值（必须0x开头，例如:0xffffff）
 *
 *	@return	UIColor对象
 */
#define DEF_RGB_INT_COLOR(rgb) [UIColor colorWithRGB:rgb]

/**
 *	生成RGBA颜色
 *
 *	@param 	string 	颜色描述字符串，带“＃”开头
 *
 *	@return	UIColor对象
 */
#define DEF_STRING_COLOR(string) [UIColor colorWithString:string]

/**
 *  生成随机色
 */
#define DEF_RANDOM_COLOR DEF_RGB_COLOR(arc4random_uniform(256.0),arc4random_uniform(256.0),arc4random_uniform(256.0))

/*-----------------------------分割线-------------------------------*/
#pragma mark - 数据存储
/**
 *	偏好设置存储对象
 *
 *	@param	object    需存储的对象
 *	@param	key    对应的key
 */
#define DEF_USERDEFAULTS_SET_OBJECT(object, key)                                                                                                 \
({                                                                                                                                             \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];                                                                         \
[defaults setObject:object forKey:key];                                                                                                    \
[defaults synchronize];                                                                                                                    \
})

/**
 *	偏好设置取出对象
 *
 *	@param	key    所需对象对应的key
 *	@return	key所对应的对象
 */
#define DEF_USERDEFAULTS_GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

/**
 *  获取沙盒Document存储中指定文件名路劲
 *
 *  @param pathString 存储文件名称（如 @"area.plist"）
 *
 *  @return 存储文件的沙盒位置
 */
#define DEF_DOCMENTPATH_GET(pathString) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:pathString];

#endif
