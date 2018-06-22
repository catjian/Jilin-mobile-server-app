//
//  CommonAnimation.m
//  uavsystem
//
//  Created by zhang_jian on 16/7/8.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonAnimation.h"

static CommonAnimation *animation = nil;

NSString *const objectKey = @"CommonAnimation_OBJECT";
NSString *const nameKey = @"CommonAnimation_NAME";

@implementation CommonAnimation

+ (CommonAnimation *)sharedCommonAnimation
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animation = [CommonAnimation new];
    });
    return animation;
}

+ (void)AnimationRemoveWithView:(UIView *)view AnimationType:(ENUM_COMMONANIMATION_TYPE)type
{
    for (UIView *subView in view.subviews)
    {
        [CommonAnimation AnimationRemoveWithView:subView AnimationType:type];
    }
    NSString *key = @"CommonAnimationMove";
    switch (type)
    {
        case ENUM_COMMONANIMATION_MOVE:
            key = @"CommonAnimationMove";
            break;
        case ENUM_COMMONANIMATION_SHOCK:
            key = @"CommonAnimationShock";
            break;
        case ENUM_COMMONANIMATION_SCALE:
            key = @"CommonAnimationScale";
            break;
        case ENUM_COMMONANIMATION_SCALERECT:
        default:
            key = @"CommonAnimationScaleRect";
            break;
    }
    [view.layer removeAnimationForKey:key];
}

+ (void)AnimationMoveWithView:(UIView *)view
                      ToVaule:(CGPoint)toPoint
                     Duration:(CGFloat)duration
                  finshiBlock:(CommonAnimationFinishBlock)block
{
    [CommonAnimation sharedCommonAnimation].finishBlock = block;
    [self AnimationMoveWithView:view ToVaule:toPoint Duration:duration];
}

+ (void)AnimationMoveWithView:(UIView *)view
                      ToVaule:(CGPoint)toPoint
                     Duration:(CGFloat)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:(id)[CommonAnimation sharedCommonAnimation]];
    [animation setDuration:duration];
    [animation setAutoreverses:NO];
    [animation setCumulative:NO];
    animation.fromValue = [NSValue valueWithCGPoint:view.center];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    [animation setDelegate:(id)[CommonAnimation sharedCommonAnimation]];
    [animation setValue:view forKey:objectKey];
    [animation setValue:@"CommonAnimationMove" forKey:nameKey];
    [view.layer addAnimation:animation forKey:@"CommonAnimationMove"];
}

+ (void)AnimationShockWithView:(UIView *)view
                   orientation:(ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION)ori
                   ShockLength:(CGFloat)length
                      Duration:(CGFloat)duration
                   RepeatCount:(CGFloat)count
                   finshiBlock:(CommonAnimationFinishBlock)block
{
    [CommonAnimation sharedCommonAnimation].finishBlock = block;
    [self AnimationShockWithView:view orientation:ori ShockLength:length Duration:duration RepeatCount:count];
}

+ (void)AnimationShockWithView:(UIView *)view
                   orientation:(ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION)ori
                   ShockLength:(CGFloat)length
                      Duration:(CGFloat)duration
                   RepeatCount:(CGFloat)count
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:(id)[CommonAnimation sharedCommonAnimation]];
    [animation setDuration:duration];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:count];
    animation.fromValue = [NSValue valueWithCGPoint:view.layer.position];
    CGPoint toPoint = view.layer.position;
    switch (ori)
    {
        case ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION_VERTICAL:
        {
            toPoint.y += length;
        }
            break;
        case ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION_HORIZONTAL:
        {            
            toPoint.x += length;
        }
            break;
        case ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION_DIAGONAL_LEFT:
        {
            toPoint.x += length;
            toPoint.y += length;
        }
            break;
        case ENUM_COMMONANIMATION_ORIENTATION_ORIENTATION_DIAGONAL_RIGHT:
        {
            toPoint.x += length;
            toPoint.y -= length;
        }
            break;
        default:
            break;
    }
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    [view.layer addAnimation:animation forKey:@"CommonAnimationShock"];
}

+ (void)AnimationScaleWithView:(UIView *)view
                     FromValue:(CGFloat)from
                       ToVaule:(CGFloat)to
                      Duration:(CGFloat)duration
                   finshiBlock:(CommonAnimationFinishBlock)block
{
    [CommonAnimation sharedCommonAnimation].finishBlock = block;
    [self AnimationScaleWithView:view FromValue:from ToVaule:to Duration:duration];
}

+ (void)AnimationScaleWithView:(UIView *)view
                     FromValue:(CGFloat)from
                       ToVaule:(CGFloat)to
                      Duration:(CGFloat)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation setDuration:duration];
    [animation setAutoreverses:NO];
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    animation.fillMode = kCAFillModeForwards;
    [animation setDelegate:(id)[CommonAnimation sharedCommonAnimation]];
    [animation setValue:view forKey:objectKey];
    [animation setValue:@"CommonAnimationScale" forKey:nameKey];
    [view.layer addAnimation:animation forKey:@"CommonAnimationScale"];
}

