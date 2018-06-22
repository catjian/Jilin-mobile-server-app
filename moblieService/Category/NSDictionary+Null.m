//
//  NSDictionary+Null.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/2/2.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import "NSDictionary+Null.h"

@implementation NSDictionary (isNUll)

- (BOOL)isNull
{
    if (!self || self.count <= 0 || [self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return NO;
}

@end

@implementation NSDictionary (VASafeObjectForKey)

-(id)safeObjectForKey:(NSString*) key
{
    id object = [self objectForKey:key];
    if (!object || [object isKindOfClass:[NSNull class]]) {
        object = @"";
    }
    return object;
}

-(NSMutableDictionary *)mutableDeepCopy{
    
    NSMutableDictionary *copyDict = [[NSMutableDictionary alloc]initWithCapacity:self.count];
    
    for (id key in self.allKeys) {
        
        id oneCopy = nil;
        
        id oneValue = [self valueForKey:key];
        
        if ([oneValue respondsToSelector:@selector(mutableDeepCopy)]) {
            
            oneCopy = [oneValue mutableDeepCopy];
            
            //        }else if ([object respondsToSelector:@selector(mutableCopy)]){
            
            //            oneCopy = [object mutableCopy];
            
        }else if ([oneValue respondsToSelector:@selector(copy)]){
            
            oneCopy = [oneValue copy];
            
        }
        
        [copyDict setValue:oneCopy forKey:key];
        
    }
    
    return copyDict;
    
}

@end
