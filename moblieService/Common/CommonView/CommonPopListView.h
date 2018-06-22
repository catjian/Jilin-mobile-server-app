//
//  CommonPopListView.h
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/19.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonPopListViewSelectBlock)(id,NSIndexPath *);
typedef void(^CommonPopListViewHeaderBlock)(void);
typedef void(^CommonPopListViewFooterBlock)(void);
typedef void(^CommonPopListViewCloseBlock)(void);


@interface CommonPopListView : UIView

+ (CommonPopListView *)showPopListViewWithHeaderTitle:(NSString *)title
                                          FooterTitle:(NSString *)message
                                          SelectBlock:(CommonPopListViewSelectBlock)selectBlock
                                          HeaderBlock:(CommonPopListViewHeaderBlock)headerBlock
                                          FooterBlock:(CommonPopListViewFooterBlock)footerBlock
                                           CloseBlock:(CommonPopListViewCloseBlock)closeBlock;

- (BaseTableView *)getListView;

- (void)loadListDatas:(NSArray *)datas
          UseCellName:(NSString *)cellName
           CellHeight:(CGFloat)cellHeight;

- (void)closePopListView;

@end
