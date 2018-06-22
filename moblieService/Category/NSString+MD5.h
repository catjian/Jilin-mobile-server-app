//
//  NSString+MD5.h
//  YuBao
//
//  Created by hok on 10/11/15.
//  Copyright © 2015 hok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

- (NSString *)md5HexDigest;

+ (NSString *)md5HexDigest:(NSString*)input;
+ (BOOL)isPureInt:(NSString*)string;
+ (BOOL)isPureFloat:(NSString*)string;

@end
