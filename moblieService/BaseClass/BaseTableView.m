//
//  BaseTableView.m
//  uavsystem
//
//  Created by zhang_jian on 16/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self setDelegate:self];
        [self setDataSource:self];
        self.pageNum = 0;
        if (@available(iOS 11.0, *))
        {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (_touchBeginBlock)
    {
        self.touchBeginBlock(self, touches, event);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (_touchEndBlock)
    {
        self.touchEndBlock(self, touches, event);
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (_touchMoveBlock)
    {
        self.touchMoveBlock(self, touches, event);
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (_touchCancelBlock)
    {
        self.touchCancelBlock(self, touches, event);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_scrollBlock)
    {
        self.scrollBlock(self,scrollView);
    }
}

#pragma mark - Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - refresh Action

- (void)setRefreshBlock:(tableViewHeaderRefreshBlock)refreshBlock
{
    _refreshBlock = [refreshBlock copy];
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.mj_header beginRefreshing];
}

- (void)setLoadMoreBlock:(tableViewLoadMoreBlock)loadMoreBlock
{
    _loadMoreBlock = [loadMoreBlock copy];
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreAction)];
}

- (void)refreshAction
{
    self.pageNum = 0;
    if (self.refreshBlock)
    {
        if (self.mj_footer)
        {
            [self.mj_footer resetNoMoreData];
        }
        self.refreshBlock();
    }
    else
    {
        [self endRefresh];
        self.mj_header = nil;
        self.mj_footer = nil;
    }
}

- (void)loadMoreAction
{
    if(self.loadMoreBlock)
    {
        self.loadMoreBlock(++self.pageNum);
    }
    else
    {
        [self endRefresh];
        self.mj_header = nil;
        self.mj_footer = nil;
    }
}

- (void)endRefresh
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

@end
