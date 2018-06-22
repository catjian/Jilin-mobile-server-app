//
//  ScreenViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ScreenViewController.h"

@interface ScreenViewController ()

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *gridBtn;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;


@end

@implementation ScreenViewController
{
    NSMutableDictionary *m_SreenDic;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"筛选条件"];
    [self setLeftItemWithContentName:@"取消"];
    UIButton *rightBtn = [self setRightItemWithContentName:@"查询"];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
    m_SreenDic = [NSMutableDictionary dictionary];
}

- (void)leftBarButtonItemAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    if (self.addressTF.text.length > 0)
    {
        [m_SreenDic setObject:self.addressTF.text forKey:@"wa.custAddr"];
    }
    if (self.phoneTF.text.length > 0)
    {
        [m_SreenDic setObject:self.phoneTF.text forKey:@"wa.conTel"];
    }
    if (self.block)
    {
        self.block(m_SreenDic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)screenButtoEvent:(UIButton *)sender
{
    __block NSArray *pickerDatas;
    __block UIButton *eventBtn = sender;
    NSString *pickerTitle = @"";
    __block NSArray *keyTitle = @[@"工单状态",@"受理类型",@"处理网格"];
    switch (sender.tag)
    {
        case 1001:
            pickerTitle = keyTitle[0];
            pickerDatas = @[@"请选择",@"新工单",@"已接工单",@"已完成工单"];
            break;
        case 1002:
            pickerTitle = keyTitle[1];
            pickerDatas = @[@"请选择",@"数字电视",@"宽带",@"VOD 点播",@"增值业务"];
            break;
        case 1003:
            pickerTitle = keyTitle[2];
            pickerDatas = @[DIF_CommonCurrentUser.wareaName];
            break;
        default:
            break;
    }
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(190)];
    CommonPickerView *pickerView = [[CommonPickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    [pickerView setPickerDatas:pickerDatas];
    [pickerView setTitleStr:pickerTitle];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    DIF_WeakSelf(self)
    [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
        DIF_StrongSelf
        [popPickerView hidePopView];
        if (![x isKindOfClass:[NSDictionary class]])
        {
            return ;
        }
        NSDictionary *nextDic = x;
        if ([nextDic.allKeys indexOfObject:@"SuccessButtonEvent"] != NSNotFound)
        {
            NSDictionary *content = nextDic[@"SuccessButtonEvent"];
            NSString *key = content.allKeys.firstObject;
            if ([content[key] isEqualToString:@"请选择"])
            {
                [strongSelf->m_SreenDic removeObjectForKey:key];
                [eventBtn setTitle:@"请选择 >"
                          forState:UIControlStateNormal];
            }
            else if ([keyTitle indexOfObject:key] < 2)
            {
                NSArray *realKey = @[@"wa.state",@"wa.accNbrType"];
                NSArray *stateArr = @[@"A",@"B",@"Z"];
                NSArray *accNbrType = @[@"SMS",@"CM",@"VOD",@"ITV"];
                NSInteger index = [pickerDatas indexOfObject:content[key]]-1;
                NSString *val = [keyTitle indexOfObject:key] == 0?stateArr[index]:accNbrType[index];
                [strongSelf->m_SreenDic setObject:val
                                           forKey:realKey[[keyTitle indexOfObject:key]]];
                [eventBtn setTitle:[pickerDatas[index+1] stringByAppendingString:@" >"]
                          forState:UIControlStateNormal];
            }
            else if ([keyTitle indexOfObject:key] >= 2)
            {
                [eventBtn setTitle:[pickerDatas[0] stringByAppendingString:@" >"]
                          forState:UIControlStateNormal];
            }
        }
    }];
}

@end
