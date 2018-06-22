//
//  AcceptViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "AcceptViewController.h"

@interface AcceptViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *centerLine;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (nonatomic, strong) NSArray *pickerDatas;

@end

@implementation AcceptViewController
{
    NSMutableDictionary *m_SreenDic;
    UIPickerView *m_PickerView;
    NSMutableArray *m_CalendarArr;
    NSInteger m_SelectRow, m_SelectComponent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pickerDatas = @[@"上午", @"下午"];
    [self setNavTarBarTitle:@"接收"];
    [self setLeftItemWithContentName:@"取消"];
    UIButton *rightBtn = [self setRightItemWithContentName:@"确定"];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
    m_SreenDic = [NSMutableDictionary dictionary];
    
    int year = [CommonDate getNowDateWithFormate:@"yyyy"].intValue;
    int month = [CommonDate getNowDateWithFormate:@"MM"].intValue;
    int day = [CommonDate getNowDateWithFormate:@"dd"].intValue;
    int calenderBegin = year*100+month;
    int calenderEnd = (year+2)*100+12;
    m_CalendarArr = [NSMutableArray array];
    while (calenderBegin <= calenderEnd)
    {
        NSString *calendarStr = [@(calenderBegin) stringValue];
        NSDate *calendarDate = [CommonDate dateStringToDate:calendarStr Formate:@"yyyyMM"];
        NSInteger monthDays = [CommonDate totaldaysInThisMonth:calendarDate];
        while (day < monthDays+1)
        {
            int nowDay = calenderBegin*100+day;
            NSString *nowDayStr = [@(nowDay) stringValue];
            NSDate *nowDayDate = [CommonDate dateStringToDate:nowDayStr Formate:@"yyyyMMdd"];
            [m_CalendarArr addObject:[CommonDate dateToString:nowDayDate Formate:@"yyyy年MM月dd日"]];
            day++;
        }
        day = 1;
        month++;
        if (month >= 13)
        {
            month = 1;
            year ++;
        }
        calenderBegin = year*100+month;
    }
    
    m_PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,self.centerLine.bottom, self.backView.width, self.backView.height-self.centerLine.bottom)];
    [m_PickerView setDelegate:self];
    [m_PickerView setDataSource:self];
    [self.backView addSubview:m_PickerView];
    NSString *today = [CommonDate getNowDateWithFormate:@"yyyy年MM月dd日"];
    [self.dateLab setText:[today stringByAppendingFormat:@" %@",self.pickerDatas[0]]];
    m_SelectRow = [m_CalendarArr indexOfObject:today];
    m_SelectComponent = 0;
    [m_PickerView selectRow:m_SelectRow inComponent:0 animated:NO];
    DIF_WeakSelf(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DIF_StrongSelf
        [strongSelf->m_PickerView reloadComponent:1];
        [strongSelf->m_PickerView selectRow:0 inComponent:1 animated:NO];
    });
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    NSArray *dateArr = [self.dateLab.text componentsSeparatedByString:@" "];
    
    [m_SreenDic setObject:DIF_CommonCurrentUser.staffId forKey:@"wa.operStaffId"];
    [m_SreenDic setObject:self.dataModel.wassignId forKey:@"wa.wassignId"];
    [m_SreenDic setObject:[CommonDate dateToString:[CommonDate dateStringToDate:dateArr.firstObject
                                                                        Formate:@"yyyy年MM月dd日"]
                                           Formate:@"yyyy-MM-dd"]
                   forKey:@"wa.standby10"];
    [m_SreenDic setObject:[dateArr.lastObject isEqualToString:@"上午"]?@"A":@"B"
                   forKey:@"wa.standby9"];
    [m_SreenDic setObject:@"B"
                   forKey:@"wa.state"];
    [self httpRequrestSubmitServiceResultForGrid];
}

#pragma mark - UIPickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return component==0?m_CalendarArr.count:self.pickerDatas.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return DIF_PX(35);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return component==0?m_CalendarArr[row]:self.pickerDatas[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = DIF_HEXCOLOR(DIF_CELL_SEPARATOR_COLOR);
        }
    }
    UILabel *contentLab = (UILabel*)view;
    if (!contentLab)
    {
        contentLab = [[UILabel alloc] init];
        [contentLab setTextAlignment:NSTextAlignmentCenter];
        NSString *today = [CommonDate getNowDateWithFormate:@"yyyy年MM月dd日"];
        [contentLab setText:component==0?m_CalendarArr[row]:self.pickerDatas[row]];
        if (component == 0 && [m_CalendarArr[row] isEqualToString:today])
        {
            [contentLab setText:@"今天"];
        }
    }
    [contentLab setTextColor:DIF_HEXCOLOR(((m_SelectComponent == component && m_SelectRow == row)?@"4DA9EA":@"A3A3A3"))];
    [contentLab setFont:DIF_DIFONTOFSIZE(((m_SelectComponent == component && m_SelectRow == row)?18:15))];
    return contentLab;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    m_SelectRow = row;
    m_SelectComponent = component;
    [pickerView reloadComponent:component];
    [pickerView selectRow:row inComponent:component animated:NO];
    NSString *dateStr = self.dateLab.text;
    NSRange range = [dateStr rangeOfString:@" "];
    if (component == 0)
    {
        dateStr = [m_CalendarArr[row] stringByAppendingFormat:@" %@",[dateStr substringFromIndex:range.location+1]];
    }
    else
    {
        dateStr = [[dateStr substringToIndex:range.location] stringByAppendingFormat:@" %@",self.pickerDatas[row]];
    }
    [self.dateLab setText:dateStr];
}

#pragma mark - http request event

- (void)httpRequrestSubmitServiceResultForGrid
{
    [CommonHUD showHUDWithMessage:@"请求接收工单中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestSubmitServiceResultForGridWithParameters:m_SreenDic
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             if (responseModel)
             {
                 [CommonHUD delayShowHUDWithMessage:@"接单执行工单成功"];
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
                 [CommonHUD delayShowHUDWithMessage:@"接单执行工单失败"];
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
