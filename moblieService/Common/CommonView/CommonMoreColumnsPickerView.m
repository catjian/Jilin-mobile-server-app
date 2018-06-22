//
//  CommonMoreColumnsPickerView.m
//  uavsystem
//
//  Created by zhang_jian on 2017/9/15.
//  Copyright © 2017年 . All rights reserved.
//

#import "CommonMoreColumnsPickerView.h"

@implementation CommonMoreColumnsPickerView
{
    UILabel *m_TitleLab;
    UIPickerView *m_PickerView;
    NSMutableArray<NSNumber *> *m_SelectRowArr;
    BOOL m_IsSelected;
    NSMutableArray *m_ContentArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.racSignal = [RACSubject subject];
        [self setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
        [self buildTitleView];
        m_PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, DIF_PX(74), self.width, self.height-DIF_PX(74))];
        [m_PickerView setDelegate:self];
        [m_PickerView setDataSource:self];
        [self addSubview:m_PickerView];
        m_SelectRowArr = [NSMutableArray array];
        m_IsSelected = NO;
        m_ContentArray = [NSMutableArray array];
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = [titleStr copy];
    [m_TitleLab setText:[titleStr stringByAppendingString:self.pickerDatas.firstObject]];
}

- (void)setColumnsNumber:(NSInteger)columnsNumber
{
    _columnsNumber = columnsNumber;
    for (int i = 0; i < columnsNumber; i++)
    {
        [m_SelectRowArr addObject:@(0)];
        [m_ContentArray addObject:@[]];
    }
    [self pickerView:m_PickerView didSelectRow:0 inComponent:columnsNumber-1];
}

- (void)buildTitleView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, DIF_PX(74))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
    [self addSubview:view];
    
    m_TitleLab = [[UILabel alloc] initWithFrame:view.bounds];
    [m_TitleLab setTextAlignment:NSTextAlignmentCenter];
    [m_TitleLab setTextColor:DIF_HEXCOLOR(DIF_NORMAL_THEME_COLOR)];
    [m_TitleLab setFont:DIF_DIFONTOFSIZE(DIF_BaseFont_Size)];
