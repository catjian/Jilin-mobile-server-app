//
//  AppDelegate.m
//  moblieService
//
//  Created by zhang_jian on 2018/5/27.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    [self loadWindowRootTabbarViewController];
    [self performSelector:@selector(loadLoginViewController) withObject:nil afterDelay:.5];
    
    [self.window makeKeyAndVisible];
    
    
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
#pragma mark - Notification
    if (@available(iOS 10.0, *))
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              }];
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Custom Function

- (void)loadWindowRootTabbarViewController
{
    NewJobGridViewController *newVC = [[NewJobGridViewController alloc] init];
    BaseNavigationViewController *nav1 = [[BaseNavigationViewController alloc] initWithRootViewController:newVC];
    
    HadJobGridViewController *hadVC = [[HadJobGridViewController alloc] init];
    BaseNavigationViewController *nav2 = [[BaseNavigationViewController alloc] initWithRootViewController:hadVC];
    
    NoticeViewController *noVC = [[NoticeViewController alloc] init];
    BaseNavigationViewController *nav3 = [[BaseNavigationViewController alloc] initWithRootViewController:noVC];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    BaseNavigationViewController *nav4 = [[BaseNavigationViewController alloc] initWithRootViewController:homeVC];

    self.baseTB = [[BaseTabBarController alloc] initWithViewControllers:@[nav1,nav2,nav3,nav4]];
    
    [self.window setRootViewController:self.baseTB];
    [self.baseTB setSelectedIndex:3];
}

- (void)loadLoginViewController
{
    LoginViewController *vc = [[LoginViewController alloc] init];
    BaseNavigationViewController *navc = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
    [self.window.rootViewController presentViewController:navc animated:YES completion:nil];
}

- (void)getHaveNewGridEventByTimer
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60*5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getHaveNewGridEventByTimer];
    });
    [DIF_CommonHttpAdapter
     httpRequestCheckNewByMobileWithParameters:nil
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             NSDictionary *responsDic = responseModel[0];
             NSInteger numall = [responsDic[@"numall"] integerValue];
             if (numall > 0)
             {
                 [NotificationTool sendNotification];
             }
         }
     }
     FailedBlcok:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
}
#endif

@end
