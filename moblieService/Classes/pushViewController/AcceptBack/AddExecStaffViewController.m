//
//  AddExecStaffViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "AddExecStaffViewController.h"

@interface AddExecStaffViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation AddExecStaffViewController
{
    BaseTableView *m_BaseView;
    NSIndexPath *m_SelectedIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"处理返单"];
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
        self.selectBlock(m_SelectedIndex);
    }
    [super leftBarButtonItemAction:btn];
}


#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
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
    [cell.textLabel setText:self.dataArray[indexPath.row]];
    [cell.textLabel setTextColor:DIF_HEXCOLOR(@"000000")];
    [cell.textLabel setFont:DIF_DIFONTOFSIZE(16)];
    [cell.imageView setImage:[UIImage imageNamed:@"checkbox_empty"]];
    if (![cell.contentView viewWithTag:999])
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(15), DIF_PX(44), DIF_SCREEN_WIDTH-DIF_PX(16), 0.5)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"c8c7cc")];
        [line setTag:999];
        [cell.contentView addSubview:line];
    }
    if (m_SelectedIndex && m_SelectedIndex.row == indexPath.row)
    {
        [cell.imageView setImage:[UIImage imageNamed:@"checkbox_select"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!m_SelectedIndex)
    {
        m_SelectedIndex = indexPath;
    }
    else
    {
        m_SelectedIndex = nil;
    }
    [tableView reloadData];
}

@end
