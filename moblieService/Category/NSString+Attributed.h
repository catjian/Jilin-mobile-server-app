//
//  NSString+Attributed.h
//  uavsystem
//
//  Created by jian zhang on 16/7/21.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (NSString_Attributed)

- (CGSize)AttributedSizeWithBaseWidth:(CGFloat)width;

- (NSMutableAttributedString *)FontAttributeNameWithFont:(UIFont *)font Range:(NSRange)range;

- (NSMutableAttributedString *)ForegroundColorAttributeNamWithColor:(UIColor *)color Range:(NSRange)range;

- (NSMutableAttributedString *)BackgroundColorAttributeNameWithColor:(UIColor *)color Range:(NSRange)range;

- (NSMutableAttributedString *)LigatureAttributeNameWithNumber:(NSInteger)number Range:(NSRange)range;

- (NSMutableAttributedString *)KernAttributeNameWithNumber:(NSInteger)number Range:(NSRange)range;


- (NSMutableAttributedString *)StrikethroughStyleAttributeNameWithNumber:(NSNumber *)number Range:(NSRange)range;

- (NSMutableAttributedString *)StrikethroughColorAttributeNameWithColor:(UIColor *)color Range:(NSRange)range;

- (NSMutableAttributedString *)StrikethroughAttributeNameWithNumber:(NSNumber *)number Color:(UIColor *)color Range:(NSRange)range;


- (NSMutableAttributedString *)UnderlineStyleAttributeNameWithNumber:(NSNumber *)number Range:(NSRange)range;

- (NSMutableAttributedString *)UnderlineColorAttributeNameWithColor:(UIColor *)color Range:(NSRange)range;

- (NSMutableAttributedString *)UnderlineAttributeNameWithNumber:(NSNumber *)number Color:(UIColor *)color Range:(NSRange)range;


- (NSMutableAttributedString *)StrokeWidthAttributeNameWithNumber:(NSInteger)number Range:(NSRange)range;

- (NSMutableAttributedString *)StrokeAttributeNameWithNumber:(NSInteger)number Color:(UIColor *)color Range:(NSRange)range;

- (NSMutableAttributedString *)ShadowAttributeNameWithNumber:(NSShadow *)shadow Range:(NSRange)range;

- (NSMutableAttributedString *)TextEffectAttributeNameWithStyle:(NSString *)style Range:(NSRange)range;

- (NSMutableAttributedString *)BaselineOffsetAttributeNameWithValue:(CGFloat)value Range:(NSRange)range;

- (NSMutableAttributedString *)ObliquenessAttributeNameWithValue:(CGFloat)value Range:(NSRange)range;

- (NSMutableAttributedString *)ExpansionAttributeNameWithValue:(CGFloat)value Range:(NSRange)range;

- (NSMutableAttributedString *)WritingDirectionAttributeNameWithValue:(NSInteger)value Range:(NSRange)range;

- (NSMutableAttributedString *)VerticalGlyphFormAttributeNameWithValue:(NSInteger)value Range:(NSRange)range;

- (NSMutableAttributedString *)LinkAttributeNameWithUrl:(NSURL *)url Range:(NSRange)range;

- (NSMutableAttributedString *)ParagraphStyleAttributeNameWithStyle:(NSParagraphStyle *)style Range:(NSRange)range;

@end
