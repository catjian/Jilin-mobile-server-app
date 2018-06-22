//
//  UIImageView+CircleImage.m
//  CircleImage
//
//  Created by li xun on 16/4/15.
//  Copyright © 2016年 lixun. All rights reserved.
//

#import "UIImageView+CircleImage.h"
#import "UIImage+CornerRadius.h"
#import <UIImageView+WebCache.h>


@implementation UIImageView (CircleImage)


- (void)setRoundImageWithURL:(NSString *)url placeHoder:(UIImage *)placeHoder CornerRadius:(CGFloat )radius;
{
    //将合成后的图片缓存起来
    NSString *annoImageURL = url;
    NSString *annoImageCacheURL = [annoImageURL stringByAppendingString:@"cache"];
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:annoImageCacheURL];
    if ( cacheImage )
    {
      
        self.image = cacheImage;
    }
    else
    {
         __weak typeof (self)weakSelf =self;
        [weakSelf sd_setImageWithURL:[NSURL URLWithString:annoImageURL]
                     placeholderImage:placeHoder
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                
                                __strong typeof (weakSelf)strongSelf = weakSelf;
                                
                                if (!error)
                                {
                                    UIImage *circleImage = [image ImageCornerRadius:radius];
                                    
                                    strongSelf.image = circleImage;
                                    
                                    [[SDImageCache sharedImageCache] storeImage:circleImage forKey:annoImageCacheURL completion:^{
                                        
                                    }];
                                }
                            }];
    }
}

@end
