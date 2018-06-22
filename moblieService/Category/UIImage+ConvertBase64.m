//
//  UIImage+ConvertBase64.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2017/8/6.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import "UIImage+ConvertBase64.h"

@implementation UIImage (UIImage_ConvertBase64)

+ (NSString *)imageConvertToBase64:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, .1);
    return [NSString stringWithFormat:@"data:image/jpeg;base64,%@", [imageData base64EncodedStringWithOptions:0]];
}

+ (UIImage *)imageConvertFromBase64:(NSString *)baseStr
{
    if (!baseStr || baseStr.isNull)
    {
        return nil;
    }
    NSRange range = [baseStr rangeOfString:@"base64"];
    if (range.location != NSNotFound)
    {
        baseStr = [baseStr substringFromIndex:range.location+range.length];
    }
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64EncodedString:baseStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    //NSLog(@"===Decoded image size: %@", NSStringFromCGSize(_decodedImage.size));
    return _decodedImage;
}

@end
