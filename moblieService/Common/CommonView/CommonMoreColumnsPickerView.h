//
//  CommonMoreColumnsPickerView.h
//  uavsystem
//
//  Created by zhang_jian on 2017/9/15.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonMoreColumnsPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) RACSubject *racSignal;
@property (nonatomic, strong) NSArray *pickerDatas;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, assign) NSInteger columnsNumber;
@property (nonatomic, copy) NSString *lastColumnsKey;

@end
