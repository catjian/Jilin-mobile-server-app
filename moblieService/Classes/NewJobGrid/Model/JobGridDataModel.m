//
//  JobGridDataModel.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "JobGridDataModel.h"

#pragma mark - JobGridDataModel class

@implementation JobGridDataModel
{
    id m_DataModel;
}

- (void)setServiceResponseModel:(id)dataModel
{
    m_DataModel = dataModel;
    if ([m_DataModel isKindOfClass:[NSArray class]])
    {
        NSMutableArray *mutArr = [NSMutableArray arrayWithArray:m_DataModel];
        [mutArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JobGridDetailDataModel *detailModel = [JobGridDetailDataModel mj_objectWithKeyValues:obj];
            [mutArr replaceObjectAtIndex:idx withObject:detailModel];
        }];
        m_DataModel = mutArr;
    }
}

- (id)getShowDataModel
{
    return m_DataModel;
}

@end

#pragma mark - JobGridDetailDataModel class

@implementation JobGridDetailDataModel
{
    NSDictionary *m_DataModel;
}

- (void)setServiceResponseModel:(NSDictionary *)dataModel
{
    m_DataModel = dataModel;
}

- (NSArray *)getShowDataModel
{
    NSDictionary *accNbrTypeDic = @{@"SMS":@"数字电视",@"CM":@"宽带",@"VOD":@"VOD 点播",@"ITV":@"增值业务"};
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"特别提醒"];
    [attStr ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"D0021B")
                                           Range:NSMakeRange(0, attStr.length)];
    NSMutableAttributedString *remark = [[NSMutableAttributedString alloc] initWithString:@"【请做好增值业务营销工作】"];
    [remark ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"D0021B")
                                           Range:NSMakeRange(0, remark.length)];
    NSArray *dateModel = @[@{@"title":@"工单号",@"detail":self.wassignId?self.wassignId:@""},
                           @{@"title":@"类型",@"detail":self.accNbrType?accNbrTypeDic[self.accNbrType]:@""},
                           @{@"title":@"姓名",@"detail":self.custName?self.custName:@""},
                           @{@"title":@"联系电话",@"detail":self.conTel?self.conTel:@"",@"showImage":@"1"},
                           @{@"title":@"主叫号码",@"detail":self.callinCode?self.callinCode:@""},
                           @{@"title":@"用户编号",@"detail":self.userId?self.userId:@""},
                           @{@"title":@"智能卡号",@"detail":self.rfId?self.rfId:@""},
                           @{@"title":@"派单日期",@"detail":self.dispatchDate?[CommonDate dateToString:[CommonDate dateStringToDate:self.dispatchDate Formate:nil]
                                                                                           Formate:@"yyyy年MM月dd日 HH:mm"]:@""},
                           @{@"title":@"返单日期",@"detail":self.intendDate?[CommonDate dateToString:[CommonDate dateStringToDate:self.intendDate Formate:nil]
                                                                                         Formate:@"yyyy年MM月dd日 HH:mm"]:@""},
                           @{@"title":@"故障描述",@"detail":self.servName?self.servName:@""},
                           @{@"title":@"登记单内容",@"detail":self.rfContent?self.rfContent:@""},
                           @{@"title":@"增值业务信息",@"detail":self.productInfoBoss?self.productInfoBoss:@""},
                           @{@"title":attStr,@"detail":remark},
                           @{@"title":@"用户地址",@"detail":self.custAddr?self.custAddr:@""}];
    return dateModel;
}

- (NSDictionary *)getShowListDataModel
{
    NSDictionary *dateModel = @{@"name":[@"客户姓名：" stringByAppendingString:self.custName?self.custName:@""],
                                @"phone":[@"客户电话：" stringByAppendingString:self.conTel?self.conTel:@""],
                                @"startDate":[@"派单日期：" stringByAppendingString:self.dispatchDate?[CommonDate dateToString:[CommonDate dateStringToDate:self.dispatchDate Formate:nil]
                                                                                                                  Formate:@"yyyy年MM月dd日 HH:mm"]:@""],
                                @"endDate":[@"截止日期：" stringByAppendingString:self.intendReciveDate?[CommonDate dateToString:[CommonDate dateStringToDate:self.intendReciveDate Formate:nil]
                                                                                                                    Formate:@"yyyy年MM月dd日 HH:mm"]:@""],
                                @"errorType":[@"故障类型：" stringByAppendingString:self.servName?self.servName:@""],
                                @"address":[@"客户地址：" stringByAppendingString:self.custAddr?self.custAddr:@""],
                                @"gridDetail":[@"网格信息：" stringByAppendingString:self.gridUnitEmployeeInfo?self.gridUnitEmployeeInfo:@""],
                                @"remark":[@"备注信息：" stringByAppendingString:self.remark?self.remark:@""],
                                @"category":self.category
                                };
    return dateModel;
}

@end
