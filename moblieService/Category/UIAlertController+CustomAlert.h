//
//  UIAlertController+CustomAlert.h
//  YuBao
//
//  Created by hok on 10/11/15.
//  Copyright © 2015 hok. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertBlock)(UIAlertAction *action);

typedef NS_ENUM(NSUInteger, ENUM_AlertType) {
    ENUM_AlertType_ConfirmAlert,
    ENUM_AlertType_ConfirmAndCancel,
};
@interface UIAlertController (CustomAlert)

+ (UIAlertController *)alertWithTitle:(NSString *)title
                           andMessage:(NSString *)message
                                 type:(ENUM_AlertType)type
                             andBlock:(void (^)(UIAlertAction *action))block;

+ (UIAlertController *)alertWithTitle:(NSString *)title
                           andMessage:(NSString *)message
                       CancelBtnTitle:(NSString *)cancelBtn
                      SuccessBtnTitle:(NSString *)successBtn
                                 type:(ENUM_AlertType)type
                             andBlock:(void (^)(UIAlertAction *action))block;

@end
