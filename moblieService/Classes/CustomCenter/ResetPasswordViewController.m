//
//  ResetPasswordViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;
@property (weak, nonatomic) IBOutlet UITextField *setPwd;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavTarBarTitle:@"修改密码"];
    [self setLeftItemWithContentName:@"取消"];
    UIButton *rightBtn = [self setRightItemWithContentName:@"确定"];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    if (![CommonVerify verifyPasswod:self.oldPwd.text] ||
        ![CommonVerify verifyPasswod:self.setPwd.text] ||
        ![CommonVerify verifyPasswod:self.confirmPwd.text])
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil
                                              Message:@"密码必须至少6个字符，且必须是数字。"
                                          ButtonTitle:nil];
        return;
    }
    if (![CommonVerify stringIsRangingString:self.setPwd.text :self.confirmPwd.text])
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil
                                              Message:@"新密码2次输入不一致，请重新填写。"
                                          ButtonTitle:nil];
        return;
    }
    [self.view endEditing:YES];
    [self httpRequestModPassByMobile];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - http request event

- (void)httpRequestModPassByMobile
{
    [CommonHUD showHUDWithMessage:@"修改密码中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestModPassByMobileWithParameters:@{@"oldPass":self.oldPwd.text,
                                                @"newPass":self.setPwd.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             if (responseModel)
             {
                 [CommonHUD delayShowHUDWithMessage:@"修改密码成功"];
                 DIF_StrongSelf
                 [strongSelf.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [CommonHUD delayShowHUDWithMessage:@"修改密码失败"];
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
