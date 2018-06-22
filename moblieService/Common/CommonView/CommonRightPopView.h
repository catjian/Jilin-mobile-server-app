//
//  CommonRightPopView.h
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/18.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonRightPopViewHideBlock)(void);

@interface CommonRightPopView : UIView

@property (nonatomic, copy) CommonRightPopViewHideBlock hideBlock;

- (void)showPopView;

- (void)hidePopView;

@end
