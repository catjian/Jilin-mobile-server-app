//
//  CommonPopWarnView.m
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/28.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonPopWarnView.h"

@implementation CommonPopWarnView
{
    CommonPopWarnViewSuccessBlock m_Block;
    UIView *m_ContentView;
}

- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                      Message:(NSString *)message
                SuccessButton:(NSString *)success
                  CloseButton:(NSString *)close
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self createContentViewWithTitle:title Message:message SuccessButton:success CloseButton:close];
    }
    return self;
}

- (void)createContentViewWithTitle:(NSString *)title
                           Message:(NSString *)message
                     SuccessButton:(NSString *)success
                       CloseButton:(NSString *)close
{
    m_ContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(548), DIF_PX(354))];
    [m_ContentView setAlpha:0];
    [m_ContentView setCenter:self.center];
    [m_ContentView setBackgroundColor:DIF_HEXCOLOR(@"#ffffff")];
    [m_ContentView.layer setCornerRadius:DIF_PX(10)];
    [m_ContentView.layer setMasksToBounds:YES];
    [self addSubview:m_ContentView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_ContentView.width, DIF_PX(84))];
    [imageView setImage:[UIImage imageNamed:@"index_bg_Popup"]];
    [m_ContentView addSubview:imageView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:imageView.bounds];
    [titleLab setTextColor:DIF_HEXCOLOR(@"ffffff")];
    [titleLab setText:title];
    [titleLab setFont:DIF_UIFONTOFSIZE(DIF_FONT(32))];
    [titleLab setTextAlignment:NSTextAlignmentCenter];
    [m_ContentView addSubview:titleLab];
    
    UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left+DIF_PX(40), imageView.bottom+DIF_PX(40), m_ContentView.width-DIF_PX(80), DIF_PX(120))];
    [detailLab setTextColor:DIF_HEXCOLOR(@"#161616")];
    [detailLab setNumberOfLines:0];
    [detailLab setFont:DIF_UIFONTOFSIZE(DIF_FONT(DIF_BaseFont_Size))];
    [detailLab setText:message];
    [detailLab setTextAlignment:NSTextAlignmentLeft];
    [m_ContentView addSubview:detailLab];
    CGSize messageSize = [message sizeWithAttributes:@{NSFontAttributeName:detailLab.font}];
    int lineNum = ceilf(messageSize.width / detailLab.width);
    lineNum += [message componentsSeparatedByString:@"\n"].count-1;
    if (lineNum > 2)
    {
        CGFloat height = 60 * (lineNum);
        [detailLab setHeight:DIF_PX(height)];
        [m_ContentView setHeight:DIF_PX(354-120+height)];
    }
    else if (lineNum <= 1)
    {
        [detailLab setTextAlignment:NSTextAlignmentCenter];
    }
    
    UIButton *sucBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sucBtn setFrame:CGRectMake(DIF_PX(30), m_ContentView.height-DIF_PX(30+60), DIF_PX(230), DIF_PX(60))];
    [sucBtn addTarget:self action:@selector(commonPopContentSelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sucBtn setTitleColor:DIF_HEXCOLOR(@"#ffffff") forState:UIControlStateNormal];
    [sucBtn setBackgroundImage:[CommonImage imageWithSize:sucBtn.size FillColor:DIF_HEXCOLOR(DIF_BACK_BLUE_COLOR)]
                      forState:UIControlStateNormal];
    [sucBtn setTitle:success forState:UIControlStateNormal];
    [sucBtn.layer setCornerRadius:sucBtn.height/2];
    [sucBtn.layer setMasksToBounds:YES];
    [m_ContentView addSubview:sucBtn];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setFrame:CGRectMake(sucBtn.right+DIF_PX(40), sucBtn.top, sucBtn.width, sucBtn.height)];
    [closeBtn addTarget:self action:@selector(closePopWarnView) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:DIF_HEXCOLOR(@"2c2c2c") forState:UIControlStateNormal];
    [closeBtn setBackgroundColor:[UIColor clearColor]];
    [closeBtn.titleLabel setFont:DIF_UIFONTOFSIZE(DIF_FONT(28))];
    [closeBtn setTitle:close forState:UIControlStateNormal];
    [closeBtn.layer setBorderWidth:1];
    [closeBtn.layer setBorderColor:DIF_HEXCOLOR(DIF_BACK_BLUE_COLOR).CGColor];
    [closeBtn.layer setCornerRadius:closeBtn.height/2];
    [m_ContentView addSubview:closeBtn];
    
    if (!success || !close)
    {
        [closeBtn setHidden:YES];
        [sucBtn setCenterX:m_ContentView.width/2];
    }
}

- (void)commonPopContentSelectButtonAction:(UIButton *)btn
{
    if (m_Block)
    {
        m_Block(NO);
    }
    [UIView animateWithDuration:.4 animations:^{
        [self setBackgroundColor:[UIColor clearColor]];
        [m_ContentView setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)closePopWarnView
{
    if (m_Block)
    {
        m_Block(YES);
    }
    [UIView animateWithDuration:.4 animations:^{
        [self setBackgroundColor:[UIColor clearColor]];
        [m_ContentView setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showPopWarnView:(CommonPopWarnViewSuccessBlock)block
{
    m_Block = block;
    [DIF_KeyWindow addSubview:self];
    [UIView animateWithDuration:.4 animations:^{
        [m_ContentView setAlpha:1];
        [self setBackgroundColor:DIF_HEXCOLOR_ALPHA(@"000000", .5)];
    }];
}

+ (CommonPopWarnView *)showPopWarnViewWithTitle:(NSString *)title
                                        Message:(NSString *)message
                                  SuccessButton:(NSString *)success
                                    CloseButton:(NSString *)close
                                     EventBlock:(CommonPopWarnViewSuccessBlock)block
{
    CommonPopWarnView *kbView = nil;
    for (UIView *view in DIF_KeyWindow.subviews)
    {
        if ([view isKindOfClass:[CommonPopWarnView class]])
        {
            kbView = (CommonPopWarnView *)view;
        }
    }
    if (!kbView)
    {
        kbView = [[CommonPopWarnView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                    Title:title
                                                  Message:message
                                            SuccessButton:success
                                              CloseButton:close];
    }
    [kbView showPopWarnView:block];
    return kbView;
}
@end
