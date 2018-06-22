//
//  NSObject+Null.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/2/2.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import "NSObject+Null.h"

@implementation NSObject (isNUll)

- (BOOL)isNull
{
    if (!self || [self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([self isKindOfClass:[NSArray class]])
    {
        return [(NSArray *)self isNull];
    }
    if ([self isKindOfClass:[NSString class]])
    {
        return [(NSArray *)self isNull];
    }
    if ([self isKindOfClass:[NSDictionary class]])
    {
        return [(NSArray *)self isNull];
    }
    return NO;
}

@end
