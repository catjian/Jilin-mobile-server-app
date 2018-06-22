//
//  CommonLinearGradientImage.h
//  XinBaiLi
//
//  Created by jian zhang on 2017/7/13.
//  Copyright © 2017年 wuyangfan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ENUM_Gradient_Direction) {
    ENUM_Gradient_Direction_LeftToRight,
    ENUM_Gradient_Direction_RightToLeft,
    ENUM_Gradient_Direction_TopToBottom,
    ENUM_Gradient_Direction_BottomToTop
};

@interface CommonImage : NSObject

+ (UIImage *)imageWithSize:(CGSize)size FillColor:(UIColor *)color;

+ (UIImage *)imageWithSize:(CGSize)size
               StrokeWidth:(CGFloat)width
               StrokeColor:(UIColor *)strokeColor
                   isRound:(BOOL)isround;

+ (UIImage *)imageWithSize:(CGSize)size
                 FillColor:(UIColor *)fillColor
               StrokeWidth:(CGFloat)width
               StrokeColor:(UIColor *)strokeColor;

+ (UIImage *)GetLinearGradientImageWithColors:(NSArray <NSString *>*)colors
                                         Size:(CGSize)size
                                    Direction:(ENUM_Gradient_Direction)direction;

+ (UIImage *)imageCustomWWithSize:(CGSize)size
                           Points:(NSArray <NSValue *>*)points
                        FillColor:(UIColor *)color;
@end
