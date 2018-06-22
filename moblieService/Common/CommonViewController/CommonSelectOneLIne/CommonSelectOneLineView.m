//
//  CommonSelectOneLineView.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CommonSelectOneLineView.h"

@implementation CommonSelectOneLineView
{
    BOOL m_HiddenHeader;
    NSInteger m_SelectRow;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self)
    {
        m_HiddenHeader = NO;
        [self setBackgroundColor:DIF_HEXCOLOR(@"EDEEF0")];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

#pragma mark - UITalbeView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CELLIDENTIFIER";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        UILabel *checkLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [checkLab setRight:DIF_SCREEN_WIDTH];
        [checkLab setTextAlignment:NSTextAlignmentCenter];
        [checkLab setTextColor:DIF_HEXCOLOR(@"4DA9EA")];
        [checkLab setFont:DIF_DIFONTOFSIZE(16)];
        [checkLab setText:@"✓"];
        [checkLab setHidden:YES];
        [checkLab setTag:999];
        [cell.contentView addSubview:checkLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(15), 43, DIF_SCREEN_WIDTH-DIF_PX(15), 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"c8c7cc")];
        [cell.contentView addSubview:line];
    }
    [cell.textLabel setText:self.dataArray[indexPath.row]];
    UILabel *checkLab = [cell.contentView viewWithTag:999];
    [checkLab setHidden:YES];
    if (indexPath.row == m_SelectRow)
    {
        [checkLab setHidden:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    m_HiddenHeader = YES;
    m_SelectRow = indexPath.row;
    [self reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 54)];
    [view setBackgroundColor:DIF_HEXCOLOR(@"")];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 44)];
    [bgView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [view addSubview:bgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, bgView.width-28, bgView.height)];
    [lab setText:@"请选择"];
    [lab setTextColor:DIF_HEXCOLOR(@"000000")];
    [lab setFont:DIF_DIFONTOFSIZE(16)];
    [bgView addSubview:lab];
    
    UILabel *checkLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [checkLab setRight:DIF_SCREEN_WIDTH];
    [checkLab setTextAlignment:NSTextAlignmentCenter];
    [checkLab setTextColor:DIF_HEXCOLOR(@"4DA9EA")];
    [checkLab setFont:DIF_DIFONTOFSIZE(16)];
    [checkLab setText:@"✓"];
    [checkLab setHidden:m_HiddenHeader];
    [bgView addSubview:checkLab];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerGestureRecognizer:)];
    [bgView addGestureRecognizer:tapGR];
    
    return view;
}

- (void)headerGestureRecognizer:(UIGestureRecognizer *)gestur
{
    m_HiddenHeader = NO;
    [self reloadData];
}

@end
