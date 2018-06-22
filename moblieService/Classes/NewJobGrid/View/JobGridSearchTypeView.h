//
//  JobGridSearchTypeView.h
//  moblieService
//
//  Created by zhang_jian on 2018/5/31.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"

typedef NS_ENUM(NSUInteger, ENUM_SEARCH_TYPE) {
    ENUM_SEARCH_TYPE_DATE = 0,
    ENUM_SEARCH_TYPE_NEW
};

typedef void(^JobGridSearchTypeViewSelectBlock)(ENUM_SEARCH_TYPE,BOOL isFinish);

@interface JobGridSearchTypeView : BaseTableView

- (instancetype)initWithSelectBlock:(JobGridSearchTypeViewSelectBlock)block;

- (void)show;

- (void)hide;

@end
