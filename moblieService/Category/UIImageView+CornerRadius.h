//
//  UIImageView+CornerRadius.h
//  uavsystem
//
//  Created by zhang_jian on 16/7/7.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageView (UIImageView_CornerRadius)

- (void)setImage:(UIImage *)image CornerRadius:(CGFloat)cornerRadius;

- (void)setImage:(UIImage *)image CornerRadius:(CGFloat)cornerRadius StartAngle:(CGFloat)startAngle EndAngle:(CGFloat)endAngle;

- (void)setImage:(UIImage *)image BezierPathPoints:(NSArray *)points;

@end
