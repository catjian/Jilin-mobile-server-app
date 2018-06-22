//
//  CommonCommitButton.m
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/23.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonCommitButton.h"

@implementation CommonCommitButton

+ (UIButton *)commitButtonWithFrame:(CGRect)frame
                              Title:(NSString *)title
                         TitleColor:(NSString *)colorTitle
                    BackGroundColor:(NSString *)colorBG
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:DIF_HEXCOLOR(colorTitle) forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    if (colorBG)
    {
        [btn setBackgroundColor:DIF_HEXCOLOR(colorBG)];
    }
    [btn setFrame:frame];
    [btn.layer setCornerRadius:frame.size.height/2];
    [btn.layer setMasksToBounds:YES];
    return btn;
}

@end
