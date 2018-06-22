//
//  AddExecStaffViewController.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^AddExecStaffViewControllerSelectBlock)(NSIndexPath *);

@interface AddExecStaffViewController : BaseViewController

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) AddExecStaffViewControllerSelectBlock selectBlock;

@end
