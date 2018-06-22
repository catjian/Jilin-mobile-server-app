//
//  NotificationTool.m
//  IntelligentMedicineBox
//
//  Copyright © 2017年 zhangjian. All rights reserved.
//

#import "NotificationTool.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@implementation NotificationTool

+(void)sendNotification
{
    [self sendNotification:@"新工单提醒" pushID:@"1" CustomData:@{}];
}

+ (void)sendNotification:(NSString *)message
                  pushID:(NSString *)pushID
              CustomData:(NSDictionary *)customData
{
	NSString *title = @"吉林客服移动客服";
	if (@available(iOS 10.0, *))
    {
		UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if(granted)
                                  {
                                      NSLog(@"授权成功");
                                  }
                              }];
		UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
		content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
		content.body = [NSString localizedUserNotificationStringForKey:message arguments:nil];
		content.badge = [NSNumber numberWithInteger:1];
		content.sound = [UNNotificationSound defaultSound];
		if (pushID) {
            content.userInfo = @{@"pushID" : pushID,@"customData" : customData};
		}
		UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
													  triggerWithTimeInterval:1.0f repeats:NO];
		UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"id"
																			  content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter]
         addNotificationRequest:request
         withCompletionHandler:^(NSError * _Nullable error) {
            if(error)
            {
                NSLog(@"%@",error);
            }
        }];
	} else {
		UILocalNotification *localNote = [[UILocalNotification alloc] init];
		localNote.alertTitle = title;
		localNote.alertBody = message;
		localNote.soundName = UILocalNotificationDefaultSoundName;
        localNote.applicationIconBadgeNumber = 1;
		if (pushID) {
            localNote.userInfo = @{@"pushID" : pushID,@"customData" : customData};
		}
		[[UIApplication sharedApplication] scheduleLocalNotification:localNote];
	}
}


@end
