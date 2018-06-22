//
//  BaseLable.m
//  uavsystem
//
//  Created by jian zhang on 16/7/19.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "BaseLable.h"
#import <CoreText/CoreText.h>

@implementation BaseLable

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = ENUM_LABLE_VERTICALALIGNMENT_MIDDLE;
    }
    return self;
}

- (void)setVerticalAlignment:(ENUM_LABLE_VERTICALALIGNMENT)verticalAlignment
{
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment)
    {
        case ENUM_LABLE_VERTICALALIGNMENT_TOP:
            textRect.origin.y = bounds.origin.y;
            break;
        case ENUM_LABLE_VERTICALALIGNMENT_BOTTOM:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case ENUM_LABLE_VERTICALALIGNMENT_LEFT_AND_RIGHT:
            [self ChangeAlignmentLeftAndRight];
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            break;
        case ENUM_LABLE_VERTICALALIGNMENT_MIDDLE:
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            break;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect
{
//    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
//                                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
//                                           attributes:@{NSFontAttributeName:self.font}
//                                              context:nil].size;
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
//    if (actualRect.size.width == 0)
//    {
//        actualRect.origin.x = requestedRect.size.width - textSize.width;
//        actualRect.size.width = textSize.width;
//    }
    [super drawTextInRect:actualRect];
}

- (void)ChangeAlignmentLeftAndRight
{
//    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
//                                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
//                                           attributes:@{NSFontAttributeName:self.font}
//                                              context:nil].size;
//    CGFloat margin = (self.frame.size.width - textSize.width)/(self.text.length-1);
//    NSNumber *number = [NSNumber numberWithFloat:margin];
//    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self.text];
//    if (is_iPhone6)
//    {
//        [attString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length-1)];
//    }
//    [self setAttributedText:attString];
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(200,self.frame.size.height)
                                          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName: self.font}
                                          context:nil];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attrString addAttribute:NSKernAttributeName value:@(((10 - self.text.length) * rect.size.width)/(self.text.length - 1)) range:NSMakeRange(0, self.text.length)];
    self.attributedText = attrString;
}

@end