//    [view addSubview:m_TitleLab];
    
    DIF_WeakSelf(self);;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:DIF_HEXCOLOR(DIF_NORMAL_THEME_COLOR) forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:DIF_DIFONTOFSIZE(DIF_BaseFont_Size)];
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        DIF_StrongSelf
        [strongSelf.racSignal sendNext:@"CancelButtonEvent"];
    }];
    [view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(DIF_PX(30));
        make.top.bottom.equalTo(view);
        make.width.mas_offset(DIF_PX(80));
    }];
    
    UIButton *sucessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sucessBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sucessBtn setTitleColor:DIF_HEXCOLOR(DIF_NORMAL_THEME_COLOR) forState:UIControlStateNormal];
    [sucessBtn.titleLabel setFont:DIF_DIFONTOFSIZE(DIF_BaseFont_Size)];
    [[sucessBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        DIF_StrongSelf
        if (m_TitleLab.text)
        {
            [strongSelf.racSignal sendNext:@{@"SuccessButtonEvent":(self.titleStr?[m_TitleLab.text substringFromIndex:self.titleStr.length]:m_TitleLab.text)}];
        }
    }];
    [view addSubview:sucessBtn];
    [sucessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-DIF_PX(30));
        make.top.bottom.equalTo(view);
        make.width.mas_offset(DIF_PX(80));
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-DIF_PX(2), view.width, DIF_PX(2))];
    [line setBackgroundColor:DIF_HEXCOLOR(DIF_CELL_SEPARATOR_COLOR)];
    [view addSubview:line];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.columnsNumber;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numberOfRow = 0;
    NSDictionary *contentDic;
    NSString *content;
    for (int i = 0; i <= component; i++)
    {
        if (i == 0)
        {
            numberOfRow = self.pickerDatas.count;
            [m_ContentArray replaceObjectAtIndex:component withObject:self.pickerDatas];
            contentDic = self.pickerDatas[m_SelectRowArr[i].integerValue];
            content = contentDic.allKeys.firstObject;
        }
        else
        {
            [m_ContentArray replaceObjectAtIndex:component withObject:contentDic[content]];
            numberOfRow = [contentDic[content] count];
            contentDic = [contentDic[content] objectAtIndex:m_SelectRowArr[i].integerValue];
            content = contentDic.allKeys.firstObject;
        }
    }
    return numberOfRow;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return DIF_PX(62);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *content;
    if (component < self.columnsNumber-1)
    {
        NSArray *contentArr = m_ContentArray[component];
        NSDictionary *contentDic = contentArr[row];
        content = contentDic.allKeys.firstObject;
    }
    else
    {
        NSArray *contentArr = m_ContentArray[component];
        NSDictionary *contentDic = [contentArr objectAtIndex:row];
        if (contentDic.allKeys.count == 0)
        {
            content = contentDic.allKeys.firstObject;
        }
        else if (self.lastColumnsKey && [contentDic objectForKey:self.lastColumnsKey])
        {
            content = contentDic[self.lastColumnsKey];
        }
    }
    return content;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    NSString *content;
    if (component < self.columnsNumber-1)
    {
        NSArray *contentArr = m_ContentArray[component];
        NSDictionary *contentDic = contentArr[row];
        content = contentDic.allKeys.firstObject;
    }
    else
    {
        NSArray *contentArr = m_ContentArray[component];
        NSDictionary *contentDic = [contentArr objectAtIndex:row];
        if (contentDic.allKeys.count == 0)
        {
            content = contentDic.allKeys.firstObject;
        }
        else if (self.lastColumnsKey && [contentDic objectForKey:self.lastColumnsKey])
        {
            content = contentDic[self.lastColumnsKey];
        }
    }
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
        [contentLab setFont:DIF_DIFONTOFSIZE(DIF_BaseFont_Size)];
        [contentLab setText:content];
    }
    [contentLab setTextColor:DIF_HEXCOLOR(@"#161616")];
    if (m_SelectRowArr[component].integerValue == row)
    {
        [contentLab setTextColor:DIF_HEXCOLOR(DIF_NORMAL_THEME_COLOR)];
    }
    return contentLab;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [m_SelectRowArr replaceObjectAtIndex:component withObject:@(row)];
    [m_PickerView reloadComponent:component];
    
    for (int i = component+1; i < self.columnsNumber; i++)
    {
        [m_SelectRowArr replaceObjectAtIndex:i withObject:@(0)];
        [m_PickerView reloadComponent:i];
        [pickerView selectRow:0 inComponent:i animated:YES];
    }
    
    NSMutableString *titleLabStr = [NSMutableString string];
    if (self.titleStr)
    {
        [titleLabStr appendString:self.titleStr];
    }
    NSDictionary *contentDic;
    NSString *content;
    for (int i = 0; i < self.columnsNumber; i++)
    {
        if (i == 0)
        {
            contentDic = self.pickerDatas[m_SelectRowArr[i].integerValue];
            content = contentDic.allKeys.firstObject;
            [titleLabStr appendString:content];
        }
        else if (i > 0 && i < self.columnsNumber-1)
        {
            contentDic = [contentDic[content] objectAtIndex:m_SelectRowArr[i].integerValue];
            content = contentDic.allKeys.firstObject;
            [titleLabStr appendString:@" - "];
            [titleLabStr appendString:content];
        }
        else
        {
            contentDic = [contentDic[content] objectAtIndex:m_SelectRowArr[i].integerValue];
            if (contentDic.allKeys.count == 0)
            {
                content = contentDic.allKeys.firstObject;
            }
            else if (self.lastColumnsKey && [contentDic objectForKey:self.lastColumnsKey])
            {
                content = contentDic[self.lastColumnsKey];
            }
            else
            {
                content = @"";
            }
            if (content.length > 0)
            {
                [titleLabStr appendString:@" - "];
                [titleLabStr appendString:content];
            }
        }
    }
    [m_TitleLab setText:titleLabStr];
}

@end

