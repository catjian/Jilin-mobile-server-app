//
//  CommonPageControlView.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/4/8.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import "CommonPageControlView.h"

@interface CommonPageControlView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation CommonPageControlView
{
    UIScrollView *_scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self createItemWithData:titles];
    }
    return self;
}



- (void)createItemWithData:(NSArray<NSString *> *)data
{
    for (NSInteger i = 0; i < data.count; i ++)
    {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(self.width / data.count * i, 0, self.width / data.count, self.height);
        label.text = data[i];
        label.tag = i;
        label.font = DIF_DIFONTOFSIZE(28);
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 0)
        {
            label.textColor = DIF_HEXCOLOR(@"#338377");
            CGRect attrsRect = [[data firstObject] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{NSFontAttributeName : label.font}
                                                  context:nil];
            self.indicatorView.size = CGSizeMake(attrsRect.size.width, 1);
            self.indicatorView.centerX = label.centerX;
            self.indicatorView.bottom = self.height - 1;
            [self addSubview:self.indicatorView];
        }
        else
        {
            label.textColor = DIF_HEXCOLOR(@"#000000");
        }
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelAction:)]];
        [self addSubview:label];
    }
}

- (void)labelAction:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(selectedIndex:)]) {
        [_delegate selectedIndex:index];
    }
    if (self.selectBlock)
    {
        self.selectBlock(index);
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            if (label.tag == index) {
                UIView *indicatorView = [self viewWithTag:10];
                [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    label.textColor = DIF_HEXCOLOR(@"#338377");
                    CGRect attrsRect = [label.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                             attributes:@{NSFontAttributeName : label.font}
                                                                context:nil];
                    indicatorView.size = CGSizeMake(attrsRect.size.width, 1);
                    indicatorView.centerX = label.centerX;
                    indicatorView.bottom = self.height - 1;
                } completion:NULL];
            } else {
                [UIView animateWithDuration:0.3 animations:^{
                    label.textColor = DIF_HEXCOLOR(@"#000000");
                }];
            }
        }
    }
}


- (UIView *)indicatorView
{
    if (!_indicatorView)
    {
        _indicatorView = [UIView new];
        _indicatorView.tag = 10;
        _indicatorView.backgroundColor = DIF_HEXCOLOR(@"#338377");
    }
    return _indicatorView;
}

@end
