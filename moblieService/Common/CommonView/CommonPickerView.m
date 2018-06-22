//
//  CommonPickerView.m
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/21.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonPickerView.h"

@implementation CommonPickerView
{
    UILabel *m_TitleLab;
    UIPickerView *m_PickerView;
    NSInteger m_SelectRow;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_SelectRow = 0;
        self.racSignal = [RACSubject subject];
        [self setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
        [self buildTitleView];
        m_PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, DIF_PX(45), self.width, self.height-DIF_PX(45))];
        [m_PickerView setDelegate:self];
        [m_PickerView setDataSource:self];
        [self addSubview:m_PickerView];
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = [titleStr copy];
    [m_TitleLab setText:titleStr];
}

- (void)buildTitleView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, DIF_PX(44))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
    [self addSubview:view];
    
    m_TitleLab = [[UILabel alloc] initWithFrame:view.bounds];
    [m_TitleLab setTextAlignment:NSTextAlignmentCenter];
    [m_TitleLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [m_TitleLab setFont:DIF_DIFONTOFSIZE(18)];
    [view addSubview:m_TitleLab];
    
    DIF_WeakSelf(self);;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:DIF_HEXCOLOR(@"999999") forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:DIF_DIFONTOFSIZE(15)];
    [cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        DIF_StrongSelf
        [strongSelf.racSignal sendNext:@"CancelButtonEvent"];
    }];
    [view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(DIF_PX(20));
        make.top.bottom.equalTo(view);
        make.width.mas_offset(DIF_PX(80));
    }];
    
    UIButton *sucessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sucessBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sucessBtn setTitleColor:DIF_HEXCOLOR(@"4DA9EA") forState:UIControlStateNormal];
    [sucessBtn.titleLabel setFont:DIF_DIFONTOFSIZE(15)];
    [sucessBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    [[sucessBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        DIF_StrongSelf
        [strongSelf.racSignal sendNext:@{@"SuccessButtonEvent":@{strongSelf.titleStr:strongSelf.pickerDatas[strongSelf->m_SelectRow]}}];
    }];
    [view addSubview:sucessBtn];
    [sucessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-DIF_PX(20));
        make.top.bottom.equalTo(view);
        make.width.mas_offset(DIF_PX(80));
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-DIF_PX(2), view.width, 0.5)];
    [line setBackgroundColor:DIF_HEXCOLOR(DIF_CELL_SEPARATOR_COLOR)];
    [view addSubview:line];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerDatas.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return DIF_PX(35);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerDatas[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = DIF_HEXCOLOR(DIF_CELL_SEPARATOR_COLOR);
        }
    }
    UILabel *contentLab = (UILabel*)view;    
    if (!contentLab)
    {
        contentLab = [[UILabel alloc] init];
        [contentLab setTextAlignment:NSTextAlignmentCenter];
        [contentLab setText:self.pickerDatas[row]];
    }
    [contentLab setTextColor:DIF_HEXCOLOR((m_SelectRow == row?@"4DA9EA":@"A3A3A3"))];
    [contentLab setFont:DIF_DIFONTOFSIZE((m_SelectRow == row?18:15))];
    return contentLab;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    m_SelectRow = row;
    [pickerView reloadComponent:component];
    [pickerView selectRow:row inComponent:component animated:NO];
}

@end