+ (void)AnimationScaleRectWithView:(UIView *)view
                         FromValue:(CGRect)from
                           ToVaule:(CGRect)to
                          Duration:(CGFloat)duration
                       finshiBlock:(CommonAnimationFinishBlock)block
{
    [CommonAnimation sharedCommonAnimation].finishBlock = block;
    [self AnimationScaleRectWithView:view FromValue:from ToVaule:to Duration:duration];
}

+ (void)AnimationScaleRectWithView:(UIView *)view
                         FromValue:(CGRect)from
                           ToVaule:(CGRect)to
                          Duration:(CGFloat)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    [animation setDuration:duration];
    [animation setAutoreverses:NO];
    animation.fromValue = [NSValue valueWithCGRect:from];
    animation.toValue = [NSValue valueWithCGRect:to];
    animation.fillMode = kCAFillModeForwards;
    [animation setDelegate:(id)[CommonAnimation sharedCommonAnimation]];
    [animation setValue:view forKey:objectKey];
    [animation setValue:@"CommonAnimationScaleRect" forKey:nameKey];
    [view.layer addAnimation:animation forKey:@"CommonAnimationScaleRect"];
}

+ (void)AnimationAlphaRectWithView:(UIView *)view
                         FromValue:(CGFloat)from
                           ToVaule:(CGFloat)to
                          Duration:(CGFloat)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setDuration:duration];
    [animation setAutoreverses:NO];
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    [animation setDelegate:(id)[CommonAnimation sharedCommonAnimation]];
    [animation setValue:view forKey:objectKey];
    [animation setValue:@"CommonAnimationScale" forKey:nameKey];
    [view.layer addAnimation:animation forKey:@"CommonAnimationScale"];
}

+ (void)AnimationAlphaRectWithView:(UIView *)view
                         FromValue:(CGFloat)from
                           ToVaule:(CGFloat)to
                          Duration:(CGFloat)duration
                       finshiBlock:(CommonAnimationFinishBlock)block
{
    [CommonAnimation sharedCommonAnimation].finishBlock = block;
    [self AnimationAlphaRectWithView:view FromValue:from ToVaule:to Duration:duration];
}

+ (void)AnimationLableWithObject:(UILabel *)lab
                      TextFormat:(NSString *)format
                       TextArray:(NSArray <NSString *>*)texts
                  AttributeArray:(NSArray <NSArray<NSDictionary *>*>*)attributes
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *mutAttributes = [NSMutableArray arrayWithArray:attributes];
        NSString *firContent;
        NSArray *formatArr = [format componentsSeparatedByString:@"%"];
        
        NSString *firFormatStr = [@"%" stringByAppendingString:formatArr[1]];
        firFormatStr = [NSString stringWithFormat:@"%@%@",formatArr[0],firFormatStr];
        BOOL isFloat = NO;
        if ([firFormatStr rangeOfString:@"f"].location != NSNotFound)
        {
            isFloat = YES;
            firContent = texts[0];
        }
        else
        {
            if ([texts[0] rangeOfString:@"."].location == NSNotFound)
            {
                firContent = texts[0];
            }
            else
            {
                firContent = [texts[0] substringToIndex:[texts[0] rangeOfString:@"."].location];
            }
        }
        CGFloat addNumb = firContent.floatValue/(2.f*9.9f);
        CGFloat numb = .0f;
        id labContent = [CommonAnimation AppendFormatStringWithCotentStr:firContent TextArray:texts TextFormat:formatArr AttributeArray:attributes];
        CGFloat fontSize = lab.font.pointSize;
        while (1)
        {
            CGSize btnSize;
            if ([labContent isKindOfClass:[NSAttributedString class]])
            {
                btnSize = [[(NSAttributedString *)labContent string] sizeWithAttributes:@{NSFontAttributeName: DIF_UIFONTOFSIZE(fontSize)}];
            }
            else
            {
                btnSize = [labContent sizeWithAttributes:@{NSFontAttributeName:DIF_UIFONTOFSIZE(fontSize)}];
            }
            if (btnSize.width < lab.width-20)
            {
                if ([labContent isKindOfClass:[NSAttributedString class]])
                {
                    NSMutableArray *mutAttArr = [NSMutableArray arrayWithArray:attributes[0]];
                    [mutAttArr replaceObjectAtIndex:0 withObject:@{NSFontAttributeName:DIF_UIFONTOFSIZE(fontSize)}];
                    [mutAttributes replaceObjectAtIndex:0 withObject:mutAttArr];
                }
                else
                {
                    [lab setFont:DIF_UIFONTOFSIZE(fontSize)];
                }
                break;
            }
            fontSize --;
        }
        while (1)
        {
            NSString *firStr;
            if (isFloat)
            {
                numb += (addNumb<.1?(addNumb+.1):addNumb);
                firStr = [NSString stringWithFormat:firFormatStr,numb];
            }
            else
            {
                numb += (addNumb<1?(addNumb+1):addNumb);
                firStr = [NSString stringWithFormat:firFormatStr,[@(round(numb)) stringValue]];
            }
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:.001]];
            
            id labContent = [CommonAnimation AppendFormatStringWithCotentStr:firStr TextArray:texts TextFormat:formatArr AttributeArray:mutAttributes];
            if ([labContent isKindOfClass:[NSAttributedString class]])
            {
                [lab setAttributedText:labContent];
            }
            else
            {
                [lab setText:labContent];
            }
            if (isFloat && numb >= firContent.floatValue)
            {
                break;
            }
            if (!isFloat && numb >= firContent.intValue)
            {
                break;
            }
        }
        labContent = [CommonAnimation AppendFormatStringWithCotentStr:firContent TextArray:texts TextFormat:formatArr AttributeArray:mutAttributes];
        if ([labContent isKindOfClass:[NSAttributedString class]])
        {
            [lab setAttributedText:labContent];
        }
        else
        {
            [lab setText:labContent];
        }
    });
}

