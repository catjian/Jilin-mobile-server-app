//
//  CommonPickerView.h
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/21.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) RACSubject *racSignal;
@property (nonatomic, strong) NSArray *pickerDatas;
@property (nonatomic, copy) NSString *titleStr;

@end
