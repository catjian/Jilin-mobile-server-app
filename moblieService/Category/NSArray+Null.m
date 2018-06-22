//
//  NSArray+Null.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/2/2.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import "NSArray+Null.h"

@implementation NSArray (isNUll)

- (BOOL)isNull
{
    if (!self || self.count <= 0 || [self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return NO;
}
@end
