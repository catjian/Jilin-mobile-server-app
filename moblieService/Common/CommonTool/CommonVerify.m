//
//  YuLoginRegisterUtilities.m
//  HuLaQuan
//
//  Created by hok on 1/6/16.
//  Copyright © 2018 Jianghao. All rights reserved.
//

#import "CommonVerify.h"

@implementation CommonVerify

/**
 *  Check Email String Valid
 *
 *  @param email email Address
 *
 *  @return email string is valid or not
 */
+ (BOOL) isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  Check Mobile Number String
 *
 *  @param mobileNum phone
 *
 *  @return mobile number is valid or not
 */

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length > 0) {
        //   NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        NSString * MOBILE = @"^((13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9]))\\d{8}$";
        
        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
        NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
        NSString * CT = @"^1((77|33|53|8[09])[0-9]|349)\\d{7}$";
        // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        if (([regextestmobile evaluateWithObject:mobileNum] == YES)
            || ([regextestcm evaluateWithObject:mobileNum] == YES)
            || ([regextestct evaluateWithObject:mobileNum] == YES)
            || ([regextestcu evaluateWithObject:mobileNum] == YES))
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
    
}

/**
 *  Check IP String
 *
 *  @param host IP Address
 *
 *  @return host string is ip or not
 */
+ (BOOL) isIPHost:(NSString *)host
{
    NSString *hostRegex = @"^(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])$";
    NSPredicate *hostTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", hostRegex];
    return [hostTest evaluateWithObject:host];
}

+ (BOOL) verifyPasswod:(NSString *)password
{
    NSString *hostRegex = @"[0-9]{6,16}";
    NSPredicate *hostTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", hostRegex];
    return [hostTest evaluateWithObject:password];
}

+(BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
//                                    if (0x0030 <= high && high <= 0x0039){
//                                        returnValue = YES;
//                                    }
                                    if (0x0023 == high || high == 0x002a || high == 0x203c || high == 0x2049){
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

+(BOOL)stringIsRangingString:(NSString *)stringA :(NSString *)stringB
{
    NSString *stringLong = (stringA.length >= stringB.length?stringA:stringB);
    NSString *stringShort = (stringA.length < stringB.length?stringA:stringB);
    stringLong= [stringLong substringToIndex:stringShort.length-1];
    stringShort= [stringShort substringToIndex:stringShort.length-1];
    return !([stringLong rangeOfString:stringShort].location == NSNotFound);
}
@end
