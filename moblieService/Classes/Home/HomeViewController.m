//
//  HomeViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/5/30.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBaseView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    HomeBaseView *m_BaseView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(YES);
    [m_BaseView refreshUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *leftBtn = [self setLeftItemWithContentName:@"全部"];
    [leftBtn.titleLabel setFont:DIF_DIFONTOFSIZE(is_iPhone5AndEarly?24:28)];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftBtn setTitleColor:DIF_HEXCOLOR(@"#25313F") forState:UIControlStateNormal];
    [self setRightItemsWithContentNames:@[@"设置",@"个人"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {        
        m_BaseView = [[HomeBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
    }
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    if (btn.tag == 50011)
    {
        [self loadViewController:@"CustomCenterViewController" hidesBottomBarWhenPushed:YES];
    }
    else
    {        
        [self loadViewController:@"ConfigServiceHostViewController" hidesBottomBarWhenPushed:YES];
    }
}
@end
