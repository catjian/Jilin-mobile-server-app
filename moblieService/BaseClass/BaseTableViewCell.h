//
//  BaseTableViewCell.h
//  uavsystem
//
//  Created by zhang_jian on 16/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) BOOL showLine;
@property (nonatomic) CGFloat showLineWidht;

/**
 生成或获取cell对象
 
 @param className cell对象类名
 @param tableView tableview实例 如果只是为了获取cell的高度，只能传空
 @param model 数据模型
 @return cell对象
 */
+ (id)cellClassName:(NSString *)className InTableView:(UITableView*)tableView forContenteMode:(id)model;

- (void)loadData:(id)model;

- (CGFloat)getCellHeight;

+ (UINib *)nib;

@end
