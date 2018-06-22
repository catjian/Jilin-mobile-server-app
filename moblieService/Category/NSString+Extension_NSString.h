//
//  NSString+Extension_NSString.h
//  uavsystem
//
//  Created by lx on 2016/10/18.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension_NSString)

- (NSRange)rangeFrom:(NSString *)startString to:(NSString *)endString;

- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;

@end
