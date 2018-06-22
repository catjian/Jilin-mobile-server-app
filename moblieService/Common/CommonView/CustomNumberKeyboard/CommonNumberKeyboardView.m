//
//  CommonNumberKeyboardView.m
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/29.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonNumberKeyboardView.h"

static UIImage *imageWithColor(UIColor *color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, DIF_SCREEN_WIDTH, DIF_TOP_POINT);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@implementation CommonNumberKeyboardView
{
    CommonNumberKeyboardEventBlock m_Block;
    UIView *m_keyboardView;
}

- (instancetype)initWithEventBlock:(CommonNumberKeyboardEventBlock)block
{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height = 261;
    self = [super initWithFrame:frame];
    if (self)
    {
        m_Block = block;
        [self setBackgroundColor:[UIColor clearColor]];
        [self createNumberKeyboard];
    }
    return self;
}

- (void)createNumberKeyboard
{
    m_keyboardView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.width, 259)];
    [m_keyboardView setBackgroundColor:[UIColor colorWithRed:163.f/255.f green:163.f/255.f blue:163.f/255.f alpha:1]];
    [self addSubview:m_keyboardView];
    CGFloat offset_widht = (m_keyboardView.width-2)/3;
    CGFloat offset_height = 64;
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(j*(offset_widht+1), i*(offset_height+1), offset_widht, offset_height)];
            [btn setTitleColor:[UIColor colorWithRed:44.f/255.f green:44.f/255.f blue:44.f/255.f alpha:1] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:255.f/255.f green:255.f/255.f blue:255.f/255.f alpha:1] forState:UIControlStateHighlighted];
            [btn setBackgroundColor:[UIColor colorWithRed:243.f/255.f green:243.f/255.f blue:243.f/255.f alpha:1]];
            [btn setBackgroundImage:imageWithColor([UIColor colorWithRed:191.f/255.f green:192.f/255.f blue:198.f/255.f alpha:1])
                           forState:UIControlStateHighlighted];
            if (3 != i)
            {
                [btn setTitle:[@((j+1)+i*3) stringValue] forState:UIControlStateNormal];
            }
            else
            {
                
                [btn setTitle:@[@".", @"0", @""][j] forState:UIControlStateNormal];
                if (j != 1)
                {
                    [btn setTitleColor:[UIColor colorWithRed:44.f/255.f green:44.f/255.f blue:44.f/255.f alpha:1] forState:UIControlStateHighlighted];
                    [btn setTitleColor:[UIColor colorWithRed:255.f/255.f green:255.f/255.f blue:255.f/255.f alpha:1] forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor colorWithRed:191.f/255.f green:192.f/255.f blue:198.f/255.f alpha:1]];
                    [btn setBackgroundImage:imageWithColor([UIColor colorWithRed:243.f/255.f green:243.f/255.f blue:243.f/255.f alpha:1])
                                   forState:UIControlStateHighlighted];
                }
                if (j == 2)
                {
                    [btn setImage:[UIImage imageNamed:@"del_btn"] forState:UIControlStateNormal];
                }
            }
            [btn addTarget:self action:@selector(NumberKeyboardClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [m_keyboardView addSubview:btn];
        }
    }
}

- (void)NumberKeyboardClickAction:(UIButton *)btn
{
    if (m_Block)
    {
        m_Block(btn.titleLabel.text);
    }
}

+ (CommonNumberKeyboardView *)showNumberKeyboardEventBlock:(CommonNumberKeyboardEventBlock)block
{
    for (UIView *view in DIF_KeyWindow.subviews)
    {
        if ([view isKindOfClass:[CommonNumberKeyboardView class]])
        {
            return (CommonNumberKeyboardView *)view;
        }
    }
    CommonNumberKeyboardView *kbView = [[CommonNumberKeyboardView alloc] initWithEventBlock:block];
    return kbView;
}

@end
