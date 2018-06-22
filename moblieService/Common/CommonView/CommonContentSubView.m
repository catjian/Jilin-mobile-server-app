//
//  CommonContentSubView.m
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/28.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonContentSubView.h"

@implementation CommonContentSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(22), DIF_PX(22))];
        [self.iconImage setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.iconImage];
        
        self.titlelab = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImage.right + 5, self.iconImage.top,
                                                                  self.width-self.iconImage.right-10, self.iconImage.height)];
        [self.titlelab setFont:DIF_UIFONTOFSIZE(DIF_FONT(22))];
        [self.titlelab setTextColor:DIF_HEXCOLOR(@"#2c2c2c")];
        [self addSubview:self.titlelab];
        
        self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImage.left+5, self.iconImage.bottom,
                                                                   self.width-10, self.height - self.iconImage.bottom)];
        [self.detailLab setTextColor:DIF_HEXCOLOR(@"#2c2c2c")];
        [self addSubview:self.detailLab];
    }
    return self;
}

@end
