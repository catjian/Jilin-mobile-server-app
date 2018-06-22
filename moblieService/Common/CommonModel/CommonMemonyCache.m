//
//  CommonMemonyCache.m
//  uavsystem
//
//  Created by jian zhang on 16/8/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonMemonyCache.h"

#ifndef DIF_MemonyCache
#define DIF_MemonyCache [CommonMemonyCache SharedMemonyCache]
#endif

static CommonMemonyCache *cache = nil;

@interface CommonMemonyCache()

@property (nonatomic, strong) NSMutableDictionary *dataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation CommonMemonyCache

static NSString *_userKey = nil;

+ (CommonMemonyCache *)SharedMemonyCache
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[CommonMemonyCache alloc] init];
    });
    return cache;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.dataSource = [NSMutableDictionary dictionary];
        self.dataArray = [NSMutableArray array];
        self.lock = [[NSLock alloc] init];
    }
    return self;
}

+ (void)setUserKey:(NSString *)userKey
{
    _userKey = userKey;
}

+ (NSString *)userKey
{
    return _userKey;
}

+ (BOOL)MemoneyCacherWrite:(id)obj KeyValue:(NSString *)key
{
    if (!obj || !key)
    {
        return NO;
    }
    [DIF_MemonyCache.lock lock];
    [DIF_MemonyCache.dataSource setObject:obj forKey:key];
    [DIF_MemonyCache.lock unlock];
    return YES;
}

+ (id)MemoneyCacherReadWithKeyValue:(NSString *)key
{
    if (!key)
    {
        return nil;
    }
    [DIF_MemonyCache.lock lock];
    id obj = [DIF_MemonyCache.dataSource objectForKey:key];
    [DIF_MemonyCache.lock unlock];
    return obj;
}

+ (void)MemoneyCacherRemoveWithKeyValue:(NSString *)key
{
    if (!key)
    {
        return;
    }
    [DIF_MemonyCache.lock lock];
    [DIF_MemonyCache.dataSource removeObjectForKey:key];
    [DIF_MemonyCache.lock unlock];
}

+ (void)MemoneyCacherClean
{
    [DIF_MemonyCache.lock lock];
    [DIF_MemonyCache.dataSource removeAllObjects];
    [DIF_MemonyCache.lock unlock];
}

+ (void)MemoneyCacherCleanExceptForKey:(NSString *)exceptkey
{
    [DIF_MemonyCache.lock lock];
    for (NSString *key in DIF_MemonyCache.dataSource.allKeys)
    {
        if (![key isEqualToString:exceptkey])
        {
            [DIF_MemonyCache.dataSource removeObjectForKey:key];
        }
    }
    [DIF_MemonyCache.lock unlock];
}

+ (NSDictionary *)rewriteNumberKeyToStringClass:(NSDictionary *)dicObjc
{
    NSMutableDictionary *reDic = [NSMutableDictionary dictionaryWithDictionary:dicObjc];
    for (id key in reDic.allKeys)
    {
        if ([key isKindOfClass:[NSNumber class]]) {
            id objc = reDic[key];
            if ([objc isKindOfClass:[NSDictionary class]])
            {
                [self rewriteNumberKeyToStringClass:objc];
            }
            [reDic removeObjectForKey:key];
            [reDic setObject:objc forKey:[(NSNumber *)key stringValue]];
        }
        else
        {
            id objc = reDic[key];
            if ([objc isKindOfClass:[NSDictionary class]])
            {
                [self rewriteNumberKeyToStringClass:objc];
            }
        }
    }
    return reDic;
}

+ (void)WriteToLocation
{
    [DIF_MemonyCache.lock lock];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *subPath = @"/MemeyCache.plist";
    if (self.userKey && self.userKey.length > 0 && ![[CommonMemonyCache userKey] isEqualToString:@" "]) {
        subPath = [NSString stringWithFormat:@"/%@/MemeyCache.plist",[self.userKey stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    NSString *path = [[paths firstObject] stringByAppendingString:subPath];
//    [DIF_MemonyCache.dataSource writeToFile:path atomically:YES];
    NSMutableDictionary *locDic = [NSMutableDictionary dictionary];
    for (NSString *key in DIF_MemonyCache.dataSource.allKeys)
    {
        id objectValue = DIF_MemonyCache.dataSource[key];
        if ([objectValue isKindOfClass:[NSArray class]])
        {
            NSMutableArray *newVauleArr = [NSMutableArray array];
            for (NSObject *newValue in objectValue)
            {
                if ([newValue.class isSubclassOfClass:[UIImage class]])
                {
                    [newVauleArr addObject:newValue];
                    continue;
                }
                NSDictionary *dic = newValue.mj_keyValues;
                [newVauleArr addObject:dic];
            }
            [locDic setObject:newVauleArr forKey:key];
        }
        else if ([objectValue isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = [(NSObject *)objectValue mj_keyValues];
            [locDic setObject:[self rewriteNumberKeyToStringClass:dic] forKey:key];
        }
        else
        {
            NSDictionary *dic = [(NSObject *)objectValue mj_keyValues];
            [locDic setObject:dic forKey:key];
        }
    }
    NSError *error;
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:locDic
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                                  options:0
                                                                    error:&error];
    
    if(plistData)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path])
        {
            [fileManager createDirectoryAtPath:[path substringToIndex:[path rangeOfString:@"/MemeyCache.plist"].location]
                   withIntermediateDirectories:YES attributes:nil error:nil];
            [plistData writeToFile:path atomically:YES];
        }
        else
        {
            [plistData writeToFile:path atomically:YES];
        }
    }
    else
    {
        DebugLog(@"error = %@",error);
    }
    [DIF_MemonyCache.lock unlock];
}

+ (void)removeLoactonFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *subPath = @"/MemeyCache.plist";
    if (self.userKey && self.userKey.length > 0 && ![[CommonMemonyCache userKey] isEqualToString:@" "]) {
        subPath = [NSString stringWithFormat:@"/%@/MemeyCache.plist",[self.userKey stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    NSString *path = [[paths firstObject] stringByAppendingString:subPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
}

+ (void)readFromLocation
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *subPath = @"/MemeyCache.plist";
    if (self.userKey && self.userKey.length > 0 && ![self.userKey isEqualToString:@" "]) {
        subPath = [NSString stringWithFormat:@"/%@/MemeyCache.plist",[self.userKey stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    NSString *path = [[paths firstObject] stringByAppendingString:subPath];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    if (dic)
    {
        if (DIF_MemonyCache.dataSource.count > 0)
        {
            for (NSString *key in dic.allKeys)
            {
                if (![DIF_MemonyCache.dataSource objectForKey:key])
                {
                    [DIF_MemonyCache.dataSource setObject:dic[key] forKey:key];
                }
            }
        }
        else
        {
            DIF_MemonyCache.dataSource = [NSMutableDictionary dictionaryWithDictionary:dic];
        }
    }
    else
    {
        DIF_MemonyCache.dataSource = [NSMutableDictionary dictionary];
    }
}

@end
