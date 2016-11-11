//
//  UIDevice+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  此分类增加了一些关于UIDevice的有用方法
 */
@interface UIDevice (CMKit)

/**
 *  返回设备平台字符串
 *  如:"iPhone7,2"
 *
 *  @return 返回设备平台字符串
 */
+ (NSString * _Nonnull)devicePlatform;
/**
 *  返回可读的设备平台字符串
 *  如:"iPad Air (Cellular)"
 *
 *  @return 返回可读的设备平台字符串
 */
+ (NSString * _Nonnull)devicePlatformString;

/**
 *  检查当前设备是否是iPad
 *
 *  @return 返回YES是iPad，NO不是
 */
+ (BOOL)isiPad;

/**
 *  检查当前设备是否是iPhone
 *
 *  @return 返回YES是iPhone，NO不是
 */
+ (BOOL)isiPhone;

/**
 *  检查当前设备是否是iPod
 *
 *  @return 返回YES是iPod，NO不是
 */
+ (BOOL)isiPod;

/**
 *  检查当前设备是否是Apple TV
 *
 *  @return 返回YES是Apple TV，NO不是
 */
+ (BOOL)isAppleTV;

/**
 *  检查当前设备是否是Apple Watch
 *
 *  @return 返回YES是Apple Watch，NO不是
 */
+ (BOOL)isAppleWatch;

/**
 *  检查当前设备是否是模拟器
 *
 *  @return 返回YES是模拟器，NO不是
 */
+ (BOOL)isSimulator;

/**
 *  返回当前iOS版本号(不包含子版本号)
 *  如:7
 *
 *  @return 返回当前iOS版本号
 */
+ (NSInteger)iOSVersion;

/**
 *  返回当前设备CPU频率
 *
 *  @return 返回当前设备CPU频率
 */
+ (NSUInteger)cpuFrequency;

/**
 *  返回当前设备BUS频率
 *
 *  @return 返回当前设备BUS频率
 */
+ (NSUInteger)busFrequency;

/**
 *  返回当前设备RAM大小
 *
 *  @return 返回当前设备RAM大小
 */
+ (NSUInteger)ramSize;

/**
 *  返回当前设备CPU数量
 *
 *  @return 返回当前设备CPU数量
 */
+ (NSUInteger)cpuNumber;

/**
 *  返回当前设备总内存
 *
 *  @return 返回当前设备总内存
 */
+ (NSUInteger)totalMemory;

/**
 *  返回当前设备内核内存
 *
 *  @return 返回当前设备内核内存
 */
+ (NSUInteger)userMemory;

/**
 *  返回当前设备总沙盒空间
 *
 *  @return 返回当前设备总沙盒空间
 */
+ (NSNumber * _Nonnull)totalDiskSpace;

/**
 *  返回当前设备可用沙盒空间
 *
 *  @return 返回当前设备可用沙盒空间
 */
+ (NSNumber * _Nonnull)freeDiskSpace;



@end
