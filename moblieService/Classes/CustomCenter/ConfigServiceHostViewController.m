//
//  ConfigServiceHostViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ConfigServiceHostViewController.h"

@interface ConfigServiceHostViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ipTF;
@property (weak, nonatomic) IBOutlet UITextField *portTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *numTF;

@end

@implementation ConfigServiceHostViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.    
    [self setNavTarBarTitle:@"设置"];
    UIButton *rightBtn = [self setRightItemWithContentName:@"确定"];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    if (self.numTF.text.integerValue > 0)
    {
        [DIF_CommonCurrentUser setPageSize:self.numTF.text];
    }
//    if (![CommonVerify isIPHost:self.ipTF.text])
//    {
//        return;
//    }
//    if (self.portTF.text.integerValue <= 0 || self.portTF.text.integerValue >65535)
//    {
//        return;
//    }
    [DIF_CommonCurrentUser setServiceHost:self.ipTF.text];
    [DIF_CommonCurrentUser setServicePort:self.portTF.text];
    [DIF_CommonCurrentUser setServiceName:self.nameTF.text];
    [DIF_CommonHttpAdapter setBaseUrl];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
