//
//  NoticeDataModel.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NoticeDataModel class
@interface NoticeDataModel : NSObject

@property (nonatomic, strong) NSString *notifyId;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *sendDate;

- (NSDictionary *)getShowDataModel;

@end

#pragma mark - NoticeDetailDataModel class

@interface NoticeDetailDataModel : NSObject

@property (nonatomic, strong) NSString *attach;

@property (nonatomic, strong) NSString *conTel;

@property (nonatomic, strong) NSString *notifyId;

@property (nonatomic, strong) NSString *sendDate;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *invalidDate;

@property (nonatomic, strong) NSString *staffName;

@property (nonatomic, strong) NSString *conMobile;

@property (nonatomic, strong) NSString *messageBlob;

@property (nonatomic, strong) NSString *workName;

- (NSArray *)getShowDataModel;

@end
