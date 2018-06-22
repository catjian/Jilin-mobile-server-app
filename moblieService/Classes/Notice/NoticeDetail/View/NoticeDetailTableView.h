//
//  NoticeDetailTableView.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "NoticeDetailTableViewCell.h"

@interface NoticeDetailTableView : BaseTableView

@property (nonatomic, strong) NoticeDetailDataModel *dateModel;
@property (nonatomic, copy) NoticeDetailTableViewCellDownloadBlock downloadBlock;

@end
