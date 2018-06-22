//
//  UIButton+CircleImage.h
//  CircleImage
//
//  Created by li xun on 16/4/16.
//  Copyright © 2016年 lixun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CircleImage)


-(void)setBackgroundRoundImage:(NSString *)url forStatus:(UIControlState )status placeHolder:(UIImage *)placeHolder cornerRadius:(CGFloat )radius;

@end
