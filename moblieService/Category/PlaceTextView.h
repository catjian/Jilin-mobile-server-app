//
//  PlaceTextView.h
//  uavsystem
//
//  Created by jian zhang on 16/8/19.
//  Copyright © 2016年 yuwubao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PlaceTViewDidBeginEditing)(UITextView *textView);
typedef void(^PlaceTViewDidChangeSelection)(UITextView *textView);
typedef void(^PlaceTextViewShouldChange)(UITextView *textView, NSRange range, NSString *replacementText);
typedef void(^PlaceTViewDidEndEditing)(UITextView *textView);

@interface PlaceTextView : UITextView <UITextViewDelegate>

@property (nonatomic, copy) PlaceTViewDidBeginEditing beginBlock;
@property (nonatomic, copy) PlaceTViewDidChangeSelection selectionBlock;
@property (nonatomic, copy) PlaceTextViewShouldChange changeBlock;
@property (nonatomic, copy) PlaceTViewDidEndEditing endBlock;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeColor;
@property (nonatomic, assign) NSInteger maxLength;  //0 不限长
@property (nonatomic, strong) UIColor *realTextColor;

@end
