//
//  UILabel+CallPhoneExtension.h
//  uavsystem
//
//  Created by lx on 16/8/23.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CallPhoneExtension)

- (void)callPhoneWithTarget:(nullable id)target action:(nullable SEL)action;

@end
