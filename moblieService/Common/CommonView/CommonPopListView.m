//
//  CommonPopListView.m
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/19.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonPopListView.h"

@interface CommonPopListView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CommonPopListView
{
    BaseTableView *m_ContentView;
    NSArray *m_DataArray;
    NSString *m_CellName;
    CGFloat m_CellHeight;
    NSString *m_HeaderTitle;
    NSString *m_FooterTitle;
    CommonPopListViewSelectBlock m_SelectBlock;
    CommonPopListViewHeaderBlock m_HeaderBlock;
    CommonPopListViewFooterBlock m_FooterBlock;
    CommonPopListViewCloseBlock m_CloseBlock;
}

- (instancetype)initWithFrame:(CGRect)frame
                  HeaderTitle:(NSString *)title
                  FooterTitle:(NSString *)message
                  SelectBlock:(CommonPopListViewSelectBlock)selectBlock
                  HeaderBlock:(CommonPopListViewHeaderBlock)headerBlock
                  FooterBlock:(CommonPopListViewFooterBlock)footerBlock
                   CloseBlock:(CommonPopListViewCloseBlock)closeBlock
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        m_HeaderTitle = title;
        m_FooterTitle = message;
        m_SelectBlock = selectBlock;
        m_HeaderBlock = headerBlock;
        m_FooterBlock = footerBlock;
        m_CloseBlock = closeBlock;
        CGFloat height = DIF_PX((m_HeaderTitle?88:0)+(m_FooterTitle?88:0))+DIF_PX(88*6);
        m_ContentView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(550), height) style:UITableViewStyleGrouped];
        [m_ContentView setCenter:self.center];
        [m_ContentView setDelegate:self];
        [m_ContentView setDataSource:self];
        [m_ContentView setAlpha:0];
        [m_ContentView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        [m_ContentView.layer setCornerRadius:DIF_PX(20)];
        [m_ContentView.layer setMasksToBounds:YES];
        [m_ContentView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [m_ContentView setScrollEnabled:NO];
        [self addSubview:m_ContentView];
        [self loadListDatas:nil UseCellName:@"HomeGPSBlueNameCell" CellHeight:DIF_PX(88)];
    }
    return self;
}

- (BaseTableView *)getListView
{
    return m_ContentView;
}

- (void)loadListDatas:(NSArray *)datas UseCellName:(NSString *)cellName CellHeight:(CGFloat)cellHeight
{
    m_DataArray = datas;
    m_CellName = cellName;
    m_CellHeight = cellHeight;
    CGFloat height = DIF_PX((m_HeaderTitle?88:0)+(m_FooterTitle?88:0));
    if (!m_HeaderTitle && !m_FooterTitle)
    {
        m_ContentView.height = height + m_CellHeight*(m_DataArray.count > 6?6:m_DataArray.count);
    }
    else
    {
        m_ContentView.height = height + m_CellHeight*6;
    }
    if (m_DataArray.count > 6)
    {
        [m_ContentView setScrollEnabled:YES];
    }
    [m_ContentView setCenter:self.center];
    [m_ContentView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void)closePopListView
{
    [UIView animateWithDuration:.4 animations:^{
        [m_ContentView setAlpha:0];
        [self setBackgroundColor:[UIColor clearColor]];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showPopListView
{
    [DIF_KeyWindow addSubview:self];
    [UIView animateWithDuration:.4 animations:^{
        [self setBackgroundColor:DIF_HEXCOLOR_ALPHA(@"000000", .5)];
        [m_ContentView setAlpha:1];
    }];
}

+ (CommonPopListView *)showPopListViewWithHeaderTitle:(NSString *)title
                                          FooterTitle:(NSString *)message
                                          SelectBlock:(CommonPopListViewSelectBlock)selectBlock
                                          HeaderBlock:(CommonPopListViewHeaderBlock)headerBlock
                                          FooterBlock:(CommonPopListViewFooterBlock)footerBlock
                                           CloseBlock:(CommonPopListViewCloseBlock)closeBlock
{
    CommonPopListView *kbView = nil;
    for (UIView *view in DIF_KeyWindow.subviews)
    {
        if ([view isKindOfClass:[CommonPopListView class]])
        {
            kbView = (CommonPopListView *)view;
        }
    }
    if (!kbView)
    {
        kbView = [[CommonPopListView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                              HeaderTitle:title
                                              FooterTitle:message
                                              SelectBlock:selectBlock
                                              HeaderBlock:headerBlock
                                              FooterBlock:footerBlock
                                               CloseBlock:closeBlock];
    }
    [kbView showPopListView];
    return kbView;
}

#pragma mark - Touch Event

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (touchPoint.x < m_ContentView.left || touchPoint.x > m_ContentView.right ||
        touchPoint.y < m_ContentView.top || touchPoint.y > m_ContentView.bottom)
    {
        [self closePopListView];
        if (m_CloseBlock)
        {
            m_CloseBlock();
        }
    }
}

#pragma mark - Table Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_CellName?(m_DataArray.count<=6?6:m_DataArray.count) : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return m_CellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellModel = nil;
    if (indexPath.row <= m_DataArray.count-1)
    {
        cellModel = m_DataArray[indexPath.row];
    }
    BaseTableViewCell *cell = [BaseTableViewCell cellClassName:m_CellName InTableView:tableView forContenteMode:cellModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (m_HeaderTitle?DIF_PX(88):1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (m_FooterTitle?DIF_PX(88):1);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if (m_HeaderTitle)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, DIF_PX(88))];
        [view setBackgroundColor:[UIColor clearColor]];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:view.bounds];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitle:m_HeaderTitle forState:UIControlStateNormal];
        [button setTitleColor:DIF_HEXCOLOR(@"151515") forState:UIControlStateNormal];
        [button.titleLabel setFont:DIF_DIFONTOFSIZE(34)];
        if (m_HeaderBlock)
        {
            DIF_WeakSelf(self);;
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                DIF_StrongSelf
                strongSelf->m_HeaderBlock();
            }];
        }
        [view addSubview:button];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, view.height-DIF_PX(2), view.width, DIF_PX(2))];
        [line setImage:[CommonImage imageWithSize:line.size FillColor:DIF_HEXCOLOR(@"f0f0f0")]];
        [view addSubview:line];
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = nil;
    if (m_FooterTitle)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, DIF_PX(88))];
        [view setBackgroundColor:[UIColor clearColor]];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:view.bounds];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitle:m_FooterTitle forState:UIControlStateNormal];
        [button setTitleColor:DIF_HEXCOLOR(@"346f66") forState:UIControlStateNormal];
        [button setTitleColor:DIF_HEXCOLOR(@"151515") forState:UIControlStateHighlighted];
        [button.titleLabel setFont:DIF_DIFONTOFSIZE(31)];
        if (m_FooterBlock)
        {
            DIF_WeakSelf(self);
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                DIF_StrongSelf
                strongSelf->m_FooterBlock();
            }];
        }
        [view addSubview:button];
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellModel = nil;
    if (indexPath.row <= m_DataArray.count-1)
    {
        cellModel = m_DataArray[indexPath.row];
    }
    if (m_SelectBlock && cellModel)
    {
        m_SelectBlock(cellModel,indexPath);
    }
}

@end
