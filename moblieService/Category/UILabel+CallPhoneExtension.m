//
//  UILabel+CallPhoneExtension.m
//  uavsystem
//
//  Created by lx on 16/8/23.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "UILabel+CallPhoneExtension.h"

@implementation UILabel (CallPhoneExtension)


- (void)callPhoneWithTarget:(nullable id)target action:(nullable SEL)action
{
    self.userInteractionEnabled = YES;
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    if (self.text.length <= 0)
    {
        return;
    }
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.text attributes:attribtDic];
    self.attributedText = attribtStr;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
}

@end