+ (id)AppendFormatStringWithCotentStr:(NSString *)firContent
                            TextArray:(NSArray <NSString *>*)texts
                           TextFormat:(NSArray <NSString *>*)formatArr
                       AttributeArray:(NSArray <NSArray<NSDictionary *>*>*)attributes
{
    NSMutableString *content = [NSMutableString stringWithString:firContent];
    for (int i = 1; i < (texts.count<formatArr.count-1?texts.count:formatArr.count-1); i++)
    {
        NSString *formatStr = @"%";
        if ([formatArr[1] rangeOfString:@" "].location  != NSNotFound)
        {
            formatStr = @" %";
        }
        formatStr = [formatStr stringByAppendingString:formatArr[i+1]];
        if ([formatStr rangeOfString:@"f"].location != NSNotFound)
        {
            [content appendFormat:formatStr,texts[i].floatValue];
        }
        else
        {
            [content appendFormat:formatStr,texts[i]];
        }
    }
    if (attributes.count > 0)
    {
        NSMutableAttributedString *attContent = [[NSMutableAttributedString alloc] initWithString:content];
        for (NSArray *attArr in attributes)
        {
            for (int i = 0; i < attArr.count; i++)
            {
                NSDictionary *attDic = attArr[i];
                if (i + 1 == texts.count)
                {
                    [attContent addAttributes:attDic range:[content rangeOfString:texts[i]]];
                }
                else
                {
                    [attContent addAttributes:attDic range:NSMakeRange(0, [content rangeOfString:texts[i+1]].location)];
                }
            }
        }
        return attContent;
    }
    else
    {
        return content;
    }
}

+ (void)AnimationTransformWithView:(UIView *)view
                           ToVaule:(CGPoint)toPoint
                          Duration:(CGFloat)duration
                       finshiBlock:(CommonAnimationFinishBlock)block
{
    [CommonAnimation sharedCommonAnimation].finishBlock = block;
    [self AnimationMoveWithView:view ToVaule:toPoint Duration:duration];
}

+ (void)AnimationTransformWithView:(UIView *)view
                           ToVaule:(CGFloat)to
                          Duration:(CGFloat)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [animation setDelegate:(id)[CommonAnimation sharedCommonAnimation]];
    [animation setDuration:duration];
    [animation setAutoreverses:NO];
    animation.fromValue = [NSNumber numberWithFloat:.0f];
    animation.toValue = [NSNumber numberWithFloat:to];
    [animation setDelegate:(id)[CommonAnimation sharedCommonAnimation]];
    [animation setValue:view forKey:objectKey];
    [animation setValue:@"CommonAnimationTransform" forKey:nameKey];
    [view.layer addAnimation:animation forKey:@"CommonAnimationTransform"];
}

#pragma mark - Animation Delegate

- (void)animationDidStart:(CAAnimation *)anim
{
    CABasicAnimation *anima = (CABasicAnimation *)anim;
    UIView *view = [anima valueForKey:objectKey];
    if (self.startBlock)
    {
        self.startBlock(view);
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CABasicAnimation *anima = (CABasicAnimation *)anim;
    if (flag)
    {
        UIView *view = [anima valueForKey:objectKey];
        NSString *animationName = [anima valueForKey:nameKey];
        if ([animationName isEqualToString:@"CommonAnimationScale"])
        {
            CGFloat toValue = [anima.toValue floatValue];
            CGAffineTransform currentTransform = view.transform;
            CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, toValue, toValue);
            [view setTransform:newTransform];
        }
        if ([animationName isEqualToString:@"CommonAnimationMove"])
        {
            CGPoint toValue = [anima.toValue CGPointValue];
            view.center = toValue;
        }
        if ([animationName isEqualToString:@"CommonAnimationScaleRect"])
        {
            CGRect toValue = [anima.toValue CGRectValue];
            view.frame = toValue;
        }
        if (self.finishBlock)
        {
            self.finishBlock(flag, view);
        }
    }
}

@end
