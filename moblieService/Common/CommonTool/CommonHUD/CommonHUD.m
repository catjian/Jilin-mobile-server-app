//
//  CommonHUD.m
//  uavsystem
//
//  Created by jian zhang on 16/8/20.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonHUD.h"
#import <FLAnimatedImage.h>
@implementation CommonHUD

+ (void)hideHUD
{
//    dispatch_sync(dispatch_get_main_queue(), ^{
//    });
    [self performSelectorOnMainThread:@selector(hideHUDMainQueue:) withObject:@(YES) waitUntilDone:NO];
}

+ (void)hideHUDMainQueue:(NSNumber *)isAnimation
{
    [MBProgressHUD hideHUDForView:DIF_KeyWindow animated:isAnimation.boolValue];
}

+ (void)hideHUDAnimation:(BOOL)isAnimation
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUDForView:DIF_KeyWindow animated:isAnimation];
//    });
    [self performSelectorOnMainThread:@selector(hideHUDMainQueue:) withObject:@(isAnimation) waitUntilDone:NO];
}

+ (MBProgressHUD *)showHUD
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:DIF_KeyWindow];
    if (!hud)
    {
        [hud.label setTextColor:[UIColor whiteColor]];
        [hud.detailsLabel setTextColor:[UIColor whiteColor]];
        [hud.detailsLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [hud.detailsLabel setNumberOfLines:0];
        hud = [MBProgressHUD showHUDAddedTo:DIF_KeyWindow animated:YES];
        hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.6];
        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    }
    return hud;
}

+ (MBProgressHUD *)HUDView
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:DIF_KeyWindow];
    if (!hud)
    {
        [hud.label setTextColor:[UIColor whiteColor]];
        [hud.detailsLabel setTextColor:[UIColor whiteColor]];
        [hud.detailsLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [hud.detailsLabel setNumberOfLines:0];
        hud = [MBProgressHUD showHUDAddedTo:DIF_KeyWindow animated:YES];
        hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.6];
        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    }
    return hud;
}

+ (void)showHUDWithMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self showHUD];
        [hud.label setText:message];
        [hud.label setTextColor:[UIColor whiteColor]];
    });
}

+ (void)delayShowHUDWithMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self showHUD].label setText:message];
        [[self showHUD].label setTextColor:[UIColor whiteColor]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUD];
        });
    });
}

+ (void)delayShowHUDWithMessage:(NSString *)message delayTime:(NSTimeInterval)interval
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self showHUD].label setText:message];
        [[self showHUD].label setTextColor:[UIColor whiteColor]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUD];
        });
    });
}

@end
