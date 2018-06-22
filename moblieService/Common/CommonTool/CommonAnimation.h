//
//  CommonAnimation.h
//  uavsystem
//
//  Created by zhang_jian on 16/7/8.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ENUM_COMMONANIMATION_TYPE) {
    ENUM_COMMONANIMATION_MOVE,
    ENUM_COMMONANIMATION_SHOCK,
    ENUM_COMMONANIMATION_SCALE,
    ENUM_COMMONANIMATION_SCALERECT
};

typedef NS_ENUM(NSUInteger, ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION) {
    ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION_VERTICAL,
    ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION_HORIZONTAL,
    ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION_DIAGONAL_LEFT,
    ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION_DIAGONAL_RIGHT
};

typedef void(^CommonAnimationStartBlock)(UIView *view);
typedef void(^CommonAnimationFinishBlock)(BOOL isfinish, UIView *view);

@interface CommonAnimation : NSObject

@property (nonatomic, copy) CommonAnimationStartBlock startBlock;
@property (nonatomic, copy) CommonAnimationFinishBlock finishBlock;

+ (CommonAnimation *)sharedCommonAnimation;

+ (void)AnimationRemoveWithView:(UIView *)view AnimationType:(ENUM_COMMONANIMATION_TYPE)type;

/**
 *  移动动画
 *
 *  @param view     动画对象
 *  @param toPoint  目标坐标
 *  @param duration 动画时间
 */
+ (void)AnimationMoveWithView:(UIView *)view
                      ToVaule:(CGPoint)toPoint
                     Duration:(CGFloat)duration;

+ (void)AnimationMoveWithView:(UIView *)view
                      ToVaule:(CGPoint)toPoint
                     Duration:(CGFloat)duration
                  finshiBlock:(CommonAnimationFinishBlock)block;

/**
 *  振荡动画
 *
 *  @param view     动画对象
 *  @param ori      方向
 *  @param length   距离
 *  @param duration 一次动画时间
 *  @param count    动画次数， HUGE_VALF：无限次
 */
+ (void)AnimationShockWithView:(UIView *)view
                   orientation:(ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION)ori
                   ShockLength:(CGFloat)length
                      Duration:(CGFloat)duration
                   RepeatCount:(CGFloat)count;
+ (void)AnimationShockWithView:(UIView *)view
                   orientation:(ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION)ori
                   ShockLength:(CGFloat)length
                      Duration:(CGFloat)duration
                   RepeatCount:(CGFloat)count
                   finshiBlock:(CommonAnimationFinishBlock)block;

/**
 *  缩放动画
 *
 *  @param view     动画对象
 *  @param from     初始倍率
 *  @param to       目标倍率
 *  @param duration 动画时间
 */
+ (void)AnimationScaleWithView:(UIView *)view
                     FromValue:(CGFloat)from
                       ToVaule:(CGFloat)to
                      Duration:(CGFloat)duration;

+ (void)AnimationScaleWithView:(UIView *)view
                     FromValue:(CGFloat)from
                       ToVaule:(CGFloat)to
                      Duration:(CGFloat)duration
                   finshiBlock:(CommonAnimationFinishBlock)block;

/**
 *  根据Rect进行缩放
 *
 *  @param view     动画对象
 *  @param from     初始Rect
 *  @param to       目标Rect
 *  @param duration 动画时间
 */
+ (void)AnimationScaleRectWithView:(UIView *)view
                         FromValue:(CGRect)from
                           ToVaule:(CGRect)to
                          Duration:(CGFloat)duration;

+ (void)AnimationScaleRectWithView:(UIView *)view
                         FromValue:(CGRect)from
                           ToVaule:(CGRect)to
                          Duration:(CGFloat)duration
                       finshiBlock:(CommonAnimationFinishBlock)block;


/**
 透明度动画

 @param view 动画对象
 @param from 初值
 @param to 末值
 @param duration 动画时间
 */
+ (void)AnimationAlphaRectWithView:(UIView *)view
                         FromValue:(CGFloat)from
                           ToVaule:(CGFloat)to
                          Duration:(CGFloat)duration;

+ (void)AnimationAlphaRectWithView:(UIView *)view
                         FromValue:(CGFloat)from
                           ToVaule:(CGFloat)to
                          Duration:(CGFloat)duration
                       finshiBlock:(CommonAnimationFinishBlock)block;


/**
 对texts 第一位数组进行跳动显示到lab

 @param lab 要显示的lab
 @param format 显示格式， 支持float
 @param texts 显示的内容 第一位必须是数字
 @param attributes 富文本属性
 */
+ (void)AnimationLableWithObject:(UILabel *)lab
                      TextFormat:(NSString *)format
                       TextArray:(NSArray <NSString *>*)texts
                  AttributeArray:(NSArray <NSDictionary *>*)attributes;



/**
 旋转动画

 @param view 动画对象
 @param to 旋转角度  （从 0开始)
 @param duration 动画时间
 */
+ (void)AnimationTransformWithView:(UIView *)view
                           ToVaule:(CGFloat)to
                          Duration:(CGFloat)duration;

+ (void)AnimationTransformWithView:(UIView *)view
                           ToVaule:(CGPoint)toPoint
                          Duration:(CGFloat)duration
                       finshiBlock:(CommonAnimationFinishBlock)block;

@end
