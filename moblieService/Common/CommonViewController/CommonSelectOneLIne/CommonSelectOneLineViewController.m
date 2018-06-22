//
//  CommonSelectOneLineViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CommonSelectOneLineViewController.h"
#import "CommonSelectOneLineView.h"

@interface CommonSelectOneLineViewController ()

@end

@implementation CommonSelectOneLineViewController
{
    CommonSelectOneLineView *m_BaseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DIF_HideTabBarAnimation(YES)
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[CommonSelectOneLineView alloc] initWithFrame:self.view.bounds
                                                            style:UITableViewStylePlain];
        [self.view addSubview:m_BaseView];
    }
}

@end
