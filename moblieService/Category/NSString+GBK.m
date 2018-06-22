//
//  NSString+GBK.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/22.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NSString+GBK.h"

@implementation NSString (NSString_GBK)

- (NSString *)stringEncodeGBK
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
    return result;
}

- (NSString *)stringDecodeGBK
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)self, CFSTR(""),kCFStringEncodingUTF8));
    return result;
}

@end
