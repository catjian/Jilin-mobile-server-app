//
//  AcceptBackViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "AcceptBackViewController.h"
#import "AddExecStaffViewController.h"
#import "JobGridReasonModel.h"

@interface AcceptBackViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *execstaffName1;
@property (weak, nonatomic) IBOutlet UILabel *execstaffName2;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *reasonBtn;
@property (weak, nonatomic) IBOutlet UIButton *standby12Btn;

@end

@implementation AcceptBackViewController
{
    NSArray *m_NowReasonArr;
    NSString *m_WareaId;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    m_WareaId = nil;
    [self setNavTarBarTitle:@"处理返单"];
    [self setLeftItemWithContentName:@"取消"];
    UIButton *rightBtn = [self setRightItemWithContentName:@"确定"];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    NSString *text = self.execstaffName1.text;
    if (!m_WareaId)
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"请选择工单原因" ButtonTitle:nil];
        return;
    }
    if (text.length > [@"预约处理人：" length])
    {
        NSString *name = [text substringFromIndex:[text rangeOfString:@"预约处理人："].length];
        [self httpRequestAddExecStaffByMobileWithName:name];
    }
}

- (IBAction)addExecstaffButtonEvent:(id)sender
{
    [self.datePicker setHidden:YES];
    if (!self.execstaffName2.hidden)
    {
        return;
    }
    __block NSMutableArray *nameArr = [NSMutableArray array];
    [self.execStaffArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [nameArr addObject:obj[@"name"]];
    }];
    AddExecStaffViewController *vc = [self loadViewController:@"AddExecStaffViewController" hidesBottomBarWhenPushed:YES];
    vc.dataArray = nameArr;
    DIF_WeakSelf(self)
    [vc setSelectBlock:^(NSIndexPath *index) {
        DIF_StrongSelf
        if (index)
        {
            NSString *text = self.execstaffName1.text;
            if (text.length <= [@"预约处理人：" length])
            {
                [strongSelf.execstaffName1 setText:[text stringByAppendingString:nameArr[index.row]]];
            }
            else if (nameArr.count > 1 && [text rangeOfString:nameArr[index.row]].location == NSNotFound)
            {
                text = self.execstaffName2.text;
                if (text.length <= [@"预约处理人：" length])
                {
                    [strongSelf.execstaffName2 setHidden:NO];
                    [strongSelf.execstaffName2 setText:[text stringByAppendingString:nameArr[index.row]]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [strongSelf.contentView setTop:strongSelf.execstaffName2.bottom+5];
                        [strongSelf.datePicker setTop:strongSelf.contentView.bottom];
                    });
                }
            }
        }
    }];
}

- (IBAction)selectReasonButtonEvent:(id)sender
{
    m_WareaId = nil;
    SelectListViewController *vc = [self loadViewController:@"SelectListViewController" hidesBottomBarWhenPushed:YES];
    [vc setNavTarBarTitle:@"选择一级工单原因"];
    __block NSMutableArray *listArr = [NSMutableArray array];
    for (JobGridReasonModel *obj in self.reasonArr)
    {
        [listArr addObject:obj.reason];
    }
    vc.selectDataArray = listArr;
    vc.isSelectCallBack = YES;
    DIF_WeakSelf(self)
    [vc setSelectBlock:^(NSIndexPath *select, BOOL isBack) {
        DIF_StrongSelf
        if (select.section == 0)
        {
            [strongSelf.reasonBtn setTitle:@"请选择 >" forState:UIControlStateNormal];
        }
        else
        {
            JobGridReasonModel *obj = strongSelf.reasonArr[select.row];
            if (isBack)
            {
                if (strongSelf->m_WareaId)
                {
                    JobGridReasonModel *fobj = strongSelf->m_NowReasonArr[strongSelf->m_WareaId.integerValue];
                    NSString *reason = strongSelf.reasonBtn.titleLabel.text;
                    reason = [obj.reason stringByAppendingFormat:@"->%@ >",fobj.reason];
                    [strongSelf.reasonBtn setTitle:reason forState:UIControlStateNormal];
                    strongSelf->m_WareaId = fobj.reaId;
                }
                else
                {
                    [strongSelf.reasonBtn setTitle:@"请选择 >" forState:UIControlStateNormal];
                }
                return;
            }
            [strongSelf httpRequestGetWaReasonOptionsListByMobileWithReaId:obj.reaId];
        }
    }];
}

- (void)jumpToFollowReasonViewContoller
{
    SelectListViewController *vc = [self loadViewController:@"SelectListViewController" hidesBottomBarWhenPushed:YES];
    [vc setNavTarBarTitle:@"选择二级工单原因"];
    __block NSMutableArray *listArr = [NSMutableArray array];
    for (JobGridReasonModel *obj in m_NowReasonArr)
    {
        [listArr addObject:obj.reason];
    }
    vc.selectDataArray = listArr;
    vc.isSelectCallBack = YES;
    DIF_WeakSelf(self)
    [vc setSelectBlock:^(NSIndexPath *select, BOOL isBack) {
        DIF_StrongSelf
        if (select.section == 0)
        {
            [strongSelf.reasonBtn setTitle:@"请选择 >" forState:UIControlStateNormal];
        }
        else
        {
            strongSelf->m_WareaId = [@(select.row) stringValue];
        }
    }];
}

