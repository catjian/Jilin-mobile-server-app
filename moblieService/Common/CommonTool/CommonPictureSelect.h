//
//  CommonPictureSelect.h
//  uavsystem
//
//  Created by zhang_jian on 16/7/7.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonPictureSelectResponse)(UIImage *image);

@interface CommonPictureSelect : UIView

+ (CommonPictureSelect *)sharedPictureSelect;

- (void)showWithViewController:(UIViewController *)vc ResponseBlock:(CommonPictureSelectResponse)block;

- (void)hide;

@end
