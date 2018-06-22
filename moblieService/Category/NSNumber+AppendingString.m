//
//  NSNumber+AppendingString.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/2/7.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import "NSNumber+AppendingString.h"

@implementation NSNumber (AppendingString)

- (NSString *)AppendingString:(NSString *)string
{
    NSString *newStr;
    if ([string isKindOfClass:[NSNumber class]])
    {
        string = [(NSNumber *)string stringValue];
    }
    newStr = [(NSNumber *)self stringValue];
    
    newStr = [NSString stringWithFormat:@"%@%@",newStr,string];
    
    return newStr;
}

@end
