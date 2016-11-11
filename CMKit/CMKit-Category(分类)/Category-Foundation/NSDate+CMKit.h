//
//  NSDate+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 *  此分类增加了一些关于NSDate的有用方法
 *  注：(内部处理时间格式yyyy-MM-dd HH:mm:ss，若时间格式不一致，请到.m文件中自行修改)
 */
@interface NSDate (CMKit)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate * _Nonnull)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents * _Nonnull)deltaWithNow;

/**
 *  通过自身获取工作日
 *
 *  @return 返回工作日数字
 *  [1 - Sunday]周日
 *  [2 - Monday]周一
 *  [3 - Tuerday]周二
 *  [4 - Wednesday]周三
 *  [5 - Thursday]周四
 *  [6 - Friday]周五
 *  [7 - Saturday]周六
 */
- (NSInteger)weekday;

/**
 *  通过自身获取当地的工作日描述
 *
 *  @return 返回当地工作日描述
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString * _Nonnull)dayFromWeekday;


/**
 *  通过自身获取月数字
 *
 *  @return 返回月数字
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 */
- (NSInteger)month;

/**
 *  通过给出的月数字获取当地的月描述
 *
 *  @param month 被转换的月数字
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return 返回当地月描述
 */
+ (NSString * _Nonnull)monthStringWithMonthNumber:(NSInteger)month;

/**
 *  比较自身和另一个日期是否为同一天
 *
 *  @param anotherDate 作为比较的另一个日期
 *
 *  @return Returns YES同一天，NO不是同一天
 */
- (BOOL)isSameDay:(NSDate * _Nonnull)anotherDate;

/**
 *  给自身增加天数
 *
 *  @param days 增加的天数
 *
 *  @return 返回增加天数后的自身
 */
- (NSDate * _Nonnull)dateByAddingDays:(NSUInteger)days;


/**
 *  判断输入dateStr的是今天、昨天还是具体的某天
 *  注：(内部处理时间格式yyyy-MM-dd HH:mm:ss，若时间格式不一致，请到.m文件中自行修改)
 *
 *  @param dateStr 时间格式String
 *
 *  @return 判断：今天、昨天还是具体的某天 String
 */
+ (NSString * _Nullable)judgeTimeFormat:(NSString * _Nullable)dateStr;


@end
