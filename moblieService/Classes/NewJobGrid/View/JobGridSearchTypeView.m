//
//  JobGridSearchTypeView.m
//  moblieService
//
//  Created by zhang_jian on 2018/5/31.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "JobGridSearchTypeView.h"

@implementation JobGridSearchTypeView
{
    ENUM_SEARCH_TYPE type;
    JobGridSearchTypeViewSelectBlock m_Block;
}

- (instancetype)initWithSelectBlock:(JobGridSearchTypeViewSelectBlock)block
{
    self = [super initWithFrame:CGRectMake(0, -DIF_SCREEN_HEIGHT, DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT)
                          style:UITableViewStylePlain];
    if (self)
    {
        type = ENUM_SEARCH_TYPE_DATE;
        [self setBackgroundView:[self getBackView]];
        [self setBackgroundColor:DIF_HEXCOLOR_ALPHA(@"000000", 0.6)];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        m_Block = block;
    }
    return self;
}

- (void)show
{
    [self setAlpha:0];
    [DIF_KeyWindow addSubview:self];
    [self setFrame:CGRectMake(0, Height_NavBar+DIF_PX(40), DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT)];
    [UIView animateWithDuration:.5 animations:^{
        [self setAlpha:1];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:.5 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self setFrame:CGRectMake(0,  -DIF_SCREEN_HEIGHT, DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT)];
        [self removeFromSuperview];
    }];
}

- (UIView *)getBackView
{
    UIView *BackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [BackView setBackgroundColor:DIF_HEXCOLOR_ALPHA(@"000000", 0)];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewAnywhereFinishGesture:)];
    [BackView addGestureRecognizer:tapGR];
    return BackView;
}

- (void)tapViewAnywhereFinishGesture:(UIGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    
    if (point.x > DIF_PX(100) && m_Block)
    {
        m_Block(type, YES);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DIF_PX(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *content = @[@"全部时间",@"最新优先"];
    BaseTableViewCell *cell = [BaseTableViewCell cellClassName:@"BaseTableViewCell"
                                                   InTableView:tableView
                                               forContenteMode:content[indexPath.row]];
    [cell setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [cell.textLabel setText:content[indexPath.row]];
    [cell.textLabel setTextColor:DIF_HEXCOLOR(@"333333")];
    [cell.textLabel setFont:DIF_DIFONTOFSIZE(16)];
    if (![cell.contentView viewWithTag:999])
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(14), 0, self.width-DIF_PX(14*2), 0.5)];
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
    if (indexPath.row == type)
    {
        [view setHidden:NO];
        [cell.textLabel setTextColor:DIF_HEXCOLOR(@"#4DA9EA")];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    type = indexPath.row;
    [tableView reloadData];
    if (m_Block)
    {
        m_Block(type, YES);
    }
}

@end
