//
//  HomeBaseView.m
//  moblieService
//
//  Created by zhang_jian on 2018/5/30.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "HomeBaseView.h"
#import "HomeContentCell.h"

@interface HomeBaseView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation HomeBaseView
{
    UILabel *m_UserInfoLab;
    UICollectionView *m_ContentView;
    NSArray<NSArray *> *m_ContentArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_ContentArr = @[@[@"新工单",@"已接工单"],
                       @[@"公告",@"考核",@"信息补录",@"异网用户"],
                       @[@"上门拜访量",@"客户保有率",@"客户流失率",@"客户增长率",@"及时付费率"]];
        UIView *topView = [self createTopView];
        [self createCollectionViewWithTopView:topView];
    }
    return self;
}

- (UILabel *)userInfoLab
{
    if (!m_UserInfoLab)
    {
        m_UserInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(14), DIF_PX(12), self.width-DIF_PX(14*2), DIF_PX(18))];
        [m_UserInfoLab setBackgroundColor:DIF_HEXCOLOR(@"")];
        [m_UserInfoLab setFont:DIF_DIFONTOFSIZE(12)];
        [m_UserInfoLab setTextColor:DIF_HEXCOLOR(@"4a4a4a")];
    }
    return m_UserInfoLab;
}

- (void)refreshUserInfo
{
    if(m_UserInfoLab)
    {        
        [m_UserInfoLab setText:[NSString stringWithFormat:@"姓名：%@   部门：%@  工号：%@",DIF_CommonCurrentUser.userName,DIF_CommonCurrentUser.wareaName,DIF_CommonCurrentUser.staffId]];
    }
}

- (UIView *)createTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, DIF_PX(40))];
    [topView setBackgroundColor:DIF_HEXCOLOR(@"")];
    [topView addSubview:[self userInfoLab]];
    [self addSubview:topView];
    return topView;
}

- (void)createCollectionViewWithTopView:(UIView *)topView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    m_ContentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, topView.bottom, self.width, self.height)
                                       collectionViewLayout:flowLayout];
    [m_ContentView setContentInset:UIEdgeInsetsMake(0, 0, 48, 0)];
    [m_ContentView registerClass:[HomeContentCell class] forCellWithReuseIdentifier:@"CELLIDENTIFIER"];
    [m_ContentView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [m_ContentView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:m_ContentView];
    [m_ContentView setDelegate:self];
    [m_ContentView setDataSource:self];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section)
    {
        case 1:
            return 4;
        case 2:
            return 5;
        default:
            return 2;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CELLIDENTIFIER";
    HomeContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *contentTitle = m_ContentArr[indexPath.section][indexPath.row];
    [cell.titleLab setText:contentTitle];
    [cell.imageView setImage:[UIImage imageNamed:contentTitle]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(14), DIF_PX(16), DIF_PX(100), DIF_PX(24))];
        [subTitle setTextColor:DIF_HEXCOLOR(@"#000000")];
        [subTitle setFont:DIF_DIFONTOFSIZE(17)];
        [reusableview addSubview:subTitle];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(14), 0, self.width-DIF_PX(14*2), 0.5)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"c8c7cc")];
        [reusableview addSubview:line];
        switch (indexPath.section)
        {
            case 1:
            {
                [subTitle setText:@"信息"];
            }
                break;
            case 2:
            {
                [subTitle setText:@"数据"];
            }
                break;
            default:
            {
                [subTitle setText:@"工单"];
                [line setHidden:YES];
            }
                break;
        }
    }
    return reusableview;
}

#pragma mark - UICollecrtionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            BaseNavigationViewController *navc = DIF_TabBar.viewControllers[indexPath.row];
            BaseViewController *vc = navc.visibleViewController;
            vc.showback = YES;
            [DIF_TabBar setSelectedIndex:indexPath.row];
        }
            return;
        case 1:
        {
            if (indexPath.row == 0)
            {
                [DIF_TabBar setSelectedIndex:2];
                return;
            }
        }
            break;
        default:
            break;
    }
    [CommonAlertView showAlertViewOneBtnWithTitle:@"提示" Message:@"敬请期待！"
                                      ButtonTitle:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widht = (DIF_SCREEN_WIDTH-5*DIF_PX(30))/4;
    return CGSizeMake(widht, widht+DIF_PX(6*2+17*2));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(DIF_PX(0), DIF_PX(30), DIF_PX(0), DIF_PX(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(56));
}

@end
