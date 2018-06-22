//
//  CommonDate.m
//  uavsystem
//
//  Created by jian zhang on 16/7/18.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonDate.h"

@implementation CommonDate

+ (NSString *)getNowDateWithFormate:(NSString *)formate
{
    NSDateFormatter *dataFomate = [[NSDateFormatter alloc] init];
    [dataFomate setDateFormat:formate];
    if (!formate || formate.length == 0)
    {
        [dataFomate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSString *nowDate = [dataFomate stringFromDate:[NSDate date]];
    return nowDate;
}

+ (NSDate *)dateStringToDate:(NSString *)dateString Formate:(NSString *)formate
{
    NSDateFormatter *dataFomate = [[NSDateFormatter alloc] init];
    [dataFomate setDateFormat:formate];
    if (!formate || formate.length == 0)
    {
        [dataFomate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSDate *nowDate = [dataFomate dateFromString:dateString];
    return nowDate;
}

+ (NSString *)dateToString:(NSDate *)dateValue Formate:(NSString *)formate
{
    NSDateFormatter *dataFomate = [[NSDateFormatter alloc] init];
    [dataFomate setDateFormat:formate];
    if (!formate || formate.length == 0)
    {
        [dataFomate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSString *nowDate = [dataFomate stringFromDate:dateValue];
    return nowDate;
}

+ (NSString *)updateTimeForRow:(NSString *)createTimeString{
    
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [createTimeString longLongValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    NSInteger sec = time/60;
    if (sec<60) {
        return [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

//这个月有几天
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

//第一天是周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

@end
