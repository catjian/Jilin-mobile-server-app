//
//  UIImage+ConvertBase64.h
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2017/8/6.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_ConvertBase64)

+ (NSString *)imageConvertToBase64:(UIImage *)image;

+ (UIImage *)imageConvertFromBase64:(NSString *)baseStr;

@end
