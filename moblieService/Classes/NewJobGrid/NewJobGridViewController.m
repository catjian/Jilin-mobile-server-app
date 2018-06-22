//
//  NewJobGridViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/5/30.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NewJobGridViewController.h"
#import "ScreenViewController.h"

@interface NewJobGridViewController ()

@end

@implementation NewJobGridViewController
{
    JobGridTableView *m_BaseView;
    JobGridDataModel *m_DateModel;
    NSString *m_ReorderType;
    NSDictionary *m_ScreenDic;
    UIButton *m_CenterBtn;
    JobGridSearchTypeView *m_SearchView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.showback)
    {
        DIF_ShowTabBarAnimation(YES);
        UIButton *leftBtn = [self setLeftItemWithContentName:@"新工单 "];
        [leftBtn.titleLabel setFont:DIF_DIFONTOFSIZE(is_iPhone5AndEarly?24:28)];
        [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [leftBtn setTitleColor:DIF_HEXCOLOR(@"#25313F") forState:UIControlStateNormal];
        [self setNavTarBarTitle:@""];
        [self setRightItemsWithContentNames:@[@"设置",@"个人"]];
        [m_BaseView setHeight:self.view.bounds.size.height];
    }
    else
    {
        DIF_HideTabBarAnimation(NO);
        [self setLeftItemWithContentName:@"" imageName:@"ic_back"];
        [self setNavTarBarTitle:@"新工单"];
        [m_BaseView setHeight:self.view.bounds.size.height+50];
    }
    if (m_BaseView)
    {
        [m_BaseView.mj_header beginRefreshing];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.showback = NO;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_DateModel = [JobGridDataModel new];
    m_ReorderType = nil;
    m_ScreenDic = nil;
    DIF_WeakSelf(self)
    m_SearchView = [[JobGridSearchTypeView alloc] initWithSelectBlock:^(ENUM_SEARCH_TYPE type, BOOL isFinish) {
        DIF_StrongSelf
        strongSelf->m_ReorderType = type==ENUM_SEARCH_TYPE_DATE?@"A":@"B";
        if (isFinish)
        {
            [strongSelf->m_CenterBtn setSelected:NO];
            NSString *str = @"全部  ⋀";
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attStr FontAttributeNameWithFont:DIF_DIFONTOFSIZE(8) Range:NSMakeRange(str.length-1, 1)];
            [strongSelf->m_CenterBtn setAttributedTitle:attStr forState:UIControlStateNormal];
            [strongSelf->m_SearchView hide];
            [strongSelf httpRequestEventWithPageNumber:@"0"];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[JobGridTableView alloc] initWithFrame:self.view.bounds
                                                       style:UITableViewStylePlain];
        m_BaseView.dateModel = m_DateModel;
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setReorderBlock:^(NSString *reorder) {
            DIF_StrongSelf
            strongSelf->m_ReorderType = reorder;
        }];
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            JobGridDetailViewController *vc = [strongSelf loadViewController:@"JobGridDetailViewController" hidesBottomBarWhenPushed:YES];
            vc.dataModel = model;
        }];
        [m_BaseView setRefreshBlock:^{
            DIF_StrongSelf
            [strongSelf httpRequestEventWithPageNumber:@"0"];
        }];
        [m_BaseView setLoadMoreBlock:^(NSInteger page) {
            DIF_StrongSelf
            [strongSelf httpRequestEventWithPageNumber:[@(page) stringValue]];
        }];
        [self createTopView];
    }
}

