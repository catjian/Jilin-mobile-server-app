//
//  JobGridDetailViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "JobGridDetailViewController.h"
#import "GridTailViewController.h"
#import "AcceptViewController.h"
#import "AcceptBackViewController.h"
#import "ErrorBackViewController.h"
#import "TurnDepartmentViewController2.h"
#import "ApplyViewController.h"

@interface JobGridDetailViewController ()

@end

@implementation JobGridDetailViewController
{
    JobGridDetailTableView *m_BaseView;
    NSArray *m_ReceiveRf;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"工单详情"];
    UIButton *rightBtn = [self setRightItemWithContentName:@"工单轨迹"];
    [rightBtn.titleLabel setFont:DIF_DIFONTOFSIZE(14)];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
    [self httpRequestReceiveRfEvent];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[JobGridDetailTableView alloc] initWithFrame:self.view.bounds
                                                             style:UITableViewStylePlain];
        m_BaseView.dateModel = self.dataModel;
        [self.view addSubview:m_BaseView];
        
        DIF_WeakSelf(self)
        [m_BaseView setDisposeBlock:^(ENUM_Detail_Dispose dispose) {
            DIF_StrongSelf
            switch (dispose) {
                case ENUM_Detail_Dispose_Accept:
                {
                    AcceptViewController *vc = [strongSelf loadViewController:@"AcceptViewController"
                          hidesBottomBarWhenPushed:YES];
                    vc.dataModel = strongSelf.dataModel;
                }
                    break;
                case ENUM_Detail_Dispose_Accept_Back:
                {
                    AcceptBackViewController *vc = [strongSelf loadViewController:@"AcceptBackViewController"
                                                         hidesBottomBarWhenPushed:YES];
                    vc.dataModel = strongSelf.dataModel;
                    vc.execStaffArr = strongSelf->m_ReceiveRf[2];
                    vc.reasonArr = strongSelf->m_ReceiveRf[4];
                }
                    break;
                case ENUM_Detail_Dispose_ErrorBack:
                {
                    ErrorBackViewController *vc = [strongSelf loadViewController:@"ErrorBackViewController"
                          hidesBottomBarWhenPushed:YES];
                    vc.dataModel = strongSelf.dataModel;
                }
                    break;
                case ENUM_Detail_Dispose_TurnDepartment:
                {
                    TurnDepartmentViewController2 *vc = [strongSelf loadViewController:@"TurnDepartmentViewController2"
                                                              hidesBottomBarWhenPushed:YES];
                    vc.dataModel = strongSelf.dataModel;
                }
                    break;
                case ENUM_Detail_Dispose_Apply:
                {
                    ApplyViewController *vc = [strongSelf loadViewController:@"ApplyViewController"
                                                    hidesBottomBarWhenPushed:YES];
                    vc.dataModel = strongSelf.dataModel;
                }
                    break;
                default:
                    break;
            }
        }];
    }
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    GridTailViewController *vc = [self loadViewController:@"GridTailViewController" hidesBottomBarWhenPushed:YES];
    vc.gridTailArr = m_ReceiveRf[7];
}

#pragma mark - Http request

- (void)httpRequestReceiveRfEvent
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestReceiveRfWithParameters:@{@"wa.wassignId":self.dataModel.wassignId,
                                          @"wa.operStaffId":DIF_CommonCurrentUser.staffId,
                                          @"from":@"A"}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             if ([responseModel isKindOfClass:[NSString class]])
             {
                 NSArray *responseArr = [responseModel componentsSeparatedByString:@"@@@"];
                 NSMutableArray *jsonArr = [NSMutableArray array];
                 for (NSString *response in responseArr)
                 {
                     NSDictionary *responseDic = [CommonTool dictionaryWithJsonString:response];
                     [jsonArr addObject:responseDic];
                 }
                 DIF_StrongSelf
                 strongSelf->m_ReceiveRf = jsonArr;
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
}

@end
