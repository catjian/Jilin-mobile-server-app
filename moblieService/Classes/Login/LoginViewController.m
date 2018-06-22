//
//  LoginViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UIView *pwdBottomLine;
@property (weak, nonatomic) IBOutlet UILabel *pwdErrorLab;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    if (DIF_CommonCurrentUser.phone.length > 0 &&
        DIF_CommonCurrentUser.password.length > 0 &&
        DIF_CommonCurrentUser.autoLogin.boolValue)
    {
        [self.phoneTextField setText:DIF_CommonCurrentUser.phone];
        [self.pwdTextField setText:DIF_CommonCurrentUser.password];
        [self performSelector:@selector(loginButtonEvent:) withObject:nil afterDelay:.5];
    }
}

- (IBAction)loginButtonEvent:(id)sender
{
    if (self.phoneTextField.text.length <= 0)
    {
        return;
    }
    [self.pwdErrorLab setHidden:YES];
    [self.pwdBottomLine setBackgroundColor:DIF_HEXCOLOR(@"#E5E5E5")];
    if (self.pwdTextField.text.length < 6)
    {
        [self.pwdErrorLab setHidden:NO];
        [self.pwdBottomLine setBackgroundColor:DIF_HEXCOLOR(@"FF3B30")];
        return;
    }
    [self.view endEditing:YES];
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestLoginWithParameters:@{@"staff.wcode":self.phoneTextField.text,
                                      @"staff.password":self.pwdTextField.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             [DIF_CommonCurrentUser setPhone:strongSelf.phoneTextField.text];
             [DIF_CommonCurrentUser setPassword:strongSelf.pwdTextField.text];
             
             [DIF_CommonCurrentUser setStaffId:responseModel[@"staffId"]];
             [DIF_CommonCurrentUser setWareaId:responseModel[@"wareaId"]];
             [DIF_CommonCurrentUser setUserName:responseModel[@"name"]];
             [DIF_CommonCurrentUser setWareaName:responseModel[@"wareaName"]];
             [DIF_CommonCurrentUser setAutoLogin:[@(YES) stringValue]];
             
             [strongSelf dismissViewControllerAnimated:YES completion:^{
                 [DIF_APPDELEGATE performSelector:@selector(getHaveNewGridEventByTimer)
                                       withObject:nil
                                       afterDelay:1];
             }];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:(NSString*)responseModel];
         }
     }
     FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_HTTP_REQUEST_URL_NULL];
     } ];
}

- (IBAction)settingButtonEvent:(id)sender
{    
    [self loadViewController:@"ConfigServiceHostViewController" hidesBottomBarWhenPushed:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!string || string.isNull)
    {
        return YES;
    }
    if ([textField isEqual:self.phoneTextField] && textField.text.length + string.length > 11)
    {
        return NO;
    }
    if ([textField isEqual:self.pwdTextField] && textField.text.length + string.length > 16)
    {
        return NO;
    }
    return YES;
}

@end
