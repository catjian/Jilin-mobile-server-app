//
//  CommonBottomPopView.h
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/21.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonBottomPopViewCloseBlock)(void);

@interface CommonBottomPopView : UIView

@property (nonatomic, copy) CommonBottomPopViewCloseBlock closeBlock;

- (void)showPopView;

- (void)hidePopView;

@end
