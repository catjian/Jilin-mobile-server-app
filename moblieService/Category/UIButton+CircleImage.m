//
//  UIButton+CircleImage.m
//  CircleImage
//
//  Created by li xun on 16/4/16.
//  Copyright © 2016年 lixun. All rights reserved.
//

#import "UIButton+CircleImage.h"
#import "UIImage+CornerRadius.h"
#import <UIButton+WebCache.h>

@implementation UIButton (CircleImage)



-(void)setBackgroundRoundImage:(NSString *)url forStatus:(UIControlState )status placeHolder:(UIImage *)placeHolder cornerRadius:(CGFloat )radius

{
    //将合成后的图片缓存起来
    NSString *annoImageURL = url;
    NSString *annoImageCacheURL = [annoImageURL stringByAppendingString:@"cache"];
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:annoImageCacheURL];
    if ( cacheImage )
    {
        
        [self setBackgroundImage:cacheImage forState:status];
    }
    else
    {
        __weak typeof (self)weakSelf =self;
        
        [weakSelf sd_setImageWithURL:[NSURL URLWithString:annoImageCacheURL] forState:status completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
           __strong typeof (weakSelf)strongSelf = weakSelf;
            
            if (!error)
            {
                UIImage *circleImage = [image ImageCornerRadius:radius];
                [strongSelf setBackgroundImage:circleImage forState:status];
                
                 [[SDImageCache sharedImageCache] storeImage:circleImage forKey:annoImageCacheURL completion:^{
                     
                 }];
                
                }
            
        }];
    }

}




@end
