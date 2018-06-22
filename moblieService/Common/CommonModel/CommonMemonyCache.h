//
//  CommonMemonyCache.h
//  uavsystem
//
//  Created by jian zhang on 16/8/10.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DIF_MemonyCache_Key

#define DIF_MemonyCache_Key_AppVersion       @"DIF_MemonyCache_Key_AppVersion"    //需求相关地块数据

#define DIF_MemonyCache_Key_PersonInfo                  @"DIF_MemonyCache_Key_PersonInfo"               //个人信息

#endif

@interface CommonMemonyCache : NSObject

@property (class, nonatomic, strong) NSString *userKey;

+ (BOOL)MemoneyCacherWrite:(id)obj KeyValue:(NSString *)key;

+ (id)MemoneyCacherReadWithKeyValue:(NSString *)key;

+ (void)MemoneyCacherRemoveWithKeyValue:(NSString *)key;

+ (void)MemoneyCacherClean;

+ (void)MemoneyCacherCleanExceptForKey:(NSString *)key;

+ (void)WriteToLocation;

+ (void)removeLoactonFile;

+ (void)readFromLocation;

@end
