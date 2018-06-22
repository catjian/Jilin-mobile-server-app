//
//  ApplyViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ApplyViewController.h"

@interface ApplyViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *applyNameLab;
@property (weak, nonatomic) IBOutlet UIButton *applyTimeBtn;
@property (weak, nonatomic) IBOutlet UITextField *applyTimeTF;
@property (weak, nonatomic) IBOutlet UITextView *applyReasonTV;

@end

@implementation ApplyViewController
{    
    NSMutableDictionary *m_SreenDic;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavTarBarTitle:@"申请"];
    [self setLeftItemWithContentName:@"取消"];
    UIButton *rightBtn = [self setRightItemWithContentName:@"确定"];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
    m_SreenDic = [NSMutableDictionary dictionary];
    [m_SreenDic setObject:@"A" forKey:@"wa.applyType"];
    [m_SreenDic setObject:@"H" forKey:@"wa.applyType"];
    [self.applyReasonTV setDelegate:self];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    if (self.applyReasonTV.text.length <= 0 ||
        [self.applyReasonTV.text isEqualToString:@"请输入内容"])
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"请输入申请原因" ButtonTitle:nil];
        return;
    }
    if ([CommonVerify isContainsEmoji:self.applyReasonTV.text])
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"申请原因中不能包含表情" ButtonTitle:nil];
        return;
    }
    if (self.applyTimeTF.text.length <= 0)
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"请输入申请时间" ButtonTitle:nil];
        return;
    }
    [m_SreenDic setObject:DIF_CommonCurrentUser.staffId forKey:@"wa.operStaffId"];
    [m_SreenDic setObject:self.dataModel.wassignId?self.dataModel.wassignId:@"" forKey:@"wa.wassignId"];
    [m_SreenDic setObject:self.applyTimeTF.text forKey:@"wa.delay"];
    [m_SreenDic setObject:[self.applyReasonTV.text stringEncodeGBK] forKey:@"wa.applyReason"];
    [self httpRequrestSubmitServiceResultForGrid];
}

- (IBAction)delayButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(190)];
    NSArray *pickerDatas = @[@"延时"];
    CommonPickerView *pickerView = [[CommonPickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    [pickerView setPickerDatas:pickerDatas];
    [pickerView setTitleStr:@"申请类型"];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
        [popPickerView hidePopView];
        
    }];
}

- (IBAction)ApplyTimeButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(190)];
    NSArray *pickerDatas = @[@"小时",@"天"];
    CommonPickerView *pickerView = [[CommonPickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    [pickerView setPickerDatas:pickerDatas];
    [pickerView setTitleStr:@"申请时间"];
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
            NSArray *stateArr = @[@"H",@"D"];
            [strongSelf->m_SreenDic setObject:[stateArr objectAtIndex:[pickerDatas indexOfObject:content[key]]]
                                       forKey:@"wa.delayUnit"];
            [strongSelf.applyTimeBtn setTitle:[content[key] stringByAppendingString:@" >"]
                                     forState:UIControlStateNormal];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入内容"])
    {
        textView.text = @"";
        [textView setTextColor:DIF_HEXCOLOR(@"000000")];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        [textView setTextColor:DIF_HEXCOLOR(@"999999")];
        [textView setText:@"请输入内容"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] &&
        (textView.text.length<=1 || [textView.text isEqualToString:@"请输入内容"]))
    {
        textView.text = @"请输入内容";
        [textView setTextColor:DIF_HEXCOLOR(@"999999")];
        return NO;
    }
    else if ([textView.text isEqualToString:@"请输入内容"])
    {
        textView.text = @"";
        [textView setTextColor:DIF_HEXCOLOR(@"000000")];
    }
    return YES;
}

#pragma mark - Http request event

- (void)httpRequrestSubmitServiceResultForGrid
{
    [CommonHUD showHUDWithMessage:@"工单申请延时中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestSubmitRfDelayWithParameters:m_SreenDic
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             if (responseModel)
             {
                 [CommonHUD delayShowHUDWithMessage:@"工单申请延时成功"];
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
                 [CommonHUD delayShowHUDWithMessage:@"工单申请延时失败"];
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
