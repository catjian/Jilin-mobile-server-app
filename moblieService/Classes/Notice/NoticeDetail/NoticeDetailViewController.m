//
//  NoticeDetailViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NoticeDetailViewController.h"

@interface NoticeDetailViewController ()

@end

@implementation NoticeDetailViewController
{
    NoticeDetailTableView *m_BaseView;
    NoticeDetailDataModel *m_DateModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"公告详情"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[NoticeDetailTableView alloc] initWithFrame:self.view.bounds
                                                            style:UITableViewStylePlain];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setDownloadBlock:^{
            DIF_StrongSelf
            [CommonHUD showHUDWithMessage:@"正在获取公告附件下载路径"];
            [DIF_CommonHttpAdapter
             httpRequestDownloadFileByMobileWithParameters:@{@"attid":strongSelf->m_DateModel.notifyId,
                                                             @"filename":strongSelf->m_DateModel.attach}
             ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                 if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
                 {
                     [CommonHUD hideHUD];
                     if ([responseModel isKindOfClass:[NSString class]] && [responseModel length] > 0)
                     {
                     }
                 }
                 else
                 {
                     [CommonHUD delayShowHUDWithMessage:(NSString*)responseModel];
                 }
             }
             FailedBlcok:^(NSError *error) {
                 [CommonHUD delayShowHUDWithMessage:DIF_HTTP_REQUEST_URL_NULL];
            }];
        }];
    }
    [self httpRequestgetAfficheMessagesByMobile];
}

- (void)setDataModel:(NoticeDataModel *)dataModel
{
    if (!dataModel)
    {
        return;
    }
    _dataModel = dataModel;
}

#pragma mark - http request
- (void)httpRequestgetAfficheMessagesByMobile
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestAfficheInfoByMobileWithParameters:@{@"notifyId":self.dataModel.notifyId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             if ([responseModel isKindOfClass:[NSArray class]] && [responseModel count] > 0)
             {
                 strongSelf->m_DateModel = [NoticeDetailDataModel mj_objectWithKeyValues:responseModel[0]];
                 strongSelf->m_BaseView.dateModel = strongSelf->m_DateModel;
                 [strongSelf->m_BaseView performSelectorOnMainThread:@selector(reloadData)
                                                          withObject:nil waitUntilDone:NO];
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