- (void)createTopView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(40))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 0.5)];
    [line setBackgroundColor:DIF_HEXCOLOR(@"c8c7cc")];
    [view addSubview:line];
    
    m_CenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_CenterBtn setFrame:CGRectMake(0, 0, view.width/2, view.height)];
    [m_CenterBtn setCenterX:view.width/2];
    [m_CenterBtn.titleLabel setFont:DIF_DIFONTOFSIZE(15)];
    [m_CenterBtn setTitleColor:DIF_HEXCOLOR(@"333333") forState:UIControlStateNormal];
    NSString *str = @"全部  ⋀";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr FontAttributeNameWithFont:DIF_DIFONTOFSIZE(8) Range:NSMakeRange(str.length-1, 1)];
    [m_CenterBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    [m_CenterBtn addTarget:self action:@selector(headerSearchButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [m_CenterBtn setSelected:NO];
    [m_CenterBtn setBackgroundColor:DIF_HEXCOLOR(@"")];
    [view addSubview:m_CenterBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, view.height, view.height)];
    [rightBtn setRight:DIF_SCREEN_WIDTH-DIF_PX(14)];
    [rightBtn.titleLabel setFont:DIF_DIFONTOFSIZE(15)];
    [rightBtn setTitleColor:DIF_HEXCOLOR(@"333333") forState:UIControlStateNormal];
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [rightBtn addTarget:self
                 action:@selector(screenButtonEvent:)
       forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    [self.view addSubview:view];
}

#pragma mark - HeaderView Button Event

- (void)headerSearchButtonEvent:(UIButton *)btn
{
    btn.selected = !btn.selected;
    NSString *str = btn.selected?@"全部  ⋁":@"全部  ⋀";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr FontAttributeNameWithFont:DIF_DIFONTOFSIZE(8) Range:NSMakeRange(str.length-1, 1)];
    [m_CenterBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    btn.selected?[m_SearchView show]:[m_SearchView hide];
    if (!btn.selected)
    {
        [self httpRequestEventWithPageNumber:@"0"];
    }
}

- (void)screenButtonEvent:(UIButton *)btn
{
    [m_CenterBtn setSelected:NO];
    NSString *str = @"全部  ⋀";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr FontAttributeNameWithFont:DIF_DIFONTOFSIZE(8) Range:NSMakeRange(str.length-1, 1)];
    [m_CenterBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    [m_SearchView hide];
    
    DIF_WeakSelf(self)
    ScreenViewController * vc = [self loadViewController:@"ScreenViewController" hidesBottomBarWhenPushed:YES];
    [vc setBlock:^(NSDictionary *screenDic) {
        DIF_StrongSelf
        strongSelf->m_ScreenDic = screenDic;
    }];
}

- (void)leftBarButtonItemAction:(UIButton *)btn
{
    if (self.showback)
    {
        [DIF_TabBar setSelectedIndex:3];
    }
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    if (btn.tag == 50011)
    {
        [self loadViewController:@"CustomCenterViewController" hidesBottomBarWhenPushed:YES];
    }
    else
    {
        [self loadViewController:@"ConfigServiceHostViewController" hidesBottomBarWhenPushed:YES];
    }
}

#pragma mark - http request
- (void)httpRequestEventWithPageNumber:(NSString *)page
{
    NSMutableDictionary *params = [NSMutableDictionary
                                   dictionaryWithDictionary:@{@"staffId":DIF_CommonCurrentUser.staffId,
                                                              @"wa.state":@"A",
                                                              @"wa.wareaId":DIF_CommonCurrentUser.wareaId,
                                                              @"pageNumber":page,
                                                              @"pageSize":DIF_CommonCurrentUser.pageSize}];
    if (m_ReorderType)
    {
        [params setObject:m_ReorderType forKey:@"wa.order"];
    }
    if (m_ScreenDic.count > 0)
    {
        for (NSString *key in m_ScreenDic.allKeys)
        {
            [params setObject:m_ScreenDic[key] forKey:key];
        }
    }
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestGetGridListWithParameters:params
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             if ([responseModel isKindOfClass:[NSString class]])
             {
                 NSArray *responseArr = [responseModel componentsSeparatedByString:@"TotalCount:"];
                 NSRange range = [responseArr[1] rangeOfString:@"}]"];
                 NSString *TotalCount = [responseArr[1] substringToIndex:range.location];
                 if (TotalCount.integerValue > 0)
                 {
                     id content = [CommonTool dictionaryWithJsonString:[responseArr[0] substringToIndex:[responseArr[0] length]-2]];
                     [strongSelf->m_DateModel setServiceResponseModel:content];
                     [strongSelf->m_BaseView setGridDataArray:strongSelf->m_DateModel.getShowDataModel];
                 }
                 else
                 {
                     [strongSelf->m_BaseView setGridDataArray:@[]];
                 }
             }
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:(NSString*)responseModel];
         }
     }
     FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         [CommonHUD delayShowHUDWithMessage:DIF_HTTP_REQUEST_URL_NULL];         
     }];
}

@end
