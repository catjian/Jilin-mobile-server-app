//
//  JobGridDetailTableView.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "JobGridDetailTableView.h"

@implementation JobGridDetailTableView

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
    return self.dateModel.getShowDataModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [self.dateModel.state isEqualToString:@"Z"]?0:50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.f;
    JobGridDetailTableViewCell *cell = [BaseTableViewCell cellClassName:@"JobGridDetailTableViewCell" InTableView:nil forContenteMode:self.dateModel.getShowDataModel[indexPath.row]];
    height = cell.getCellHeight;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobGridDetailTableViewCell *cell = [BaseTableViewCell cellClassName:@"JobGridDetailTableViewCell" InTableView:tableView forContenteMode:self.dateModel.getShowDataModel[indexPath.row]];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.dateModel.state isEqualToString:@"Z"])
    {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 50)];
    [view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    NSArray *btnTitles = @[@"接收",@"错返",@"转派部门"];
    if ([self.dateModel.state isEqualToString:@"A"])
    {
        btnTitles = @[@"接收",@"错返",@"转派部门"];
    }
    else if ([self.dateModel.state isEqualToString:@"B"])
    {
        btnTitles = @[@"处理返单",@"申请",@"转派部门",@"错返",@"转派员工"];
    }
    else if ([self.dateModel.state isEqualToString:@"Z"])
    {
        btnTitles = @[@"接收",@"错返",@"转派部门"];
    }
    CGFloat offset_widht = DIF_SCREEN_WIDTH/5;
    for (int i = 0; i < 5; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i*offset_widht, 0, offset_widht, 51)];
        [btn setTag:500+i];
        [btn.layer setBorderWidth:1];
        [btn.layer setBorderColor:DIF_HEXCOLOR(@"e5e5e5").CGColor];
        [btn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
        [btn.titleLabel setFont:DIF_DIFONTOFSIZE((is_iPhone5AndEarly)?12:14)];
        [btn setTitle:(i < btnTitles.count?btnTitles[i]:@"") forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(footViewButtonsEvent:)
      forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    return view;
}

- (void)footViewButtonsEvent:(UIButton *)btn
{
    ENUM_Detail_Dispose dispose = -1;
    switch (btn.tag-500)
    {
        case 0:
            dispose = ENUM_Detail_Dispose_Accept;
            if ([self.dateModel.state isEqualToString:@"B"])
            {
                dispose = ENUM_Detail_Dispose_Accept_Back;
            }
            break;
        case 1:
        {
            dispose = ENUM_Detail_Dispose_ErrorBack;
            if ([self.dateModel.state isEqualToString:@"B"])
            {
                dispose = ENUM_Detail_Dispose_Apply;
            }
        }
            break;
        case 2:
            dispose = ENUM_Detail_Dispose_TurnDepartment;
            break;
        case 3:
            if ([self.dateModel.state isEqualToString:@"B"])
            {
                dispose = ENUM_Detail_Dispose_ErrorBack;
            }
        default:
            break;
    }
    if (dispose == -1)
    {
        return;
    }
    if (self.disposeBlock)
    {
        self.disposeBlock(dispose);
    }
}

@end
