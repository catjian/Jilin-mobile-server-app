//
//  NoticeViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/5/30.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeDetailViewController.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController
{
    NoticeTableView *m_BaseView;
    NoticeDataModel *m_DateModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.showback)
    {
        UIButton *leftBtn = [self setLeftItemWithContentName:@"公告 "];
        [leftBtn.titleLabel setFont:DIF_DIFONTOFSIZE(is_iPhone5AndEarly?24:28)];
        [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [leftBtn setTitleColor:DIF_HEXCOLOR(@"#25313F") forState:UIControlStateNormal];
        [self setNavTarBarTitle:@""];
        [self setRightItemsWithContentNames:@[@"设置",@"个人"]];
        DIF_ShowTabBarAnimation(YES);
    }
    else
    {
        [self setLeftItemWithContentName:@"" imageName:@"ic_back"];
        [self setNavTarBarTitle:@"公告"];
        DIF_HideTabBarAnimation(NO);    
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.showback = NO;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showback = NO;
    m_DateModel = [NoticeDataModel new];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[NoticeTableView alloc] initWithFrame:self.view.bounds
                                                       style:UITableViewStylePlain];
        m_BaseView.dateModel = m_DateModel;
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            NoticeDetailViewController *vc = [strongSelf loadViewController:@"NoticeDetailViewController" hidesBottomBarWhenPushed:YES];
            vc.dataModel = strongSelf->m_BaseView.noticeDataArray[indexPath.row];
        }];
        [m_BaseView setRefreshBlock:^{
            DIF_StrongSelf
            [strongSelf httpRequestgetAfficheMessagesByMobile];
        }];
    }
}

- (void)leftBarButtonItemAction:(UIButton *)btn
{
    if (self.showback)
    {        
        [DIF_TabBar setSelectedIndex:3];
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

#pragma mark - http request
- (void)httpRequestgetAfficheMessagesByMobile
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestgetAfficheMessagesByMobileWithParameters:nil
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             if ([responseModel isKindOfClass:[NSArray class]] && [responseModel count] > 0)
             {
                 [strongSelf->m_BaseView setNoticeDataArray:[NoticeDataModel mj_objectArrayWithKeyValuesArray:responseModel]];
             }
             else
             {
                 [strongSelf->m_BaseView setNoticeDataArray:@[]];
             }
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:(NSString*)responseModel];
         }
     }
     FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         [CommonHUD delayShowHUDWithMessage:DIF_HTTP_REQUEST_URL_NULL];
     }];
}

@end
