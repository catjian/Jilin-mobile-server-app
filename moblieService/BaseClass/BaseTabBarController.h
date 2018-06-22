//
//  BaseTabBarController.h
//  uavsystem
//
//  Created by zhang_jian on 16/7/4.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController 

- (instancetype)initWithViewControllers:(NSArray *)viewControllers;

- (void)showTabBarViewControllerIsAnimation:(BOOL)isAnimation;

- (void)hideTabBarViewControllerIsAnimation:(BOOL)isAnimation;

- (CGFloat)getTabBarHeight;

- (BOOL)isHidden;

@end
