//
//  HomeContentCell.m
//  moblieService
//
//  Created by zhang_jian on 2018/5/30.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "HomeContentCell.h"

@implementation HomeContentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-DIF_PX(48))/2, 0,
                                                                       DIF_PX(48), DIF_PX(48))];
        [self.contentView addSubview:self.imageView];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(-DIF_PX(4), self.imageView.bottom+DIF_PX(6), self.width+DIF_PX(8), DIF_PX(24))];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"#000000")];
        [self.titleLab setFont:DIF_DIFONTOFSIZE(is_iPhone5AndEarly?10:12)];
        [self.titleLab setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

@end
