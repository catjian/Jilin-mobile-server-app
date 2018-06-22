//
//  CommonAlertView.m
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/17.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "CommonAlertView.h"

@implementation CommonAlertView

+ (void)showAlertViewOneBtnWithTitle:(NSString *)title Message:(NSString *)message ButtonTitle:(NSString *)btnTitle
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title
                                                                      message:message
                                                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:(btnTitle?btnTitle:@"确定")
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertCon addAction:cancelAction];
    [DIF_APPDELEGATE.window.rootViewController presentViewController:alertCon animated:YES completion:nil];
}

+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      Message:(NSString *)message
                                 NormalButton:(NSString *)normalTitle
                                 CancelButton:(NSString *)cancelTitle
                                 NormalHander:(void (^)(UIAlertAction *action))handler
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title
                                                                      message:message
                                                               preferredStyle:UIAlertControllerStyleAlert];
    if (normalTitle)
    {
        UIAlertAction *normalAction = [UIAlertAction actionWithTitle:normalTitle
                                                               style:UIAlertActionStyleDefault
                                                             handler:handler];
        [alertCon addAction:normalAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:(cancelTitle?cancelTitle:@"取消")
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertCon addAction:cancelAction];
    return alertCon;
}


@end
