//
//  NoticeDetailTableViewCell.h
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "NoticeDataModel.h"

typedef void(^NoticeDetailTableViewCellDownloadBlock)(void);

@interface NoticeDetailTableViewCell : BaseTableViewCell

@property (nonatomic, copy) NoticeDetailTableViewCellDownloadBlock downloadBlock;

@end
