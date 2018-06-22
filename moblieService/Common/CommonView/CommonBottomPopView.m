//
//  CommonBottomPopView.m
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/21.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonBottomPopView.h"

@interface CommonBottomPopView () <UIGestureRecognizerDelegate>

@end

@implementation CommonBottomPopView

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
        m_ContentView = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_SCREEN_HEIGHT, DIF_SCREEN_WIDTH, self.height)];
        [m_ContentView SetBackGroundColorWithHexValue:@"ffffff"];
        [self addSubview:m_ContentView];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [tapGR setDelegate:self];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)setHeight:(CGFloat)height
{
    if ([NSThread isMainThread])
    {
        [m_ContentView setHeight:height];
        return;
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        [m_ContentView setHeight:height];
    });
}

- (CGFloat)height
{
    return (m_ContentView.height==0?DIF_SCREEN_HEIGHT:m_ContentView.height);
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

- (BOOL)checkSubViewSameView
{
    BOOL isSame = NO;
    int indexKeyWin[50] = {0};
    int subLenght = 0;
    for (int i = 0; i < DIF_KeyWindow.subviews.count; i++)
    {
        UIView *subView = DIF_KeyWindow.subviews[i];
        if ([NSStringFromClass(subView.class) isEqualToString:@"CommonBottomPopView"])
        {
            indexKeyWin[subLenght] = i;
            subLenght++;
        }
    }
    for (int i = 0; i < subLenght-1; i++)
    {
        int indexNumS = indexKeyWin[i];
        UIView *subView = DIF_KeyWindow.subviews[indexNumS];
        for (int j = i+1; j < subLenght; j++)
        {
            int indexNumSS = indexKeyWin[j];
            UIView *ssubView = DIF_KeyWindow.subviews[indexNumSS];
            UIView * sLastObject = subView.subviews.lastObject;
            UIView * ssLastObject = ssubView.subviews.lastObject;
            if ([NSStringFromClass(sLastObject.class) isEqual:NSStringFromClass(ssLastObject.class)])
            {
                isSame = YES;
                [self removeFromSuperview];
                return isSame;
            }
        }
    }
    return isSame;
}

- (void)showPopView
{
    [DIF_KeyWindow addSubview:self];
//    if ([self checkSubViewSameView])
//    {
//        return;
//    }
    [UIView animateWithDuration:.4 animations:^{
        [self setBackgroundColor:DIF_HEXCOLOR_ALPHA(@"000000", .5)];
        CGRect frame = m_ContentView.frame;
        frame.origin.y = DIF_SCREEN_HEIGHT - self.height;
        [m_ContentView setFrame:frame];
    }];
}

- (void)hidePopView
{
    if (self.closeBlock)
    {
        self.closeBlock();
    }
    [UIView animateWithDuration:.4 animations:^{
        [self setBackgroundColor:[UIColor clearColor]];
        CGRect frame = m_ContentView.frame;
        frame.origin.y = DIF_SCREEN_HEIGHT;
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
    if (touchPoint.y < m_ContentView.top)
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

