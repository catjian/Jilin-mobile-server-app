//
//  JobGridTableView.h
//  moblieService
//
//  Created by zhang_jian on 2018/5/31.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "JobGridTableViewCell.h"

typedef void(^JobGridTableViewReorderBlock)(NSString *reorder);

@interface JobGridTableView : BaseTableView

@property (nonatomic, strong) NSArray *gridDataArray;
@property (nonatomic, strong) JobGridDataModel *dateModel;
@property (nonatomic, copy) JobGridTableViewReorderBlock reorderBlock;

@end
