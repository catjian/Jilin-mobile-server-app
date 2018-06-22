//
//  JobGridTableView.m
//  moblieService
//
//  Created by zhang_jian on 2018/5/31.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "JobGridTableView.h"

@implementation JobGridTableView
{
    UIView *m_BackView;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self)
    {
        [self setBackgroundView:[self getBackView]];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];        
    }
    return self;
}

- (UIView *)getBackView
{
    if(!m_BackView)
    {
        m_BackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [m_BackView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_none"]];
        CGPoint centerPoint = CGPointMake(self.width/2, self.height/2);
        [imageView setCenter:centerPoint];
        [m_BackView addSubview:imageView];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom+DIF_PX(11), DIF_SCREEN_WIDTH, DIF_PX(20))];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [lab setText:@"暂时没有新工单"];
        [lab setTextColor:DIF_HEXCOLOR(@"B3B3B3")];
        [lab setFont:DIF_DIFONTOFSIZE(14)];
        [m_BackView addSubview:lab];
    }
    return m_BackView;
}

- (void)setGridDataArray:(NSArray *)gridDataArray
{
    _gridDataArray = gridDataArray;
    if (gridDataArray && gridDataArray.count > 0)
    {
        [self setBackgroundView:nil];
        [self setBackgroundColor:DIF_HEXCOLOR(@"edeef0")];
    }
    else
    {        
        [self setBackgroundView:[self getBackView]];
    }
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

#pragma mark - UITalbeView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gridDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DIF_PX(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.f;
    JobGridDetailDataModel *dataModel = self.gridDataArray[indexPath.row];
    JobGridTableViewCell *cell = [BaseTableViewCell cellClassName:@"JobGridTableViewCell" InTableView:nil forContenteMode:dataModel.getShowListDataModel];
    height = cell.getCellHeight;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dateModel setServiceResponseModel:@{@"gridType":indexPath.row%2==0?@"1":@"0"}];
    JobGridDetailDataModel *dataModel = self.gridDataArray[indexPath.row];
    JobGridTableViewCell *cell = [BaseTableViewCell cellClassName:@"JobGridTableViewCell" InTableView:tableView forContenteMode:dataModel.getShowListDataModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock)
    {
        JobGridDetailDataModel *dataModel = self.gridDataArray[indexPath.row];
        self.selectBlock(indexPath, dataModel);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(40))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"")];
    
    return view;
}

@end
