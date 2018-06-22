//
//  UIButton+ImageTitleStyle.h
//  uavsystem
//
//  Created by jian zhang on 16/8/9.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, ENUM_ButtonImageTitleStyle ) {
    ENUM_ButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
    ENUM_ButtonImageTitleStyleLeft  = 1,         //图片在左，文字在右，整体居中。
    ENUM_ButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
    ENUM_ButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
    ENUM_ButtonImageTitleStyleBottom    = 4,     //图片在下，文字在上，整体居中。
    ENUM_ButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上距离按钮顶部。
    ENUM_ButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    ENUM_ButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    ENUM_ButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    ENUM_ButtonImageTitleStyleRightLeft,        //图片在右，文字在左，距离按钮两边边距
    ENUM_ButtonImageTitleStyleLeftRight,        //图片在左，文字在右，距离按钮两边边距
};

@interface UIButton (ImageTitleStyle)


/*
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的间隙。
 
 */
- (void)setButtonImageTitleStyle:(ENUM_ButtonImageTitleStyle)style padding:(CGFloat)padding;

@end
