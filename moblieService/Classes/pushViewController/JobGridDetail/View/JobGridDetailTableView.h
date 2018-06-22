//
//  JobGridDetailTableView.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "JobGridDetailTableViewCell.h"

typedef NS_ENUM(NSUInteger, ENUM_Detail_Dispose) {
    ENUM_Detail_Dispose_Accept = 0,
    ENUM_Detail_Dispose_Accept_Back,
    ENUM_Detail_Dispose_ErrorBack,
    ENUM_Detail_Dispose_TurnDepartment,
    ENUM_Detail_Dispose_Apply
};

typedef void(^JobGridDetailTableViewDisposeBlock)(ENUM_Detail_Dispose dispose);

@interface JobGridDetailTableView : BaseTableView

@property (nonatomic, strong) JobGridDetailDataModel *dateModel;
@property (nonatomic, copy) JobGridDetailTableViewDisposeBlock disposeBlock;

@end
