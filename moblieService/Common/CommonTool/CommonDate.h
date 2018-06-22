//
//  CommonDate.h
//  uavsystem
//
//  Created by jian zhang on 16/7/18.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonDate : NSObject

+ (NSString *)getNowDateWithFormate:(NSString *)formate;

+ (NSDate *)dateStringToDate:(NSString *)dateString Formate:(NSString *)formate;

+ (NSString *)dateToString:(NSDate *)dateValue Formate:(NSString *)formate;

+ (NSString *)updateTimeForRow:(NSString *)createTimeString;

+ (NSInteger)totaldaysInThisMonth:(NSDate *)date;

+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

@end
