//
//  CommonPopShareView.m
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/29.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonPopShareView.h"

@implementation CommonPopShareView
{
    CommonPopShareViewChoseShareBlock m_Block;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:DIF_HEXCOLOR_ALPHA(@"#000000",.7)];
        [self setAlpha:0];
        UIView *view = [self createContentView];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setFrame:CGRectMake(0, view.bottom+DIF_PX(16), DIF_PX(620), DIF_PX(80))];
        [closeBtn setCenterX:self.width/2];
        [closeBtn setTitleColor:DIF_HEXCOLOR(DIF_BACK_ORANGE_COLOR) forState:UIControlStateNormal];
        [closeBtn setBackgroundColor:[UIColor whiteColor]];
        [closeBtn.titleLabel setFont:DIF_UIFONTOFSIZE(DIF_FONT(28))];
        [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
        [closeBtn.layer setCornerRadius:DIF_PX(10)];
        [closeBtn addTarget:self action:@selector(closePopShareView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
    }
    return self;
}

- (UIView *)createContentView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(620), DIF_PX(0))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"#ffffff")];
    [view.layer setCornerRadius:DIF_PX(10)];
    [view.layer setMasksToBounds:YES];
    [self addSubview:view];
    
    CGFloat offset_height = DIF_PX(84);
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, offset_height)];
    [titleLab setCenterX:view.width/2];
    [titleLab setTextColor:DIF_HEXCOLOR(@"#2c2c2c")];
    [titleLab setText:@"发送到"];
    [titleLab setTextAlignment:NSTextAlignmentCenter];
    [titleLab setFont:DIF_UIFONTOFSIZE(DIF_FONT(28))];
    [view addSubview:titleLab];
    offset_height += DIF_PX(4);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, offset_height, view.width-DIF_PX(40), 1)];
    [line setBackgroundColor:DIF_HEXCOLOR(DIF_CELL_SEPARATOR_COLOR)];
    [line setCenterX:view.width/2];
    [view addSubview:line];
    offset_height++;
    offset_height += DIF_PX(4);
    
    CGFloat offset_width = DIF_PX(200);
    NSArray *shareIcon = @[@"icon_weixin", @"icon_QQ", @"icon_save"];
    NSArray *shareTitle = @[@"微信", @"QQ", @"本地"];
    for (int i = 0; i < shareIcon.count; i++)
    {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareBtn setFrame:CGRectMake((i%3==2?view.width-offset_width:0), offset_height, offset_width, offset_width)];
        [shareBtn setTag:10000+i];
        [shareBtn setBackgroundColor:[UIColor clearColor]];
        [shareBtn setImage:[UIImage imageNamed:shareIcon[i]] forState:UIControlStateNormal];
        [shareBtn setTitle:shareTitle[i] forState:UIControlStateNormal];
        [shareBtn setTitleColor:DIF_HEXCOLOR(@"#2c2c2c") forState:UIControlStateNormal];
        [shareBtn.titleLabel setFont:DIF_UIFONTOFSIZE(DIF_FONT(24))];
        [shareBtn setButtonImageTitleStyle:ENUM_ButtonImageTitleStyleTop padding:DIF_PX(16)];
        [shareBtn addTarget:self action:@selector(ShareClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:shareBtn];
        if (i%3 == 1)
        {
            [shareBtn setCenterX:view.width/2];
        }
        if (i%3 == 2 || i == shareIcon.count-1)
        {
            offset_height += offset_width;
        }
    }
    [view setHeight:offset_height];
    [view setCenter:self.center];
    return view;
}

- (void)ShareClickButtonAction:(UIButton *)btn
{
    if (m_Block)
    {
        m_Block(btn.tag - 10000);
    }
}

- (void)closePopShareView
{
    [UIView animateWithDuration:.4 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showPopShareView:(CommonPopShareViewChoseShareBlock)block
{
    m_Block = block;
    [DIF_KeyWindow addSubview:self];
    [UIView animateWithDuration:.4 animations:^{
        [self setAlpha:1];
    }];
}

+ (CommonPopShareView *)showPopShareViewEventBlock:(CommonPopShareViewChoseShareBlock)block
{
    CommonPopShareView *kbView = nil;
    for (UIView *view in DIF_KeyWindow.subviews)
    {
        if ([view isKindOfClass:[CommonPopShareView class]])
        {
            kbView = (CommonPopShareView *)view;
        }
    }
    if (!kbView)
    {        
        kbView = [[CommonPopShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    [kbView showPopShareView:block];
    return kbView;
}
@end
