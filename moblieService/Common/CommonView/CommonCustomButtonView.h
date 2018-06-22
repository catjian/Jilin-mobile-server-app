//
//  CommonCustomButtonView.h
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/22.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CustomButtonTouchEvent)(id,id);

@interface CommonCustomButtonView : UIView

@property (nonatomic, copy) CustomButtonTouchEvent eventBlock;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) CGFloat shadowBlur;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *heightColor;
@property (nonatomic, strong) NSString *smallIconName;

- (instancetype)initWithViewFrame:(CGRect)frame
                      ButtonFrame:(CGRect)btnFrame
                      inSmallIcon:(NSString *)iconName
                      ButtonTitle:(NSString *)title;

- (void)ButtonTitleWithContent:(NSString *)content;

- (void)ButtonUnitBeSet:(NSString *)unit;

- (UIView *)getButtonView;

- (void)ButtonIconWithImage:(UIImage *)icon;

@end
