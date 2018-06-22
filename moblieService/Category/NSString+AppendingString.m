//
//  NSString+AppendingString.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/2/7.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import "NSString+AppendingString.h"

@implementation NSString (AppendingString)

- (NSString *)AppendingString:(NSString *)string
{
    NSString *newStr;
    if ([string isKindOfClass:[NSNumber class]])
    {
        string = [(NSNumber *)string stringValue];
    }
    if ([self isKindOfClass:[NSNumber class]])
    {
        newStr = [(NSNumber *)self stringValue];
    }
    else
    {
        newStr = self;
    }
    
    newStr = [NSString stringWithFormat:@"%@%@",newStr,string];
    
    return newStr;
}

@end
