//
//  PlaceTextView.m
//  uavsystem
//
//  Created by jian zhang on 16/8/19.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "PlaceTextView.h"

@implementation PlaceTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setDelegate:self];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setEditable:YES];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setText:self.placeholder];
}

- (void)setPlaceColor:(UIColor *)placeColor
{
    _placeColor = placeColor;
    if (self.placeholder.length > 0)
    {
        [self setTextColor:self.placeColor];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.beginBlock)
    {
        self.beginBlock(textView);
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (self.selectionBlock)
    {
        self.selectionBlock(textView);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.placeholder.length > 0 && self.placeColor)
    {
        if ([textView.textColor isEqual:self.placeColor] && [self.placeholder rangeOfString:textView.text].location != NSNotFound)
        {
            [textView setText:nil];
            [textView setTextColor:(self.realTextColor?self.realTextColor:[UIColor blackColor])];
        }
    }
    if (text == nil || text.length == 0)
    {
        if (self.changeBlock)
        {
            self.changeBlock(textView, range, text);
        }
        return YES;
    }
    if (self.maxLength > 0 && textView.text.length + text.length > self.maxLength)
    {
        return NO;
    }
    if (self.changeBlock)
    {
        self.changeBlock(textView, range, text);
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        [textView setText:self.placeholder];
        [textView setTextColor:self.placeColor];
    }
    if (self.endBlock)
    {
        self.endBlock(textView);
    }
}

@end
