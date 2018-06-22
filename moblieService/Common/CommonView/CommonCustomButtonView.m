//
//  CommonCustomButtonView.m
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/22.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonCustomButtonView.h"
#import "CustomRoundButton.h"

@interface CommonCustomButtonView () <UIGestureRecognizerDelegate, CAAnimationDelegate>

@end

@implementation CommonCustomButtonView
{
    CustomRoundButton *m_BtnBGV;
    UILabel *m_TitleLab;
    UIImageView *m_IconIV;
    BOOL m_isCumulative;
}

- (instancetype)initWithViewFrame:(CGRect)frame
                      ButtonFrame:(CGRect)btnFrame
                      inSmallIcon:(NSString *)iconName
                      ButtonTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self createButtonView:btnFrame];
        self.smallIconName = iconName;
        if (iconName)
        {
            [self createIconImage:iconName];
        }
        if (title)
        {
            [self createTitle:title];
        }
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [tapGR setDelegate:self];
        [self addGestureRecognizer:tapGR];
        m_isCumulative = YES;
    }
    return self;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [m_BtnBGV setFillColor:fillColor];
    [m_BtnBGV setNeedsDisplay];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    [m_BtnBGV setStrokeColor:strokeColor];
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    if (!shadowColor)
    {
        _shadowColor = shadowColor;
    }
    [m_BtnBGV setShadowColor:shadowColor];
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    _shadowOffset = shadowOffset;
    
    CGFloat loseValue = shadowOffset.width>shadowOffset.height?shadowOffset.width:shadowOffset.height;
    if (m_TitleLab)
    {
        m_TitleLab.centerY -= loseValue;
    }
    if (m_IconIV)
    {
        m_IconIV.centerY -= loseValue;
    }
    [m_BtnBGV setShadowOffset:shadowOffset];
}

- (void)setShadowBlur:(CGFloat)shadowBlur
{
    _shadowBlur = shadowBlur;
    [m_BtnBGV setShadowBlur:shadowBlur];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [m_TitleLab setFont:titleFont];
}

#pragma mark - Build SubView
- (void)createButtonView:(CGRect)btnFrame
{
    m_BtnBGV = [[CustomRoundButton alloc] initWithFrame:btnFrame];
    [m_BtnBGV setFillColor:DIF_HEXCOLOR_ALPHA(@"#ffffff",.1f)];
    [m_BtnBGV setStrokeColor:DIF_HEXCOLOR_ALPHA(@"#FFFFFF",.3f)];
    [self addSubview:m_BtnBGV];
}

- (void)createIconImage:(NSString *)icomName
{
    m_IconIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(40), DIF_PX(40))];
    [m_IconIV setBackgroundColor:[UIColor clearColor]];
    [m_IconIV setImage:[UIImage imageNamed:icomName]];
    [self addSubview:m_IconIV];
    [m_IconIV setCenter:m_BtnBGV.center];
}


- (void)createTitle:(NSString *)title
{
    m_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_BtnBGV.width-20, DIF_PX(24))];
    [m_TitleLab setCenter:m_BtnBGV.center];
    [m_TitleLab setText:title];
    [m_TitleLab setTextColor:DIF_HEXCOLOR(@"#FFFFFF")];
    [m_TitleLab setFont:DIF_UIFONTOFSIZE(DIF_FONT(24))];
    [m_TitleLab setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:m_TitleLab];
}

#pragma mark - public method
- (void)ButtonTitleWithContent:(NSString *)content
{
    [m_TitleLab performSelectorOnMainThread:@selector(setText:) withObject:content waitUntilDone:NO];
}

- (void)ButtonUnitBeSet:(NSString *)unit
{
    if (!unit)
    {
        return;
    }
    UILabel *unitlab = [[UILabel alloc] initWithFrame:CGRectMake(m_TitleLab.left+10, m_TitleLab.bottom, m_TitleLab.width-20, m_TitleLab.height)];
    [unitlab setTextColor:DIF_HEXCOLOR(@"#FFFFFF")];
    [unitlab setFont:DIF_UIFONTOFSIZE(DIF_FONT(24))];
    [unitlab setTextAlignment:NSTextAlignmentCenter];
    [unitlab setText:[NSString stringWithFormat:@"(%@)",unit]];
    [self addSubview:unitlab];
}

- (UIView *)getButtonView
{
    return m_BtnBGV;
}

- (void)ButtonIconWithImage:(UIImage *)icon
{
    [m_IconIV performSelectorOnMainThread:@selector(setImage:) withObject:icon waitUntilDone:NO];
}

#pragma mark - UITapGestureRecognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInView:self];
    if (touchPoint.x > m_BtnBGV.left && touchPoint.x < m_BtnBGV.right &&
        touchPoint.y > m_BtnBGV.top && touchPoint.y < m_BtnBGV.bottom)
    {
        return YES;
    }
    return NO;
}

- (void)tapGestureAction:(UIGestureRecognizer *)gesture
{
    m_isCumulative = YES;
    [self beginScaleAniamtionWithFillColor:(self.heightColor?self.heightColor:DIF_HEXCOLOR(@"ffffff"))];
    if (self.eventBlock)
    {
        self.eventBlock(self,m_BtnBGV);
    }
}

#pragma mark - Animation
- (void)beginScaleAniamtionWithFillColor:(UIColor *)fillColor
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:m_BtnBGV.bounds
                                                    cornerRadius:(m_BtnBGV.width/2)-1];
    CAShapeLayer *solidRound =  [CAShapeLayer layer];
    solidRound.fillColor = fillColor.CGColor;
    solidRound.anchorPoint = CGPointMake(.5, .5);
    [solidRound setFrame:m_BtnBGV.bounds];
    solidRound.path = path.CGPath;
    [solidRound setName:@"ScaleAniamtion"];
    [m_BtnBGV.layer addSublayer:solidRound];
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scaleAni setDelegate:self];
    [scaleAni setFromValue:[NSNumber numberWithFloat:.1]];
    [scaleAni setToValue:[NSNumber numberWithFloat:1]];
    [scaleAni setDuration:.2];
    [scaleAni setCumulative:NO];
    [solidRound addAnimation:scaleAni forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (!m_isCumulative)
    {
//        [m_BtnBGV setNeedsDisplay];
    }
    else
    {
        [self beginScaleAniamtionWithFillColor:self.fillColor];
        m_isCumulative = NO;
        return;
    }
    for (int i = (int)m_BtnBGV.layer.sublayers.count-1; i >= 0; i--)
    {
        CALayer *layer = m_BtnBGV.layer.sublayers[i];
        if ([layer.name isEqualToString:@"ScaleAniamtion"])
        {
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
            continue;
        }
    }
}

@end
