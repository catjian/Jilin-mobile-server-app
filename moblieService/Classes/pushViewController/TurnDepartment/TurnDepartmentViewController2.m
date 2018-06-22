//
//  TurnDepartmentViewController2.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "TurnDepartmentViewController2.h"
#import "WareaJsonMobileModel.h"

@interface TurnDepartmentViewController2 ()

@property (weak, nonatomic) IBOutlet UITextField *caseTF;
@property (weak, nonatomic) IBOutlet UIButton *wareaBtn;

@end

@implementation TurnDepartmentViewController2
{
    NSMutableDictionary *m_SreenDic;
    NSArray<WareaJsonMobileModel *> *m_ListArr;
    WareaJsonMobileModel *m_SelectModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavTarBarTitle:@"转派部门"];
    [self setLeftItemWithContentName:@"取消"];
    UIButton *rightBtn = [self setRightItemWithContentName:@"确定"];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
    m_SreenDic = [NSMutableDictionary dictionary];
    [self httpRequestWareaListEvent];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self httpRequestModPassByMobile];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)spaceButtonEvent:(id)sender
{
    SelectListViewController *vc = [self loadViewController:@"SelectListViewController" hidesBottomBarWhenPushed:YES];
    [vc setNavTarBarTitle:@"选择转派工区"];
    __block NSMutableArray *listArr = [NSMutableArray array];
    for (WareaJsonMobileModel *dic in m_ListArr)
    {
        [listArr addObject:dic.name];
    }
    vc.selectDataArray = listArr;
    DIF_WeakSelf(self)
    [vc setSelectBlock:^(NSIndexPath *select, BOOL isBack) {
        DIF_StrongSelf
        if (select.section == 0)
        {            
            [strongSelf.wareaBtn setTitle:@"请选择 >" forState:UIControlStateNormal];
        }
        else
        {
            [strongSelf.wareaBtn setTitle:[listArr[select.row] stringByAppendingString:@" >"]
                                 forState:UIControlStateNormal];
            strongSelf->m_SelectModel = strongSelf->m_ListArr[select.row];
        }
    }];
}

#pragma mark - Http Request

- (void)httpRequestModPassByMobile
{
    if (self.caseTF.text.length <= 0)
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"请输入转派原因" ButtonTitle:nil];
        return;
    }
    [CommonHUD showHUDWithMessage:@"处理返单中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestModPassByMobileWithParameters:@{@"wa.wassignId":self.dataModel.wassignId?self.dataModel.wassignId:@"",
                                                @"wa.transReason":self.caseTF.text,
                                                @"wareaId":m_SelectModel.wareaId?m_SelectModel.wareaId:@""}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             if (responseModel)
             {
                 [CommonHUD delayShowHUDWithMessage:@"转派部门成功"];
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
                 [CommonHUD delayShowHUDWithMessage:@"转派部门失败"];
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

- (void)httpRequestWareaListEvent
{
    [CommonHUD showHUDWithMessage:@"获取转派部门信息列表"];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestGetWareaJsonByMobileWithParameters:nil
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             strongSelf->m_ListArr = [WareaJsonMobileModel mj_objectArrayWithKeyValuesArray:responseModel];
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
