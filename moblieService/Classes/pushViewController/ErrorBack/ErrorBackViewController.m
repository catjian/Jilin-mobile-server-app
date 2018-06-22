//
//  ErrorBackViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ErrorBackViewController.h"

@interface ErrorBackViewController ()

@property (weak, nonatomic) IBOutlet UIButton *caseBtn;
@property (weak, nonatomic) IBOutlet UITextField *responseTF;
@end

@implementation ErrorBackViewController
{
    NSMutableDictionary *m_SreenDic;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"错返"];
    [self setLeftItemWithContentName:@"取消"];
    UIButton *rightBtn = [self setRightItemWithContentName:@"确定"];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
    m_SreenDic = [NSMutableDictionary dictionary];
}

- (IBAction)ErrorCaseButtonEvent:(id)sender
{
    SelectListViewController *vc = [self loadViewController:@"SelectListViewController" hidesBottomBarWhenPushed:YES];
    [vc setNavTarBarTitle:@"选择转派工区"];
    NSArray *listArr = @[@"信息不全",@"未上门已解决",@"大故障",@"非本站",@"非本网",@"特殊原因(详细说明)"];
    vc.selectDataArray = listArr;
    DIF_WeakSelf(self)
    [vc setSelectBlock:^(NSIndexPath *select, BOOL isBack) {
        DIF_StrongSelf
        if (select.section == 0)
        {
            [strongSelf.caseBtn setTitle:@"请选择 >" forState:UIControlStateNormal];
        }
        else
        {
            [strongSelf.caseBtn setTitle:[listArr[select.row] stringByAppendingString:@" >"]
                                forState:UIControlStateNormal];
            [strongSelf->m_SreenDic setObject:[NSString stringWithFormat:@"%c",(char)(65+select.row)]
                                       forKey:@"wa.standby2"];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    if (self.responseTF.text.length <= 0)
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"请输入处理结果" ButtonTitle:nil];
        return;
    }
    if ([m_SreenDic.allKeys indexOfObject:@"wa.standby2"] == NSNotFound)
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"请选择错返原因" ButtonTitle:nil];
        return;
    }
    [self.view endEditing:YES];
    [m_SreenDic setObject:DIF_CommonCurrentUser.staffId forKey:@"wa.operStaffId"];
    [m_SreenDic setObject:self.dataModel.wassignId forKey:@"wa.wassignId"];
    [m_SreenDic setObject:@"X" forKey:@"wa.state"];
    [m_SreenDic setObject:[self.responseTF.text stringEncodeGBK] forKey:@"wa.result"];
    [self httpRequrestSubmitServiceResultForGrid];
}

#pragma mark - http request event

- (void)httpRequrestSubmitServiceResultForGrid
{
    [CommonHUD showHUDWithMessage:@"请求工单错返中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestSubmitServiceResultForGridWithParameters:m_SreenDic
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             if (responseModel)
             {
                 [CommonHUD delayShowHUDWithMessage:@"工单错返执行成功"];
                 DIF_StrongSelf
                 UIViewController *toCon = nil;
                 for (toCon in strongSelf.navigationController.viewControllers)
                 {
                     if ([toCon isKindOfClass:[HadJobGridViewController class]] || [toCon isKindOfClass:[NewJobGridViewController class]])
                     {
                         break;
                     }
                 }
                 if (toCon)
                 {
                     [strongSelf.navigationController popToViewController:toCon animated:YES];
                 }
                 else
                 {
                     [strongSelf.navigationController popViewControllerAnimated:YES];
                 }
             }
             else
             {
                 [CommonHUD delayShowHUDWithMessage:@"工单错返执行失败"];
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
