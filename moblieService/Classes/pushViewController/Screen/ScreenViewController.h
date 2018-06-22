//
//  ScreenViewController.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ScreenViewControllerBlock)(NSDictionary *screenDic);

@interface ScreenViewController : BaseViewController

@property (nonatomic, copy) ScreenViewControllerBlock block;

@end
