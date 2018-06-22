//
//  MapCoordinateCollectionHeaderView.h
//  uavsystem
//
//  Created by jian zhang on 16/9/12.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CommonShowControlPictureCollectionView_Event) {
    CommonShowControlPictureCollectionView_Event_Add = 0,
    CommonShowControlPictureCollectionView_Event_Show,
    CommonShowControlPictureCollectionView_Event_Delete
};

typedef void(^CommonShowControlPictureCollectionViewBlock)(NSInteger lineNum);
typedef void(^CommonShowControlPictureCollectionViewEventBlock)(CommonShowControlPictureCollectionView_Event);

@interface CommonShowControlPictureCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) CommonShowControlPictureCollectionViewBlock block;
@property (nonatomic, copy) CommonShowControlPictureCollectionViewEventBlock eventBlock;
@property (nonatomic, strong) NSMutableArray *ImageArr;

@end
