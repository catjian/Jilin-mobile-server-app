//
//  BaseNavigationViewController.m
//  uavsystem
//
//  Created by zhang_jian on 2018/9/27.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController


+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    NSMutableDictionary *titleDictionary = [NSMutableDictionary dictionary];
	titleDictionary[NSForegroundColorAttributeName] = [CommonTool colorWithHexString:@"#25313F" Alpha:1.0];
	titleDictionary[NSFontAttributeName] =  [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    [bar setTitleTextAttributes:titleDictionary];
}

- (void)viewDidLoad
{
    [super viewDidLoad]; 
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
