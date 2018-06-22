//
//  CommonTool.h
//  uavsystem
//
//  Created by zhang_jian on 16/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTool : NSObject

+(UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha;

+ (UIView *)traverseSubView:(UIView *)view;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIView *)backViewWithFrame:(CGRect)frame ColorHexValue:(NSString *)color;

+ (NSURL *)urlWithString:(NSString *)path;

+ (NSString *)stringFromFormatUrl:(NSURL *)url;

+ (CGFloat)scaleImageSizeWithBaseSize:(CGSize)baseSize ImageSize:(CGSize)imageSize;

+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;

+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;

+ (void)addWindowPopView:(UIView *)popView;

+ (NSString *)writeToLoactionFile:(NSString *)content FileName:(NSString *)fileName;

+ (id)dictionaryWithJsonString:(NSString *)jsonString;

@end
