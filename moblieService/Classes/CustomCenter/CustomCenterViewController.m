//
//  CustomCenterViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CustomCenterViewController.h"

@interface CustomCenterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *wareaName;
@property (weak, nonatomic) IBOutlet UILabel *staffIdLab;

@end

@implementation CustomCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.nameLab setText:DIF_CommonCurrentUser.userName];
    [self.wareaName setText:DIF_CommonCurrentUser.wareaName];
    [self.staffIdLab setText:DIF_CommonCurrentUser.staffId];
    
    [self setNavTarBarTitle:@"个人"];
}

- (IBAction)resetPwdButtonEvent:(id)sender
{
    [self loadViewController:@"ResetPasswordViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)logoutButtonEvent:(id)sender
{
    UIAlertController *alerCon = [UIAlertController alertControllerWithTitle:nil
                                                                     message:@"退出后，下次登录可继续使用本账号"
                                                              preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logoutAction =
    [UIAlertAction actionWithTitle:@"退出登录"
                             style:UIAlertActionStyleDestructive
                           handler:^(UIAlertAction * _Nonnull action) {
                               [DIF_CommonCurrentUser setAutoLogin:[@(NO) stringValue]];
                               [DIF_APPDELEGATE loadLoginViewController];
                               [DIF_CommonHttpAdapter httpRequestPostLogoutWithParameters:@{@"staff.wcode":DIF_CommonCurrentUser.staffId} ResponseBlock:nil FailedBlcok:nil];
                           }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alerCon addAction:logoutAction];
    [alerCon addAction:cancelAction];
    [DIF_TabBar presentViewController:alerCon animated:YES completion:nil];
    
}

@end
