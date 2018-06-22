//
//  CommonPageControlView.h
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/4/8.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonPageControlViewSelectBlock)(NSInteger);
@protocol CommonPageControlViewDelegate <NSObject>

@optional
- (void)selectedIndex:(NSInteger)index;

@end

@interface CommonPageControlView : UIView

@property (nonatomic,weak) id<CommonPageControlViewDelegate> delegate;
@property (nonatomic, copy) CommonPageControlViewSelectBlock selectBlock;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles;

@end
