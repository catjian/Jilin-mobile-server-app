//
//  NSString+ No2hz.m
//  uavsystem
//
//  Created by jian zhang on 16/9/12.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "NSString+ No2hz.h"

@implementation NSString (NSString__No2hz)

- (BOOL)isAllNumber
{
    NSString* number=@"^[0-9]*$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:self];
}

- (NSString *)No2hz
{
    if (![self isAllNumber])
    {
        return self;
    }
    if ([self isEqualToString:@"10"])
    {
        return @"十";
    }
    NSArray *hzNumArr = @[@"零",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九"];
    NSArray *hzUnitArr = @[@"十",@"百",@"千",@"万",@"亿"];
    NSMutableString *newStr = [NSMutableString string];
    NSInteger i = self.length-1, n = 0, m = 1, count = 0;
    while (YES)
    {
        NSString *one = [self substringWithRange:NSMakeRange(i, 1)];
        NSInteger j = one.integerValue;
        if ((m+count)%9 == 0)
        {
            n = 4;
            count++;
        }
        if (m > 1)
        {
            [newStr insertString:hzUnitArr[n] atIndex:0];
            n++;
        }
        if (self.length != 2 || j != 1 || i != 0)
        {
            [newStr insertString:hzNumArr[j] atIndex:0];
        }
        if (j == 0)
        {
            if (self.length > 2)
            {
                if (newStr.length >= 2)
                {
                    [newStr deleteCharactersInRange:NSMakeRange(1, 1)];
                    if (newStr.length == 1)
                    {
                        [newStr deleteCharactersInRange:NSMakeRange(0, 1)];                        
                    }
                }
                else
                {
                    [newStr deleteCharactersInRange:NSMakeRange(0, 1)];
                }
            }
            else
            {
                [newStr deleteCharactersInRange:NSMakeRange(0, 1)];
            }
        }
        i--;
        m++;
        if (n >= 4)
        {
            n = 0;
        }
        if (i < 0)
        {
            break;
        }
    }
    while (1)
    {
        NSRange range = [newStr rangeOfString:hzNumArr[0]];
        if (range.location != NSNotFound && range.location+range.length < newStr.length)
        {
            NSRange nextRange = [[newStr substringFromIndex:range.location+range.length] rangeOfString:hzNumArr[0]];
            if (nextRange.location != NSNotFound && nextRange.location == 0)
            {
                [newStr deleteCharactersInRange:range];
            }
            else
            {
                break;
            }
        }
        else
        {
            break;
        }
    }
    return newStr;
}

@end

@implementation NSNumber (NSNumber__No2hz)

- (NSString *)No2hz
{
    NSString *str = [NSString stringWithFormat:@"%lu", self.integerValue];
    return [str No2hz];
}

@end
