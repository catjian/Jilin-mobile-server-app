//
//  UIView+BackHexColor.m
//  uavsystem
//
//  Created by jian zhang on 16/7/14.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "UIView+BackHexColor.h"

@implementation UIView(UIView_BackHexColor)

- (void)SetBackGroundColorWithHexValue:(NSString *)color
{
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.bounds];
    [backImage setImage:[self imageWithColor:[self colorWithHexString:color Alpha:1]]];
    [self addSubview:backImage];
    [self sendSubviewToBack:backImage];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

- (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha
{
    NSString *cString=[[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if(cString.length<6)
    {
        return [UIColor clearColor];
    }
    
    if([cString hasPrefix:@"0X"])
    {
        cString=[cString substringFromIndex:2];
    }
    if([cString hasPrefix:@"#"])
    {
        cString=[cString substringFromIndex:1];
    }
    if(cString.length!=6)
    {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location=0;
    range.length=2;
    //r
    NSString *rString=[cString substringWithRange:range];
    //g
    range.location=2;
    NSString *gString=[cString substringWithRange:range];
    //b
    range.location=4;
    NSString *bString=[cString substringWithRange:range];
    
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
}

- (void)SetBackGroundWithImage:(NSString *)imageName
{
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.bounds];
    [backImage setImage:[UIImage imageNamed:imageName]];
    [self addSubview:backImage];
    [self sendSubviewToBack:backImage];
}

@end
