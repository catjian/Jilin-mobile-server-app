//
//  CommonPopWarnView.h
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/28.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonPopWarnViewSuccessBlock)(BOOL isClose);

@interface CommonPopWarnView : UIView

+ (CommonPopWarnView *)showPopWarnViewWithTitle:(NSString *)title
                                        Message:(NSString *)message
                                  SuccessButton:(NSString *)success
                                    CloseButton:(NSString *)close
                                     EventBlock:(CommonPopWarnViewSuccessBlock)block;

- (void)closePopWarnView;

@end
