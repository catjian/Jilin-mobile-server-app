//
//  NSString+TransformToPinYin.h
//  uavsystem
//
//  Created by lx on 2016/10/19.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TransformToPinYin)


/**
 将汉字转成拼音

 @param chinese 中文

 @return 拼音
 */
+ (NSString *)transformToPinYinWithString:(NSString *)chinese;

@end
