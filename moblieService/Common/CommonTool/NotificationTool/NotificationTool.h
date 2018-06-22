//
//  NotificationTool.h
//  IntelligentMedicineBox
//
//  Created by lixun on 2017/12/23.
//  Copyright © 2017年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationTool : NSObject

+(void)sendNotification;

+ (void)sendNotification:(NSString *)message
                  pushID:(NSString *)pushID
              CustomData:(NSDictionary *)customData;

@end

NS_ASSUME_NONNULL_END
