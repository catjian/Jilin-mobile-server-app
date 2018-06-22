//
//  CommonTopShowLineView.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2017/8/10.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonTopShowLineView.h"

@implementation CommonTopShowLineView

- (instancetype)initWithFrame:(CGRect)frame ContentMessage:(NSString *)message
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:DIF_HEXCOLOR_ALPHA(@"#000000",.7)];
        [self setAlpha:0];
        [self createContentView:message];
    }
    return self;
}

- (void)createContentView:(NSString *)message
{
    UILabel *lab = [[UILabel alloc] initWithFrame:self.bounds];
    [lab setTextColor:DIF_HEXCOLOR(@"ffffff")];
    [lab setFont:DIF_DIFONTOFSIZE(DIF_BaseFont_Size)];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setText:message];
    [self addSubview:lab];
}

- (void)closeTopShowLineView
{
    [UIView animateWithDuration:.4 animations:^{
        [self setAlpha:0];
        [self setTop:-100];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showTopShowLineView
{
    [DIF_KeyWindow addSubview:self];
    [UIView animateWithDuration:.4 animations:^{
        [self setAlpha:1];
        [self setTop:0];
    }];
    [self performSelector:@selector(closeTopShowLineView) withObject:nil afterDelay:2];
}

+ (void)ShowTopShowLineViewWithContentMessage:(NSString *)message
{
    CommonTopShowLineView *kbView = nil;
    for (UIView *view in DIF_KeyWindow.subviews)
    {
        if ([view isKindOfClass:[CommonTopShowLineView class]])
        {
            kbView = (CommonTopShowLineView *)view;
        }
    }
    if (!kbView)
    {
        kbView = [[CommonTopShowLineView alloc] initWithFrame:CGRectMake(0, -100, DIF_SCREEN_WIDTH, 100)
                                               ContentMessage:message];
    }
    [kbView showTopShowLineView];
}

@end
