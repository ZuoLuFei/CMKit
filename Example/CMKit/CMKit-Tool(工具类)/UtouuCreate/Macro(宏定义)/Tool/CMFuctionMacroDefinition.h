//
//  
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//

/*
 作用--> 全局宏使用
 使用场景--> 函数宏定义
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

/*----------------------------—分割线------------------------------*/

#pragma mark - 破除Block循环引用的弱/强指针
// 推荐添加入自动补全(CodeSnippet)便于快速使用

/**
 *  破除Block循环引用的弱指针，使用方法：@DEF_WEAKOBJ(Obj)
 */
#define DEF_WEAKOBJ(Obj) autoreleasepool{} __weak typeof(Obj) weak##Obj = Obj
/**
 *  破除Block循环引用的强指针，使用方法：@DEF_STRONGOBJ(Obj)
 */
#define DEF_STRONGOBJ(Obj) autoreleasepool{} __strong typeof(Obj) Obj = weak##Obj

/*----------------------------—分割线------------------------------*/
#pragma mark - 忽略相关警告⚠️
/**
 *  忽略执行选择器方法导致的可能存在的内存泄漏警告⚠️
 */
#define DEF_SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/**
 *  忽略方法被弃用导致的警告⚠️
 */
#define DEF_SuppressDeprecatedWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)



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

/** 
 *  高保真UI基数屏幕大小（以iPhone 6/6s为准，实际使用中请按照给出的UI参照图为准进行替换）
 */

#pragma mark 屏幕UI适配
#define DEF_HIGHFIDELITY_UI_WIDTH 375
/**
 *  根据高保真UI图进行屏幕适配转换 (用于屏幕适配)
 */
#define DEF_SCREEN_ADAPTER(Number) (((Number)/DEF_HIGHFIDELITY_UI_WIDTH) * DEF_SCREEN_WIDTH)


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



#endif
