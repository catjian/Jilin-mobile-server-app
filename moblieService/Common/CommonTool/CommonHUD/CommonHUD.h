//
//  CommonHUD.h
//  uavsystem
//
//  Created by jian zhang on 16/8/20.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHUD : NSObject

+ (void)hideHUDAnimation:(BOOL)isAnimation;

+ (void)hideHUD;

+ (MBProgressHUD *)showHUD;

+ (void)showHUDWithMessage:(NSString *)message;

+ (void)delayShowHUDWithMessage:(NSString *)message;

+ (void)delayShowHUDWithMessage:(NSString *)message delayTime:(NSTimeInterval)interval;

@end
