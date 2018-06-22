//
//  NSString+GetWeekDay.m
//  uavsystem
//
//  Created by lx on 2016/10/17.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "NSString+GetWeekDay.h"

@implementation NSString (GetWeekDay)

+ (NSString *)getWeekDayWithYear:(NSInteger )year month:(NSInteger )month day:(NSInteger )day
{
    NSInteger DayOfWeek; 
    NSString *week;
    DayOfWeek = year > 0 ? (5 + (year + 1) + (year - 1)/4 - (year - 1)/100 + (year - 1)/400) % 7 : (5 + year + year/4 - year / 100 + year / 400) % 7;  
    
    DayOfWeek = month > 2 ? (DayOfWeek + 2 * (month + 1) + 3 * (month + 1)/5)  %  7 : (DayOfWeek + 2 * (month + 2) + 3 * (month + 2) / 5) % 7; 
    
    if (((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) && month > 2) { 
        DayOfWeek = (DayOfWeek + 1) % 7; 
    } 
    DayOfWeek = (DayOfWeek + day) % 7; 
    switch (DayOfWeek) {
        case 1:
            week = @"周一";
            break;
        case 2:
            week = @"周二";
            break;
        case 3:
            week = @"周三";
            break;
        case 4:
            week = @"周四";
            break;
        case 5:
            week = @"周五";
            break;
        case 6:
            week = @"周六";
            break;
        case 0:
            week = @"周日";
            break;
    }
    return week;
}


@end
