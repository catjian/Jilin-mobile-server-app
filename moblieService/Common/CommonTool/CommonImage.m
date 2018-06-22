//
//  CommonLinearGradientImage.m
//  XinBaiLi
//
//  Created by jian zhang on 2017/7/13.
//  Copyright © 2017年 wuyangfan. All rights reserved.
//

#import "CommonImage.h"

@implementation CommonImage

+ (UIImage *)imageWithSize:(CGSize)size FillColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithSize:(CGSize)size
               StrokeWidth:(CGFloat)width
               StrokeColor:(UIColor *)strokeColor
                   isRound:(BOOL)isround
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    if (isround)
    {
        CGContextAddArc(context, size.width/2, size.height/2, size.width/2-width, 0, M_PI*2, 0);
    }
    else
    {
        CGContextAddRect(context, rect);
    }
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithSize:(CGSize)size
                 FillColor:(UIColor *)fillColor
               StrokeWidth:(CGFloat)width
               StrokeColor:(UIColor *)strokeColor
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, width);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)GetLinearGradientImageWithColors:(NSArray <NSString *>*)colors
                                         Size:(CGSize)size
                                    Direction:(ENUM_Gradient_Direction)direction
{
    UIImage *lgImage;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0f, 1.0f };
    NSMutableArray *mutColors = [NSMutableArray array];
    for (NSString *hexColor in colors)
    {
        UIColor *color = DIF_HEXCOLOR(hexColor);
        [mutColors addObject:(__bridge id)color.CGColor];
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) mutColors, locations);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(1, 0);
    
    switch (direction)
    {
        default:
        case ENUM_Gradient_Direction_LeftToRight:
        {
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(size.width, 0);
        }
            break;
        case ENUM_Gradient_Direction_RightToLeft:
        {
            startPoint = CGPointMake(size.width, 0);
            endPoint = CGPointMake(0, 0);
        }
            break;
        case ENUM_Gradient_Direction_TopToBottom:
        {
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(0, size.height);
        }
            break;
        case ENUM_Gradient_Direction_BottomToTop:
        {
            startPoint = CGPointMake(0, size.height);
            endPoint = CGPointMake(0, 0);
        }
            break;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, size.width);
    CGPathAddLineToPoint(path, NULL, size.width, size.height);
    CGPathAddLineToPoint(path, NULL, size.height, 0);
    CGPathCloseSubpath(path);
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
//    CGContextClip(context);
    CGContextFillPath(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGPathRelease(path);
    
    lgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return lgImage;
}

+ (UIImage *)imageCustomWWithSize:(CGSize)size
                           Points:(NSArray <NSValue *>*)points
                        FillColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGMutablePathRef path = CGPathCreateMutable();
    for (int i = 0; i < points.count; i++)
    {
        CGPoint point = [points[i] CGPointValue];
        if (i == 0)
        {
            CGPathMoveToPoint(path, NULL, point.x, point.y);
        }
        else
        {
            CGPathAddLineToPoint(path, NULL, point.x, point.y);
        }
    }
    CGPathCloseSubpath(path);
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGPathRelease(path);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
