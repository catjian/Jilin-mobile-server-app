//
//  NSString+GetWeekDay.h
//  uavsystem
//
//  Created by lx on 2016/10/17.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GetWeekDay)

/**
 根据年月日算出对应的星期几

 @param year  年
 @param month 月
 @param day   日

 @return 星期几
 */
+ (NSString *)getWeekDayWithYear:(NSInteger )year month:(NSInteger )month day:(NSInteger )day;

@end
