//
//  UIButton+ImageTitleStyle.m
//  uavsystem
//
//  Created by jian zhang on 16/8/9.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import "UIButton+ImageTitleStyle.h"

@implementation UIButton (ImageTitleStyle)

/*
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的间隙。
 
 */
-(void)setButtonImageTitleStyle:(ENUM_ButtonImageTitleStyle)style padding:(CGFloat)padding
{
    if (self.imageView.image != nil && self.titleLabel.text != nil)
    {
        
        //先还原
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        
        CGRect imageRect = self.imageView.frame;
        CGRect titleRect = self.titleLabel.frame;
        
        CGFloat totalHeight = imageRect.size.height + padding + titleRect.size.height;
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        
        switch (style)
        {
            case ENUM_ButtonImageTitleStyleLeft:
                if (padding != 0)
                {
                    self.titleEdgeInsets = UIEdgeInsetsMake(0,padding/2,0,-padding/2);
                    
                    self.imageEdgeInsets = UIEdgeInsetsMake(0,-padding/2,0,padding/2);
                }
                break;
            case ENUM_ButtonImageTitleStyleRight:
            {
                //图片在右，文字在左
                self.titleEdgeInsets = UIEdgeInsetsMake(0,-(imageRect.size.width + padding/2),
                                                        0,(imageRect.size.width + padding/2));
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,(titleRect.size.width+ padding/2),
                                                        0,-(titleRect.size.width+ padding/2));
            }
                break;
            case ENUM_ButtonImageTitleStyleTop:
            {
                //图片在上，文字在下
                self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                        (selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2,
                                                        -((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                        -(selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                        (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        -((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                        -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
                
            }
                break;
            case ENUM_ButtonImageTitleStyleBottom:
            {
                //图片在下，文字在上。
                self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                        (selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                        -(selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                        (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        -((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                        -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
                
                
            }
                break;
            case ENUM_ButtonImageTitleStyleCenterTop:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y - padding),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        (titleRect.origin.y - padding),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ENUM_ButtonImageTitleStyleCenterBottom:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake((selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -(selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ENUM_ButtonImageTitleStyleCenterUp:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        (titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ENUM_ButtonImageTitleStyleCenterDown:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake((imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -(imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ENUM_ButtonImageTitleStyleRightLeft:
            {
                //图片在右，文字在左，距离按钮两边边距
                UIEdgeInsets edgeInset = UIEdgeInsetsMake(0,-(titleRect.origin.x - padding),
                                                          0,(titleRect.origin.x - padding));
                self.titleEdgeInsets = edgeInset;
                
                edgeInset = UIEdgeInsetsMake(0,(selfWidth - padding - imageRect.origin.x - imageRect.size.width),
                                             0,-(selfWidth - padding - imageRect.origin.x - imageRect.size.width));
                self.imageEdgeInsets = edgeInset;
            }
                break;
                
            case ENUM_ButtonImageTitleStyleLeftRight:
            {
                //图片在左，文字在右，距离按钮两边边距
                self.titleEdgeInsets = UIEdgeInsetsMake(0,(selfWidth - padding - titleRect.origin.x - titleRect.size.width),
                                                        0,-(selfWidth - padding - titleRect.origin.x - titleRect.size.width));
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,-(imageRect.origin.x - padding),
                                                        0,(imageRect.origin.x - padding));
            }
                break;
                
            case ENUM_ButtonImageTitleStyleDefault:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
                break;
                
            default:
                break;
        }
        
        
    }
}

@end

