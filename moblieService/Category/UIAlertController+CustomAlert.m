//
//  UIAlertController+CustomAlert.m
//  YuBao
//
//  Created by hok on 10/11/15.
//  Copyright © 2015 hok. All rights reserved.
//

#import "UIAlertController+CustomAlert.h"

@implementation UIAlertController (CustomAlert)

+ (UIAlertController *)alertWithTitle:(NSString *)title
                           andMessage:(NSString *)message
                                 type:(ENUM_AlertType)type
                             andBlock:(void (^)(UIAlertAction *action))block
{
    return [self alertWithTitle:title andMessage:message CancelBtnTitle:@"取消" SuccessBtnTitle:@"确认" type:type andBlock:block];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title
                           andMessage:(NSString *)message
                       CancelBtnTitle:(NSString *)cancelBtn
                      SuccessBtnTitle:(NSString *)successBtn
                                 type:(ENUM_AlertType)type
                             andBlock:(void (^)(UIAlertAction *action))block
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:successBtn
                                                       style:UIAlertActionStyleDefault
                                                     handler:block];
    [alertController addAction:okAction];
    
    if(type == ENUM_AlertType_ConfirmAndCancel)
    {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtn
                                                               style:UIAlertActionStyleCancel
                                                             handler:block];
        [alertController addAction:cancelAction];
    }
    return alertController;
}


@end
