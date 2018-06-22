//
//  CutomRoundButton.m
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/22.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CustomRoundButton.h"

@interface CustomRoundButton() <CAAnimationDelegate>

@end

@implementation CustomRoundButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat loseValue = 0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, DIF_PX(2));
    if (self.strokeColor)
    {
        CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
        loseValue += DIF_PX(2);
    }
    if (self.fillColor)
    {
        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    }
    if (self.shadowColor)
    {
        self.shadowOffset = CGSizeEqualToSize(self.shadowOffset, CGSizeZero)?CGSizeMake(5, 5):self.shadowOffset;
        self.shadowBlur = self.shadowBlur == .0f?5.f:self.shadowBlur;
        if ([self.shadowColor isEqual:DIF_HEXCOLOR_ALPHA(@"000000",0)])
        {
            CGContextSetShadow(context, self.shadowOffset, self.shadowBlur);
        }
        else
        {
            CGContextSetShadowWithColor(context, self.shadowOffset, self.shadowBlur, self.shadowColor.CGColor);
        }
        
        loseValue += self.shadowOffset.width>self.shadowOffset.height?self.shadowOffset.width:self.shadowOffset.height;
    }
    
    CGPoint point = CGPointMake(rect.size.width/2, rect.size.height/2-(loseValue==DIF_PX(2)?0:loseValue-DIF_PX(2)));
    CGContextAddArc(context, point.x, point.y, rect.size.width/2-loseValue, 0, 2*M_PI, 0);
    CGContextDrawPath(context,kCGPathFillStroke);
}

@end
