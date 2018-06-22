//
//  CommonPopShareView.h
//  EAVisionOnline
//
//  Created by jian zhang on 2017/6/29.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonPopShareViewChoseShareBlock)(NSInteger);

@interface CommonPopShareView : UIView

+ (CommonPopShareView *)showPopShareViewEventBlock:(CommonPopShareViewChoseShareBlock)block;

@end
