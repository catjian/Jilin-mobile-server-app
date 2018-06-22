//
//  CutomRoundButton.h
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/22.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomRoundButton : UIView

@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) CGFloat shadowBlur;

@end
