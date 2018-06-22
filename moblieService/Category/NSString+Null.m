//
//  NSString+Null.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/1/27.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import "NSString+Null.h"

@implementation NSString (isNUll)

- (BOOL)isNull
{
    if (!self || self.length == 0 || [self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return NO;
}
@end
