//
//  SelectListViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SelectListViewController.h"

@interface SelectListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SelectListViewController
{
    BaseTableView *m_BaseView;
    NSIndexPath *m_SelectedIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_SelectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[BaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [m_BaseView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [m_BaseView setBackgroundColor:DIF_HEXCOLOR(@"EDEEF0")];
        [m_BaseView setDelegate:self];
        [m_BaseView setDataSource:self];
        [self.view addSubview:m_BaseView];
    }
}

- (void)leftBarButtonItemAction:(UIButton *)btn
{
    if (self.selectBlock)
    {
        self.selectBlock(m_SelectedIndex, YES);
    }
    [super leftBarButtonItemAction:btn];
}


#pragma mark - UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?1:self.selectDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DIF_PX(45);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return DIF_PX(10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [BaseTableViewCell cellClassName:@"BaseTableViewCell"
                                                   InTableView:tableView
                                               forContenteMode:nil];
    [cell setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    if (indexPath.section == 0)
    {
        [cell.textLabel setText:@"请选择"];
    }
    else
    {
        [cell.textLabel setText:self.selectDataArray[indexPath.row]];
    }
    [cell.textLabel setTextColor:DIF_HEXCOLOR(@"000000")];
    [cell.textLabel setFont:DIF_DIFONTOFSIZE(16)];
    if (![cell.contentView viewWithTag:999])
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(15), DIF_PX(44), DIF_SCREEN_WIDTH-DIF_PX(16), 0.5)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"c8c7cc")];
        [line setTag:999];
        [cell.contentView addSubview:line];
    }
    
    if (![cell.contentView viewWithTag:1001])
    {
        UILabel *imageView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(50), DIF_PX(50))];
        [imageView setRight:DIF_SCREEN_WIDTH-DIF_PX(18)];
        [imageView setTag:1001];
        [imageView setTextColor:DIF_HEXCOLOR(@"#4DA9EA")];
        [imageView setFont:DIF_DIFONTOFSIZE(20)];
        [imageView setText:@"✓"];
        [imageView setTextAlignment:NSTextAlignmentRight];
        [cell.contentView addSubview:imageView];
    }
    UIView *view = [cell.contentView viewWithTag:1001];
    [view setHidden:YES];
    if (indexPath.section == m_SelectedIndex.section &&
        indexPath.row == m_SelectedIndex.row)
    {
        [view setHidden:NO];
        [cell.textLabel setTextColor:DIF_HEXCOLOR(@"#4DA9EA")];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    m_SelectedIndex = indexPath;
    [tableView reloadData];
    if (self.isSelectCallBack && self.selectBlock)
    {
        self.selectBlock(m_SelectedIndex, NO);
    }
}

@end
