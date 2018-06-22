//
//  NSString+TransformToPinYin.m
//  uavsystem
//
//  Created by lx on 2016/10/19.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "NSString+TransformToPinYin.h"

@implementation NSString (TransformToPinYin)


+ (NSString *)transformToPinYinWithString:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    //转换成拼音
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [NSString removeSpaceAndNewline:pinyin];
}


/**
 将所有字符串中所有的空格及回车去掉

 @param str 数据源

 @return 结果
 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str  
{  
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];  
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];  
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];  
    DebugLog(@"temp=%@",temp);
    return temp;  
} 

@end
