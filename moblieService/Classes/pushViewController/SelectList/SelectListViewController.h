//
//  SelectListViewController.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SelectListViewControllerSelectBlock)(NSIndexPath *, BOOL isBack);

@interface SelectListViewController : BaseViewController

@property (nonatomic, strong) NSArray *selectDataArray;
@property (nonatomic, copy) SelectListViewControllerSelectBlock selectBlock;

@property (nonatomic) BOOL isSelectCallBack;
@end
