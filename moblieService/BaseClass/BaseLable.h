//
//  BaseLable.h
//  uavsystem
//
//  Created by jian zhang on 16/7/19.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ENUM_LABLE_VERTICALALIGNMENT) {
    ENUM_LABLE_VERTICALALIGNMENT_TOP = 0,
    ENUM_LABLE_VERTICALALIGNMENT_MIDDLE,
    ENUM_LABLE_VERTICALALIGNMENT_BOTTOM,
    ENUM_LABLE_VERTICALALIGNMENT_LEFT_AND_RIGHT
};

@interface BaseLable : UILabel

@property (nonatomic, assign) ENUM_LABLE_VERTICALALIGNMENT verticalAlignment;

@end
