//
//  CommonGetIPAddress.h
//  uavsystem
//
//  Created by jian zhang on 2017/1/5.
//  Copyright © 2017年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonGetIPAddress : NSObject

+ (NSString *)getIpAddresses;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

@end
