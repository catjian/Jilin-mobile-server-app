//
//  BaseTableViewCell.m
//  uavsystem
//
//  Created by zhang_jian on 16/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (id)cellClassName:(NSString *)className InTableView:(UITableView*)tableView forContenteMode:(id)model
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@_CELLIDENTIFIER", className];
    Class cellClass = NSClassFromString(className);
    BaseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell loadData:model];
    return cell;
}

- (void)loadData:(id)model
{
    
}

- (CGFloat)getCellHeight
{
    return _cellHeight;
}

- (void)drawRect:(CGRect)rect
{
    if (self.showLineWidht == 0)
    {
        self.showLineWidht = self.width;
    }
    if (self.showLine)
    {
        UIBezierPath *path  = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(self.width-self.showLineWidht, self.cellHeight-DIF_PX(.5))];
        [path addLineToPoint:CGPointMake(self.width, self.cellHeight-DIF_PX(.5))];
        path.lineWidth = 0.5;
        [[CommonTool colorWithHexString:DIF_CELL_SEPARATOR_COLOR Alpha:1] setStroke];
        [path stroke];
    }
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end
