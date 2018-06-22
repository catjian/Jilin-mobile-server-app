//
//  CommonAchieveModelValue.m
//  uavsystem
//
//  Created by jian zhang on 2018/11/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonAchieveModelValue.h"

@implementation CommonAchieveModelValue

+ (id)getClassValueWithClass:(id)objc ValueName:(NSString *)valueN
{
    if (valueN == nil || [valueN isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    id content = nil;
    NSArray *values = [CommonAchieveModelValue getClassVariableNameWihtClassName:NSStringFromClass([objc class])];
    NSString *valueName = [CommonAchieveModelValue formatLoseValueName:valueN];
    if ([valueN rangeOfString:@"_"].location == NSNotFound)
    {
        valueN = [NSString stringWithFormat:@"_%@",valueN];
    }
    if ([values containsObject:valueN])
    {
        NSArray *valueDic = [CommonAchieveModelValue getClassVariableAndTypeWihtClassName:NSStringFromClass([objc class])];
        NSString *type = nil;
        for (NSDictionary *dic in valueDic)
        {
            if ([dic[@"Name"] isEqualToString:valueN])
            {
                type = dic[@"Type"];
                break;
            }
        }
        if (type == nil)
        {
            return nil;
        }
        SEL selector = NSSelectorFromString(valueName);
        IMP imp = [objc methodForSelector:selector];
        if ([type isEqualToString:@"@"] || [type isEqualToString:@"NSString"])
        {
            id (*func)(id, SEL) = (void *)imp;
            content = func(objc, selector);
        }
        else
        {
            if ([type isEqualToString:@"B"])
            {
                BOOL (*func)(id, SEL) = (void *)imp;
                BOOL num = func(objc, selector);
                content = [NSNumber numberWithBool:num];
            }
            else
            {
                int (*func)(id, SEL) = (void *)imp;
                int num = func(objc, selector);
                content = [NSNumber numberWithInt:num];
            }
        }
    }
    return content;
}

+ (NSArray *)getClassVariableNameWihtClassName:(NSString *)className
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList(NSClassFromString(className), &numIvars);
    
    for(int i = 0; i < numIvars; i++)
    {
        Ivar thisIvar = vars[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        [array addObject:name];
    }
    free(vars);
    return array;
}

+ (NSString *)formatLoseValueName:(NSString *)valueN
{
    NSString *valueName = valueN;
    if ([valueN rangeOfString:@"_"].location != NSNotFound && [valueN rangeOfString:@"_"].location == 0)
    {
        valueName = [valueN substringFromIndex:[valueN rangeOfString:@"_"].location+[valueN rangeOfString:@"_"].length];
    }
    return valueName;
}

+ (NSArray *)getClassVariableAndTypeWihtClassName:(NSString *)className
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList(NSClassFromString(className), &numIvars);
    
    for(int i = 0; i < numIvars; i++)
    {
        Ivar thisIvar = vars[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
        NSRange range = [type rangeOfString:@"@\""];
        if (range.location != NSNotFound)
        {
            type = [type substringFromIndex:range.location+range.length];
        }
        range = [type rangeOfString:@"\""];
        if (range.location != NSNotFound)
        {
            type = [type substringToIndex:range.location];
        }
        [array addObject:@{@"Name":name, @"Type":type}];
    }
    free(vars);
    return array;
}

@end
