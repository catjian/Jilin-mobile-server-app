//
//  NSString+Attributed.m
//  uavsystem
//
//  Created by jian zhang on 16/7/21.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "NSString+Attributed.h"

@implementation NSMutableAttributedString (NSString_Attributed)

- (CGSize)AttributedSizeWithBaseWidth:(CGFloat)width
{
    CGRect attrsRect=[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        context:nil];
    return attrsRect.size;
}

- (NSMutableAttributedString *)FontAttributeNameWithFont:(UIFont *)font Range:(NSRange)range
{
    [self addAttribute:NSFontAttributeName value:font range:range];
    return self;
}

- (NSMutableAttributedString *)ForegroundColorAttributeNamWithColor:(UIColor *)color Range:(NSRange)range
{
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    return self;
}

- (NSMutableAttributedString *)BackgroundColorAttributeNameWithColor:(UIColor *)color Range:(NSRange)range
{
    [self addAttribute:NSBackgroundColorAttributeName value:color range:range];
    return self;
}

- (NSMutableAttributedString *)LigatureAttributeNameWithNumber:(NSInteger)number Range:(NSRange)range
{
    [self addAttribute:NSLigatureAttributeName value:[NSNumber numberWithInteger:number] range:range];
    return self;
}

- (NSMutableAttributedString *)KernAttributeNameWithNumber:(NSInteger)number Range:(NSRange)range
{
    [self addAttribute:NSKernAttributeName value:[NSNumber numberWithInteger:number] range:range];
    return self;
}


- (NSMutableAttributedString *)StrikethroughStyleAttributeNameWithNumber:(NSNumber *)number Range:(NSRange)range
{
    return [self StrikethroughAttributeNameWithNumber:number Color:[UIColor blackColor] Range:range];
}

- (NSMutableAttributedString *)StrikethroughColorAttributeNameWithColor:(UIColor *)color Range:(NSRange)range
{
    return [self StrikethroughAttributeNameWithNumber:@(NSUnderlineStyleSingle) Color:color Range:range];
}

- (NSMutableAttributedString *)StrikethroughAttributeNameWithNumber:(NSNumber *)number Color:(UIColor *)color Range:(NSRange)range
{
    [self addAttribute:NSStrikethroughStyleAttributeName value:number range:range];
    [self addAttribute:NSStrikethroughColorAttributeName value:color range:range];
    return self;
}


- (NSMutableAttributedString *)UnderlineStyleAttributeNameWithNumber:(NSNumber *)number Range:(NSRange)range
{
    return [self UnderlineAttributeNameWithNumber:number Color:[UIColor blackColor] Range:range];
}

- (NSMutableAttributedString *)UnderlineColorAttributeNameWithColor:(UIColor *)color Range:(NSRange)range;
{
    return [self UnderlineAttributeNameWithNumber:@(NSUnderlineStyleSingle) Color:color Range:range];
}

- (NSMutableAttributedString *)UnderlineAttributeNameWithNumber:(NSNumber *)number Color:(UIColor *)color Range:(NSRange)range
{
    [self addAttribute:NSUnderlineStyleAttributeName value:number range:range];
    [self addAttribute:NSUnderlineColorAttributeName value:color range:range];
    return self;
}


- (NSMutableAttributedString *)StrokeWidthAttributeNameWithNumber:(NSInteger)number Range:(NSRange)range
{
    return [self StrokeAttributeNameWithNumber:number Color:[UIColor blackColor] Range:range];
}

- (NSMutableAttributedString *)StrokeAttributeNameWithNumber:(NSInteger)number Color:(UIColor *)color Range:(NSRange)range
{
    [self addAttribute:NSStrokeWidthAttributeName value:@(number) range:range];
    [self addAttribute:NSStrokeColorAttributeName value:color range:range];
    return self;
}

- (NSMutableAttributedString *)ShadowAttributeNameWithNumber:(NSShadow *)shadow Range:(NSRange)range
{
    [self addAttribute:NSShadowAttributeName value:shadow range:range];
    return self;
}

- (NSMutableAttributedString *)TextEffectAttributeNameWithStyle:(NSString *)style Range:(NSRange)range
{
    [self addAttribute:NSShadowAttributeName value:style range:range];
    return self;
}

- (NSMutableAttributedString *)BaselineOffsetAttributeNameWithValue:(CGFloat)value Range:(NSRange)range
{
    [self addAttribute:NSBaselineOffsetAttributeName value:@(value) range:range];
    return self;
}

- (NSMutableAttributedString *)ObliquenessAttributeNameWithValue:(CGFloat)value Range:(NSRange)range
{
    [self addAttribute:NSObliquenessAttributeName value:@(value) range:range];
    return self;
}

- (NSMutableAttributedString *)ExpansionAttributeNameWithValue:(CGFloat)value Range:(NSRange)range
{
    [self addAttribute:NSExpansionAttributeName value:@(value) range:range];
    return self;
}

- (NSMutableAttributedString *)WritingDirectionAttributeNameWithValue:(NSInteger)value Range:(NSRange)range
{
    [self addAttribute:NSWritingDirectionAttributeName value:@(value) range:range];
    return self;
}

- (NSMutableAttributedString *)VerticalGlyphFormAttributeNameWithValue:(NSInteger)value Range:(NSRange)range
{
    [self addAttribute:NSVerticalGlyphFormAttributeName value:@(value) range:range];
    return self;
}

- (NSMutableAttributedString *)LinkAttributeNameWithUrl:(NSURL *)url Range:(NSRange)range
{
    [self addAttribute:NSLinkAttributeName value:url range:range];
    return self;
}

- (NSMutableAttributedString *)ParagraphStyleAttributeNameWithStyle:(NSParagraphStyle *)style Range:(NSRange)range
{
    [self addAttribute:NSParagraphStyleAttributeName value:style range:range];
    return self;
}

@end
