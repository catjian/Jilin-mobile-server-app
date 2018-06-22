//
//  NoticeTableView.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "NoticeTableViewCell.h"

@interface NoticeTableView : BaseTableView

@property (nonatomic, strong) NSArray<NoticeDataModel *> *noticeDataArray;
@property (nonatomic, strong) NoticeDataModel *dateModel;

@end
