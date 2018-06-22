//
//  WareaJsonMobileModel.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/5.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WareaJsonMobileModel : NSObject

@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *wareaId;

@property (nonatomic, strong) NSString *disporder;

@property (nonatomic, strong) NSString *canton;

@property (nonatomic, strong) NSArray *children;

@property (nonatomic, strong) NSString *name;

@end
