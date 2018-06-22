//
//  JobGridDataModel.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - JobGridDataModel class
@interface JobGridDataModel : NSObject

- (void)setServiceResponseModel:(id)dataModel;

- (id)getShowDataModel;

@end

#pragma mark - JobGridDetailDataModel class

@interface JobGridDetailDataModel : NSObject

@property (nonatomic, strong) NSString *standby3;

@property (nonatomic, strong) NSString *advice;

@property (nonatomic, strong) NSString *completeDate;

@property (nonatomic, strong) NSString *standby4;

@property (nonatomic, strong) NSString *lockStaffId;

@property (nonatomic, strong) NSString *standby5;

@property (nonatomic, strong) NSString *reaId;

@property (nonatomic, strong) NSString *result;

@property (nonatomic, strong) NSString *dealStaff;

@property (nonatomic, strong) NSString *standby7;

@property (nonatomic, strong) NSString *reaName;

@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *standby8;

@property (nonatomic, strong) NSString *userinfoFlag;

@property (nonatomic, strong) NSString *standby9;

@property (nonatomic, strong) NSString *conTel;

@property (nonatomic, strong) NSString *refWassignId;

@property (nonatomic, assign) NSInteger staffId;

@property (nonatomic, strong) NSString *intendDate;

@property (nonatomic, strong) NSString *stateDate;

@property (nonatomic, strong) NSString *isredirect;

@property (nonatomic, strong) NSString *smsType;

@property (nonatomic, strong) NSString *transReason;

@property (nonatomic, assign) NSInteger faultId;

@property (nonatomic, strong) NSString *usertype;

@property (nonatomic, strong) NSString *smsId;

@property (nonatomic, strong) NSString *standby10;

@property (nonatomic, strong) NSString *checkCode;

@property (nonatomic, strong) NSString *intendReciveDate;

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *servName;

@property (nonatomic, strong) NSString *standby11;

@property (nonatomic, assign) NSInteger retStaffId;

@property (nonatomic, strong) NSString *wassignId;

@property (nonatomic, strong) NSString *dueTo;

@property (nonatomic, strong) NSString *rfId;

@property (nonatomic, strong) NSString *standby12;

@property (nonatomic, strong) NSString *rfContent;

@property (nonatomic, strong) NSString *resultCode;

@property (nonatomic, strong) NSString *confirm;

@property (nonatomic, strong) NSString *visitFlag;

@property (nonatomic, strong) NSString *standby13;

@property (nonatomic, strong) NSString *wareaName;

@property (nonatomic, strong) NSString *replyDate;

@property (nonatomic, strong) NSString *visit;

@property (nonatomic, strong) NSString *timeLeft;

@property (nonatomic, strong) NSString *rfDate;

@property (nonatomic, strong) NSString *canton;

@property (nonatomic, strong) NSString *standby14;

@property (nonatomic, strong) NSString *reciveDate;

@property (nonatomic, assign) NSInteger urgeTimes;

@property (nonatomic, strong) NSString *standby15;

@property (nonatomic, strong) NSString *satisfy;

@property (nonatomic, strong) NSString *dispatchDate;

@property (nonatomic, strong) NSString *lockStaffName;

@property (nonatomic, strong) NSString *standby16;

@property (nonatomic, strong) NSString *timeoutReason;

@property (nonatomic, strong) NSString *productInfoBoss;

@property (nonatomic, strong) NSString *realDealStaff;

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *callinCode;

@property (nonatomic, strong) NSString *category;

@property (nonatomic, strong) NSString *promiseDate;

@property (nonatomic, strong) NSString *custName;

@property (nonatomic, strong) NSString *isExceed;

@property (nonatomic, strong) NSString *custAddr;

@property (nonatomic, strong) NSString *conName;

@property (nonatomic, strong) NSString *gridUnitEmployeeInfo;

@property (nonatomic, strong) NSString *remarkUserinfo;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *delayType;

@property (nonatomic, strong) NSString *punish;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *inquiry;

@property (nonatomic, assign) NSInteger rownum;

@property (nonatomic, strong) NSString *assignDate;

@property (nonatomic, strong) NSString *wareaId;

@property (nonatomic, strong) NSString *standby1;

@property (nonatomic, strong) NSString *standby2;

@property (nonatomic, strong) NSString *accNbrType;


- (void)setServiceResponseModel:(NSDictionary *)dataModel;

- (NSArray *)getShowDataModel;

- (NSDictionary *)getShowListDataModel;

@end
