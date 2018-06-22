//
//  CommonCommitButton.h
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/23.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonCommitButton : NSObject

+ (UIButton *)commitButtonWithFrame:(CGRect)frame
                              Title:(NSString *)title
                         TitleColor:(NSString *)colorTitle
                    BackGroundColor:(NSString *)colorBG;

@end
