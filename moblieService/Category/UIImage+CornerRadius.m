//
//  UIImage+CornerRadius.m
//  CircleImage
//
//  Created by li xun on 16/4/15.
//  Copyright © 2016年 lixun. All rights reserved.
//

#import "UIImage+CornerRadius.h"

@implementation UIImage (UIImage_CornerRadius)

- (UIImage *)ImageCornerRadius:(CGFloat )radius
{
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef bitmapContext = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(bitmapContext, imageRect);
    
    CGContextClip(bitmapContext);
    
    [self drawInRect:imageRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}




@end
