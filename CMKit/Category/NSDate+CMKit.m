//
//  NSDate+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "NSDate+CMKit.h"

@implementation NSDate (CMKit)

/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDate * _Nonnull)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

- (NSDateComponents * _Nonnull)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

- (NSInteger)weekday {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:self];
    
    return [comps weekday];
}



- (NSString * _Nonnull)dayFromWeekday {
    switch ([self weekday]) {
        case 1:
            return @"周日";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"SUNDAY") value:@"" table:@"CMKit"];
            break;
        case 2:
            return @"周一";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"MONDAY") value:@"" table:@"CMKit"];
            break;
        case 3:
            return @"周二";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"TUESDAY") value:@"" table:@"CMKit"];
            break;
        case 4:
            return @"周三";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"WEDNESDAY") value:@"" table:@"CMKit"];
            break;
        case 5:
            return @"周四";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"THURSDAY") value:@"" table:@"CMKit"];
            break;
        case 6:
            return @"周五";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"FRIDAY") value:@"" table:@"CMKit"];
            break;
        case 7:
            return @"周六";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"SATURDAY") value:@"" table:@"CMKit"];
            break;
        default:
            return @"";
            break;
    }
}


- (NSInteger)month {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:self];
    
    return [comps month];
}


+ (NSString * _Nonnull)monthStringWithMonthNumber:(NSInteger)month {
    switch (month) {
        case 1:
            return @"一月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"JANUARY") value:@"" table:@"CMKit"];
            break;
        case 2:
            return @"二月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"FEBRUARY") value:@"" table:@"CMKit"];
            break;
        case 3:
            return @"三月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"MARCH") value:@"" table:@"CMKit"];
            break;
        case 4:
            return @"四月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"APRIL") value:@"" table:@"CMKit"];
            break;
        case 5:
            return @"五月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"MAY") value:@"" table:@"CMKit"];
            break;
        case 6:
            return @"六月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"JUNE") value:@"" table:@"CMKit"];
            break;
        case 7:
            return @"七月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"JULY") value:@"" table:@"CMKit"];
            break;
        case 8:
            return @"八月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"AUGUST") value:@"" table:@"CMKit"];
            break;
        case 9:
            return @"九月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"SEPTEMBER") value:@"" table:@"CMKit"];
            break;
        case 10:
            return @"十月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"OCTOBER") value:@"" table:@"CMKit"];
            break;
        case 11:
            return @"十一月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"NOVEMBER") value:@"" table:@"CMKit"];
            break;
        case 12:
            return @"十二月";
//            return [[NSBundle mainBundle] localizedStringForKey:(@"DECEMBER") value:@"" table:@"CMKit"];
            break;
        default:
            return @"";
            break;
    }
}


- (BOOL)isSameDay:(NSDate * _Nonnull)anotherDate {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    NSDateComponents* components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:anotherDate];
    
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}

- (NSDate * _Nonnull)dateByAddingDays:(NSUInteger)days  {
    return [self dateByAddingTimeInterval:days * 24 * 60 * 60];
}


/**
 *  判断输入dateStr的是今天、昨天还是具体的某天（yyyy-MM-dd）
 *
 *  @param dateStr 时间格式String
 *
 *  @return 判断：今天、昨天还是具体的某天（yyyy-MM-dd） String
 */
+ (NSString * _Nullable)judgeTimeFormat:(NSString * _Nullable)dateStr{
    
    if (!dateStr) {
        return @"";
    }
    
    // 当前时间
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";//根据dateStr格式设置dateFormat,否则无法成功将string转换为date
    NSDate *createTimeDate = [fmt dateFromString:dateStr];
    
    // 比较2个时间的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmps = [calendar components:unit fromDate:createTimeDate toDate:now options:0];
    if (cmps.day < 1) {//今天
        fmt.dateFormat = @"HH:mm";
        NSString *str = [fmt stringFromDate:createTimeDate];
        return str;
        
        
    } else if(cmps.day >= 1 && cmps.day < 2){//昨天
        fmt.dateFormat = @"HH:mm";
        NSString *str = @"昨天";
        return str;
        
    }else {
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString *str = [fmt stringFromDate:createTimeDate];
        return str;
        
    }
    
}


@end
