//
//  NoticeDetailTableView.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NoticeDetailTableView.h"

@implementation NoticeDetailTableView
{
    NSArray *m_contentArr;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self)
    {
        [self setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

#pragma mark - UITalbeView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    m_contentArr = self.dateModel.getShowDataModel;
    return self.dateModel.getShowDataModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.f;
    NoticeDetailTableViewCell *cell = [BaseTableViewCell cellClassName:@"NoticeDetailTableViewCell" InTableView:nil forContenteMode:m_contentArr[indexPath.row]];
    height = cell.getCellHeight;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeDetailTableViewCell *cell = [BaseTableViewCell cellClassName:@"NoticeDetailTableViewCell" InTableView:tableView forContenteMode:m_contentArr[indexPath.row]];
    if ([m_contentArr[indexPath.row] count] == 3)
    {
        cell.downloadBlock = self.downloadBlock;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [line setBackgroundColor:DIF_HEXCOLOR(@"c8c7cc")];
    return line;
}

@end
