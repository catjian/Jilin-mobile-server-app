//
//  CommonAlertView.h
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/17.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonAlertView : NSObject

+ (void)showAlertViewOneBtnWithTitle:(NSString *)title Message:(NSString *)message ButtonTitle:(NSString *)btnTitle;

+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      Message:(NSString *)message
                                 NormalButton:(NSString *)normalTitle
                                 CancelButton:(NSString *)cancelTitle
                                 NormalHander:(void (^)(UIAlertAction *action))handler;

@end
