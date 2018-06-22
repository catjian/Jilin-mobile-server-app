//
//  AJPhotoBrowserViewController.h
//  AJPhotoBrowser
//
//  Created by AlienJunX on 16/2/15.
//  Copyright (c) 2015 AlienJunX
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>

@class AJPhotoBrowserViewController;
@protocol AJPhotoBrowserDelegate <NSObject>
@optional
/**
 *  删除照片
 *
 */
- (void)photoBrowser:(AJPhotoBrowserViewController *)vc deleteWithIndex:(NSInteger)index;

/**
 *  完成
 *
 */
- (void)photoBrowser:(AJPhotoBrowserViewController *)vc didDonePhotos:(NSArray *)photos;
@end

@interface AJPhotoBrowserViewController : UIViewController

@property (weak, nonatomic) id<AJPhotoBrowserDelegate> delegate;

/**
 *  初始化
 */
- (instancetype)initWithPhotos:(NSArray *)photos;


/**
 *  初始化
 *
 */
- (instancetype)initWithPhotos:(NSArray *)photos index:(NSInteger)index;


/**
 隐藏删除按钮
 */
- (void)hideDeleteButton;

@end