- (IBAction)standby12ButtonEvent:(id)sender
{
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(190)];
    NSArray *pickerDatas = @[@"具备", @"不具备"];
    CommonPickerView *pickerView = [[CommonPickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    [pickerView setPickerDatas:pickerDatas];
    [pickerView setTitleStr:@"是否具备接通双向条件"];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    DIF_WeakSelf(self)
    [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
        [popPickerView hidePopView];
        if (![x isKindOfClass:[NSDictionary class]])
        {
            return ;
        }
        NSDictionary *nextDic = x;
        if ([nextDic.allKeys indexOfObject:@"SuccessButtonEvent"] != NSNotFound)
        {
            DIF_StrongSelf
            NSDictionary *content = nextDic[@"SuccessButtonEvent"];
            NSString *key = content.allKeys.firstObject;
            [strongSelf.standby12Btn setTitle:[content[key] stringByAppendingString:@" >"]
                                     forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)addFinishTImeButtonEvent:(id)sender
{
    [self.datePicker setHidden:NO];
    [self.dateButton setTitle:[CommonDate getNowDateWithFormate:@"yyyy年MM月dd日 HH:mm"] forState:UIControlStateNormal];
}

- (IBAction)selectDatePickerEvent:(id)sender
{
    [self.dateButton setTitle:[CommonDate dateToString:self.datePicker.date Formate:@"yyyy年MM月dd日 HH:mm"] forState:UIControlStateNormal];
}

- (void)setReasonArr:(NSArray *)reasonArr
{
    if (reasonArr.count <= 0)
    {
        return;
    }
    _reasonArr = [JobGridReasonModel mj_objectArrayWithKeyValuesArray:reasonArr];
}

#pragma mark - http request event

- (void)httpRequestAddExecStaffByMobileWithName:(NSString *)name
{
    NSString *execstaffid = @"";
    for (NSDictionary *dic in self.execStaffArr)
    {
        if ([dic[@"name"] isEqualToString:name])
        {
            execstaffid = dic[@"staffId"];
            break;
        }
    }
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestAddExecStaffByMobileWithParameters:@{@"execstaffid":[(NSNumber *)execstaffid stringValue],
                                                     @"wassignid":self.dataModel.wassignId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             DIF_StrongSelf
             NSString *text = strongSelf.execstaffName2.text;
             if (text.length > [@"预约处理人：" length])
             {
                 NSString *name = [text substringFromIndex:[text rangeOfString:@"预约处理人："].length];
                 [strongSelf httpRequestAddExecStaffByMobileWithName:name];
             }
             else
             {
                 [strongSelf httpRequestSubmitServiceResultForGrid];
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

- (void)httpRequestSubmitServiceResultForGrid
{
    NSString *result = @"";
    if (m_WareaId)
    {
        result = self.reasonBtn.titleLabel.text;
        result = [result substringToIndex:[result rangeOfString:@" >"].location];
    }
    else
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"请选择工单原因" ButtonTitle:nil];
        return;
    }
    NSString *standby12 = @"A";
    NSString *staStr = self.standby12Btn.titleLabel.text;
    if ([staStr rangeOfString:@"请选择"].location != NSNotFound)
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"请选择是否具备接通双向条件" ButtonTitle:nil];
        return;
    }
    else
    {
        staStr = [staStr substringToIndex:[staStr rangeOfString:@" >"].location];
        standby12 = [@[@"A",@"B"] objectAtIndex:[@[@"具备", @"不具备"] indexOfObject:staStr]];
    }
    
    NSString *completeDate = self.dateButton.titleLabel.text;
    if ([completeDate rangeOfString:@"年"].location == NSNotFound)
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:nil Message:@"请选择完成时间" ButtonTitle:nil];
        return;
    }
    else
    {
        completeDate = [CommonDate dateToString:[CommonDate dateStringToDate:completeDate Formate:@"yyyy年MM月dd日 HH:mm"] Formate:@"yyyy-MM-dd+HH:mm"];
        NSRange rangeA = [completeDate rangeOfString:@"+"];
        completeDate = [NSString stringWithFormat:@"%@@%@",[completeDate substringToIndex:rangeA.location], [completeDate substringFromIndex:rangeA.location+rangeA.length]];
    }
    [CommonHUD showHUDWithMessage:@"处理返单中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestSubmitServiceResultForGridWithParameters:
  @{@"wa.operStaffId":DIF_CommonCurrentUser.staffId,
    @"wa.wassignId":self.dataModel.wassignId?self.dataModel.wassignId:@"",
    @"wa.state":@"Z",//[self.dataModel.category isEqualToString:@"T"]?@"F":@"Z",
    @"wa.standby12":standby12,
    @"wa.realDealStaff":[DIF_CommonCurrentUser.userName stringEncodeGBK],
    @"wa.result":[result stringEncodeGBK],
    @"wa.reaId":m_WareaId?m_WareaId:@"",
    @"completeDate":completeDate    }
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             if (responseModel)
             {
                 [CommonHUD delayShowHUDWithMessage:@"处理返单成功"];
                 DIF_StrongSelf
                 UIViewController *toCon = nil;
                 for (toCon in strongSelf.navigationController.viewControllers)
                 {
                     if ([toCon isKindOfClass:[HadJobGridViewController class]])
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
                 [CommonHUD delayShowHUDWithMessage:@"处理返单失败"];
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

- (void)httpRequestGetWaReasonOptionsListByMobileWithReaId:(NSString *)reaId
{
    [CommonHUD showHUDWithMessage:@"获取下级工单原因"];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestGetWaReasonOptionsListByMobileWithParameters:@{@"reaid":reaId,
                                                               @"from":@"Y",
                                                               @"1":@"1"
                                                               }
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             strongSelf->m_WareaId = nil;
             if ([responseModel isKindOfClass:[NSArray class]])
             {
                 strongSelf->m_NowReasonArr = [JobGridReasonModel mj_objectArrayWithKeyValuesArray:responseModel];
                 [strongSelf jumpToFollowReasonViewContoller];
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
