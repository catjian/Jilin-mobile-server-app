//
//  MapCoordinateCollectionHeaderView.m
//  uavsystem
//
//  Created by jian zhang on 16/9/12.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonShowControlPictureCollectionView.h"
#import "AJPhotoBrowserViewController.h"

@interface ShowControlPictureCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation ShowControlPictureCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _button = [CommonCommitButton commitButtonWithFrame:CGRectMake(0,0, DIF_PX(106), DIF_PX(114))
                                                      Title:nil
                                                 TitleColor:nil
                                            BackGroundColor:DIF_BACK_BLUE_COLOR];
        [_button setImage:[UIImage imageNamed:@"icon_index_photo"] forState:UIControlStateNormal];
        [_button setUserInteractionEnabled:NO];
        [self addSubview:_button];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_imageView setHidden:YES];
        [self addSubview:_imageView];
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setFrame:CGRectMake(_imageView.width-24, 0, 24, 24)];
        [_deleteBtn setImage:[UIImage imageNamed:@"icon_map_delete"] forState:UIControlStateNormal];
        [self addSubview:_deleteBtn];
    }
    return self;
}

@end

@interface CommonShowControlPictureCollectionView()

@end

@implementation CommonShowControlPictureCollectionView
{
    NSInteger m_SectionNum;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(DIF_PX(106), DIF_PX(114));
//    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset =  UIEdgeInsetsMake(0, 0, 0, 0);
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self)
    {
        self.ImageArr = [NSMutableArray array];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self registerClass:[ShowControlPictureCollectionCell class] forCellWithReuseIdentifier:@"CELLIDENTIFIER"];
        [self setDelegate:self];
        [self setDataSource:self];
        m_SectionNum = 1;
        [self setScrollEnabled:NO];
    }
    return self;
}

- (void)setImageArr:(NSMutableArray *)ImageArr
{
    if (!ImageArr)
    {
        return;
    }
    _ImageArr = [NSMutableArray arrayWithArray:ImageArr];
    m_SectionNum = _ImageArr.count+1;
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.block)
    {
        self.block((m_SectionNum-1)/5);
    }
    [self setScrollEnabled:(m_SectionNum > 5 ? YES : NO)];
    return m_SectionNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CELLIDENTIFIER";
    ShowControlPictureCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.button setHidden:YES];
    [cell.imageView setHidden:YES];
    [cell.deleteBtn setHidden:YES];
    if (indexPath.row == m_SectionNum-1)
    {
        [cell.button setHidden:NO];
    }
    else
    {
        [cell.imageView setHidden:NO];
        [cell.deleteBtn setHidden:NO];
        if (indexPath.row < self.ImageArr.count)
        {
            UIImage *image = self.ImageArr[indexPath.row];
            [cell.imageView setImage:image CornerRadius:5];
            [cell.deleteBtn addTarget:self
                               action:@selector(ShowControlPictureCollectionCellDeleteButtonAction:)
                     forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.eventBlock)
    {
        self.eventBlock(indexPath.row == m_SectionNum - 1?CommonShowControlPictureCollectionView_Event_Add:CommonShowControlPictureCollectionView_Event_Show);
    }
}

- (void)ShowControlPictureCollectionCellDeleteButtonAction:(id)sender
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[sender superview];
    NSIndexPath *indexP = [self indexPathForCell:cell];
    [self.ImageArr removeObjectAtIndex:indexP.row];
    m_SectionNum--;
    [self reloadData];
    if (self.eventBlock)
    {
        self.eventBlock(CommonShowControlPictureCollectionView_Event_Delete);
    }
}

@end
