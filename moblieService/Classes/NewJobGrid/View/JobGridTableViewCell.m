//
//  JobGridTableViewCell.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "JobGridTableViewCell.h"

@implementation JobGridTableViewCell
{
    UIView *m_ContentView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = DIF_PX(208+9);
        [self setBackgroundColor:DIF_HEXCOLOR(@"edeef0")];
        [self createContentView];
    }
    return self;
}

- (void)createContentView
{
    m_ContentView = [UIView new];
    [self.contentView addSubview:m_ContentView];
    [m_ContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(DIF_PX(9));
        make.left.right.bottom.equalTo(self);
    }];
    CGFloat offset_height = DIF_PX(22);
    for (int i = 0; i < 8; i++)
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(16), (i+1)*offset_height, DIF_SCREEN_WIDTH-DIF_PX(16*2), offset_height)];
        [lab setTag:2000+i];
        [lab setTextColor:DIF_HEXCOLOR(@"666666")];
        [lab setFont:DIF_DIFONTOFSIZE(14)];
        [m_ContentView addSubview:lab];
    }
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setFrame:CGRectMake(0, DIF_PX(16), DIF_PX(60), DIF_PX(30))];
    UILabel *rightBtn = [[UILabel alloc] initWithFrame:CGRectMake(0, DIF_PX(16), DIF_PX(60), DIF_PX(30))];
    [rightBtn setRight:DIF_SCREEN_WIDTH-DIF_PX(16)];
    [rightBtn  setFont:DIF_DIFONTOFSIZE(15)];
    [rightBtn setTextColor:DIF_HEXCOLOR(@"4DA9EA")];
    [rightBtn setText:@"处理"];
    [rightBtn setTextAlignment:NSTextAlignmentCenter];
    [rightBtn.layer setBorderWidth:1];
    [rightBtn.layer setBorderColor:DIF_HEXCOLOR(@"4DA9EA").CGColor];
    [m_ContentView addSubview:rightBtn];
}

- (void)loadData:(id)model
{
    NSArray *keyArr = @[@"name",@"phone",@"startDate",@"endDate",@"errorType",@"address",@"gridDetail",@"remark",@"category"];
    NSString *category = [model objectForKey:keyArr.lastObject];
    [m_ContentView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    if ([category isEqualToString:@"T"])
    {
        [m_ContentView setBackgroundColor:DIF_HEXCOLOR(@"FFEEEA")];
    }
    for (int i = 0; i < 8; i++)
    {
        UILabel *lab = (UILabel *)[m_ContentView viewWithTag:2000+i];
        NSString *content = [model objectForKey:keyArr[i]];
        if (i == 7 && [category isEqualToString:@"T"])
        {
            NSRange range = [content rangeOfString:@"："];
            NSInteger loc = range.location+range.length;
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content];
            [attStr ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ff8360")
                                                   Range:NSMakeRange(loc, content.length-loc)];
            [lab setAttributedText:attStr];
        }
        else
        {            
            [lab setText:content];
        }
    }
}

@end
