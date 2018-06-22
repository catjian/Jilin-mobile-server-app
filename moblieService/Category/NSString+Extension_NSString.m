//
//  NSString+Extension_NSString.m
//  uavsystem
//
//  Created by lx on 2016/10/18.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "NSString+Extension_NSString.h"

@implementation NSString (Extension_NSString)

- (NSRange)rangeFrom:(NSString *)startString to:(NSString *)endString
{
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return range;
}

- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString
{
    NSRange range = [self rangeFrom:startString to:endString];
    return [self substringWithRange:range];
}

@end
