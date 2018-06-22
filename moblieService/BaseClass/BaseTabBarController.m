//
//  BaseTabBarController.m
//  uavsystem
//
//  Created by zhang_jian on 16/7/4.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseTabBarController.h"

const NSString *TabBarShow_Animation_Key = @"position_show";
const NSString *TabBarHide_Animation_Key = @"position_hide";

const CGFloat tabbar_Hegith = 50;

@interface BaseTabBarController () <UITabBarControllerDelegate>

@end

@implementation BaseTabBarController
{
    UIView *m_BaseView;
    UIButton *m_SelectBtn;
    BOOL m_IsHidden;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"selectedIndex"];
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self)
    {
        m_IsHidden = NO;
        self.viewControllers = [viewControllers mutableCopy];
        [self initViewContent];
        
        [self setDelegate:self];
        
        [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
        
        [self setSelectedIndex:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    m_BaseView = [[UIView alloc] initWithFrame:[self BaseViewFrame]];
    [m_BaseView setBackgroundColor:[UIColor colorWithPatternImage:DIF_IMAGE_HEXCOLOR(@"#ffffff")]];
    [self.view addSubview:m_BaseView];
    
    UIView *headerLine = [UIView new];
    headerLine.sd_layout.topSpaceToView(m_BaseView,0).heightIs(1).widthIs(m_BaseView.width);
    [headerLine setBackgroundColor:[UIColor colorWithPatternImage:DIF_IMAGE_HEXCOLOR(@"#e8e8e8")]];
    [m_BaseView addSubview:headerLine];
}

- (CGFloat)getTabBarHeight
{
    return tabbar_Hegith;
}

- (BOOL)isHidden
{
    return m_IsHidden;
}

- (CGRect)BaseViewFrame
{
    [self hideTabBar];
    CGRect frame = self.tabBar.frame;
    
    CGFloat offset_Height = tabbar_Hegith+(is_iPHONE_X?34:0);
    frame.origin.y -= offset_Height;
    frame.size.height = offset_Height;
    return frame;
}

- (void)initViewContent
{
    __block NSArray *btnImages = @[@"新工单",@"已接工单",@"公告", @"全部"];
    CGFloat offset_Width = m_BaseView.width/self.viewControllers.count;
    DIF_WeakSelf(self)
    [self.viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DIF_StrongSelf
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(idx*(offset_Width+0), 0, offset_Width, tabbar_Hegith)];
        [btn setTag:idx+100];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@tb",btnImages[idx]]]
             forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@tb",btnImages[idx]]]
             forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@tb_normal",btnImages[idx]]] forState:UIControlStateNormal];
        [btn setSelected:NO];
        [btn addTarget:self action:@selector(SelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:btnImages[idx] forState:UIControlStateNormal];
        [btn.titleLabel setFont:DIF_DIFONTOFSIZE(11)];
        [btn setTitleColor:[CommonTool colorWithHexString:@"#9B9B9B" Alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[CommonTool colorWithHexString:@"#4DA9EA" Alpha:1] forState:UIControlStateHighlighted];
        [btn setTitleColor:[CommonTool colorWithHexString:@"#4DA9EA" Alpha:1] forState:UIControlStateSelected];
        [btn setButtonImageTitleStyle:ENUM_ButtonImageTitleStyleTop padding:3];
        [strongSelf->m_BaseView addSubview:btn];
    }];
}

- (void)SelectButtonAction:(UIButton *)btn
{
    self.selectedIndex = btn.tag-100;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedIndex"])
    {
        [self hideTabBar];
        NSInteger newIndex = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        for (int i = 0; i < self.viewControllers.count; i++)
        {
            UIButton *btn = (UIButton *)[m_BaseView viewWithTag:100+i];
            [btn setSelected:NO];
            if (i == newIndex)
            {
                [btn setSelected:YES];
                m_SelectBtn = btn;
                [self setSelectedViewController:self.viewControllers[i]];
            }
        }
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self hideTabBar];
}

- (void)showTabBarViewControllerIsAnimation:(BOOL)isAnimation
{
    [self hideTabBar];
    if (!m_BaseView.hidden)
    {
        return;
    }
    m_IsHidden = NO;
    [m_BaseView setHidden:NO];
    DIF_WeakSelf(self)
    [UIView animateWithDuration:(isAnimation?0.5:0) animations:^{
        DIF_StrongSelf
        [strongSelf->m_BaseView setAlpha:1];
    } completion:^(BOOL finished) {
        DIF_StrongSelf
        for (int i = 0; i < self.viewControllers.count; i++)
        {
            UIButton *btn = (UIButton *)[strongSelf->m_BaseView viewWithTag:100+i];
            [btn setEnabled:YES];
        }
    }];
}

- (void)hideTabBarViewControllerIsAnimation:(BOOL)isAnimation
{
    [self hideTabBar];
    m_IsHidden = YES;
    for (int i = 0; i < self.viewControllers.count; i++)
    {
        UIButton *btn = (UIButton *)[m_BaseView viewWithTag:100+i];
        [btn setEnabled:NO];
    }
    
    DIF_WeakSelf(self)
    [UIView animateWithDuration:(isAnimation?0.2:0) delay:0.0 options:UIViewAnimationOptionCurveEaseInOut   animations:^{
        DIF_StrongSelf
        [strongSelf->m_BaseView setAlpha:0];
    } completion:^(BOOL finished) {
        DIF_StrongSelf
        [strongSelf->m_BaseView setHidden:YES];
    }];
    
}

- (void)hideTabBar
{
    for (UIView *view in self.view.subviews)
    {
        if ([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width , view.frame.size.height)];
        }
        else
        {
            if([view isKindOfClass:NSClassFromString(@"UITransitionView")])
            {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
            }
        }
    }
    [self.tabBar setHidden:YES];
}

@end
