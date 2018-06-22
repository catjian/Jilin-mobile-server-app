//
//  NSString+ConvertHex.h
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2017/7/28.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_ConvertHex)

- (NSString *)convertHexStrToString;
    
- (NSString *)convertStringToHexStr;

+(NSString *)NSDataToByteTohex:(NSData *)data;

+(NSData *)hexToByteToNSData:(NSString *)str;

- (int)stringToHexInt;
    
@end
