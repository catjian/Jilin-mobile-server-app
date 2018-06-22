//
//  UIImageView+CornerRadius.m
//  uavsystem
//
//  Created by zhang_jian on 16/7/7.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "UIImageView+CornerRadius.h"

@implementation UIImageView (UIImageView_CornerRadius)

- (void)setImage:(UIImage *)image CornerRadius:(CGFloat)cornerRadius
{
//    dispatch_async(dispatch_queue_create("UIImageView_CornerRadius", 0), ^{
        [self setImage:image];
        UIImage *imageNew = nil;
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
        CGContextRef currnetContext = UIGraphicsGetCurrentContext();
        if (currnetContext) {       
            CGContextAddPath(currnetContext, [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius].CGPath);
            CGContextClip(currnetContext);
            [self.layer renderInContext:currnetContext];
            imageNew = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([imageNew isKindOfClass:[UIImage class]])
            {
                self.image = imageNew;
            }
            else
            {
                [self setImage:image CornerRadius:cornerRadius];
            }
        });
//    });
}

- (void)setImage:(UIImage *)image CornerRadius:(CGFloat)cornerRadius StartAngle:(CGFloat)startAngle EndAngle:(CGFloat)endAngle
{
    dispatch_async(dispatch_queue_create("UIImageView_CornerRadius", 0), ^{
        [self setImage:image];
        UIImage *imageNew = nil;
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
        CGContextRef currnetContext = UIGraphicsGetCurrentContext();
        if (currnetContext) {
            CGContextAddPath(currnetContext, [UIBezierPath bezierPathWithArcCenter:self.center radius:cornerRadius startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath);
//            CGContextAddArc(currnetContext, self.centerX, self.centerY, 10, startAngle, endAngle, YES);
            CGContextClip(currnetContext);
            [self.layer renderInContext:currnetContext];
            imageNew = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([imageNew isKindOfClass:[UIImage class]])
            {
                self.image = imageNew;
            }
            else
            {
                [self setImage:image CornerRadius:cornerRadius];
            }
        });
    });
}

- (void)setImage:(UIImage *)image BezierPathPoints:(NSArray *)points
{
    [self setImage:image];
    UIImage *imageNew = nil;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    if (currnetContext)
    {
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path moveToPoint:CGPointMake(0, 667)];
//        [path addLineToPoint:CGPointMake(0, 330)];
//        [path addCurveToPoint:CGPointMake(150, 300) controlPoint1:CGPointMake(35, 100) controlPoint2:CGPointMake(50, 400)];
//        [path addQuadCurveToPoint:CGPointMake(200, 265) controlPoint:CGPointMake(170, 280)];
//        [path addCurveToPoint:CGPointMake(415, 290) controlPoint1:CGPointMake(230, 250) controlPoint2:CGPointMake(280, 350)];
//        [path addLineToPoint:CGPointMake(415, 667)];
//        CGContextAddPath(currnetContext, path.CGPath);
        
        CGFloat pi = M_PI*2;
        CGContextMoveToPoint(currnetContext, 0, 667);
        for (int i = 0; i < self.bounds.size.width; i+=2)
        {
            CGFloat radio = 1.f;
            radio -= (i-100)* (1.f/100.f);
            CGFloat sinfv = (sinf(pi * radio));
            CGFloat offset_y = sinfv*100 + 300;
            CGContextAddLineToPoint(currnetContext, i, offset_y);
            pi -= M_PI*2/self.bounds.size.width;
        }
        CGContextAddLineToPoint(currnetContext, 415, 667);
        
        CGContextClip(currnetContext);
        [self.layer renderInContext:currnetContext];
        imageNew = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([imageNew isKindOfClass:[UIImage class]])
        {
            self.image = imageNew;
        }
    });
}

@end
