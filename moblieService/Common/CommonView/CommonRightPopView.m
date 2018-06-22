//
//  CommonRightPopView.m
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/18.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonRightPopView.h"

@interface CommonRightPopView () <UIGestureRecognizerDelegate>

@end

@implementation CommonRightPopView
{
    UIView *m_ContentView;
}

- (instancetype)init
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        m_ContentView = [[UIView alloc] initWithFrame:CGRectMake(DIF_SCREEN_WIDTH, 0, DIF_PX(400), self.height)];
        [m_ContentView SetBackGroundColorWithHexValue:@"ffffff"];
        [self addSubview:m_ContentView];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [tapGR setDelegate:self];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)setWidth:(CGFloat)width
{
    [m_ContentView setWidth:width];
}

- (CGFloat)width
{
    return (m_ContentView.width==0?DIF_SCREEN_WIDTH:m_ContentView.width);
}

- (void)addSubview:(UIView *)view
{
    if ([view isEqual:m_ContentView])
    {
        [super addSubview:view];
    }
    else
    {
        [m_ContentView addSubview:view];
    }
}

- (void)showPopView
{
    [DIF_KeyWindow addSubview:self];
    [UIView animateWithDuration:.4 animations:^{
        [self setBackgroundColor:DIF_HEXCOLOR_ALPHA(@"000000", .5)];
        CGRect frame = m_ContentView.frame;
        frame.origin.x = DIF_SCREEN_WIDTH - self.width;
        [m_ContentView setFrame:frame];
    }];
}

- (void)hidePopView
{
    if (self.hideBlock)
    {
        self.hideBlock();
    }
    [UIView animateWithDuration:.4 animations:^{
        [self setBackgroundColor:[UIColor clearColor]];
        CGRect frame = m_ContentView.frame;
        frame.origin.x = DIF_SCREEN_WIDTH;
        [m_ContentView setFrame:frame];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UITapGestureRecognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([self findFirstResponderWithView:self] && ![touch.view isKindOfClass:[UITextField class]])
    {
        [self endEditing:YES];
        return NO;
    }
    CGPoint touchPoint = [touch locationInView:self];
    if (touchPoint.x < m_ContentView.left)
    {
        return YES;
    }
    return NO;
}

- (void)tapGestureAction:(UIGestureRecognizer *)gesture
{
    [self hidePopView];
}

- (BOOL)findFirstResponderWithView:(UIView *)view
{
    if (view.isFirstResponder)
    {
        return YES;
    }
    for (UIView* subView in view.subviews)
    {
        if([self findFirstResponderWithView:subView])
            return YES;
    }
    return NO;
}

@end
