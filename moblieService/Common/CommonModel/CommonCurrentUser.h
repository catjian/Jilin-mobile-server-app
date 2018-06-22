//
//  CurrentUser.h
//  HuLaQuan
//
//  Created by hok on 1/18/16.
//  Copyright © 2018 Jianghao. All rights reserved.
//

@interface CommonCurrentUser : NSObject

#define DIF_CommonCurrentUser [CommonCurrentUser sharedInstance]

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *wareaId;
@property (nonatomic, copy) NSString *staffId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *wareaName;

@property (nonatomic, copy) NSString *autoLogin;

@property (nonatomic, copy) NSString *serviceHost;
@property (nonatomic, copy) NSString *servicePort;
@property (nonatomic, copy) NSString *serviceName;
@property (nonatomic, copy) NSString *pageSize;



+ (CommonCurrentUser *)sharedInstance;


@end
