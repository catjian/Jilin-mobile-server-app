//
//  GridTailViewController.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "GridTailViewController.h"
#import "GridTailTableView.h"

@interface GridTailViewController ()

@end

@implementation GridTailViewController
{
    GridTailTableView *m_BaseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"工单轨迹"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[GridTailTableView alloc] initWithFrame:self.view.bounds
                                                        style:UITableViewStylePlain];
        m_BaseView.dataArray = self.gridTailArr;
        [self.view addSubview:m_BaseView];
    }
}

- (void)setGridTailArr:(NSArray *)gridTailArr
{
    if (gridTailArr && gridTailArr.count > 0)
    {
        NSMutableArray *modelArr = [NSMutableArray array];
        modelArr = [GridTailModel mj_objectArrayWithKeyValuesArray:gridTailArr];
        _gridTailArr = modelArr;
    }
}

@end
