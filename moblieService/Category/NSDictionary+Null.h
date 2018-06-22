//
//  NSDictionary+Null.h
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/2/2.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (isNUll)

- (BOOL)isNull;

@end

@interface NSDictionary (VASafeObjectForKey)

-(id)safeObjectForKey:(NSString*) key;

-(NSMutableDictionary *)mutableDeepCopy;

@end
