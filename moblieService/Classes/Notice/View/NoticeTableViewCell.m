//
//  NoticeTableViewCell.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NoticeTableViewCell.h"

@implementation NoticeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = DIF_PX(83);
        [self setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        [self createContentView];
        [self setShowLine:YES];
        self.showLineWidht = DIF_SCREEN_WIDTH - DIF_PX(15);
    }
    return self;
}

- (void)createContentView
{
    UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(14), DIF_PX(16), DIF_SCREEN_WIDTH-DIF_PX(14*2), DIF_PX(17))];
    [dateLab setTag:2000];
    [dateLab setTextColor:DIF_HEXCOLOR(@"999999")];
    [dateLab setFont:DIF_DIFONTOFSIZE(12)];
    [self.contentView addSubview:dateLab];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(dateLab.left, dateLab.bottom+DIF_PX(12), DIF_SCREEN_WIDTH-DIF_PX(14+50), DIF_PX(22))];
    [lab setTag:2001];
    [lab setTextColor:DIF_HEXCOLOR(@"000000")];
    [lab setFont:DIF_DIFONTOFSIZE(15)];
    [lab setLineBreakMode:NSLineBreakByCharWrapping];
    [lab setNumberOfLines:0];
    [self.contentView addSubview:lab];
    
    UILabel *rightlab = [[UILabel alloc] initWithFrame:CGRectMake(lab.right, lab.top, DIF_PX(50), lab.height)];
    [rightlab setTag:2002];
    [rightlab setTextColor:DIF_HEXCOLOR(@"999999")];
    [rightlab setFont:DIF_DIFONTOFSIZE(14)];
    [rightlab setText:@">"];
    [rightlab setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:rightlab];
}

- (void)loadData:(id)model
{
    NSArray *keyArr = @[@"date",@"title"];
    UILabel *dateLab = (UILabel *)[self.contentView viewWithTag:2000];
    [dateLab setText:model[keyArr[0]]];
    UILabel *lab = (UILabel *)[self.contentView viewWithTag:2001];
    [lab setText:model[keyArr[1]]];
    CGSize textSize = [lab.text boundingRectWithSize:CGSizeMake(lab.frame.size.width, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                           attributes:@{NSFontAttributeName:lab.font}
                                              context:nil].size;
    if (textSize.height > lab.height)
    {
        lab.height = ((textSize.height/lab.height))*DIF_PX(22);
    }
    UILabel *rightlab = (UILabel *)[self.contentView viewWithTag:2002];
    [rightlab setHeight:lab.height];
    self.cellHeight = self.cellHeight-DIF_PX(22) + lab.height;
}

@end
