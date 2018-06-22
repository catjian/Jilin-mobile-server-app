//
//  JobGridDetailTableViewCell.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "JobGridDetailTableViewCell.h"

@implementation JobGridDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = DIF_PX(44);
        [self setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        [self createContentView];
        [self setShowLine:YES];
        self.showLineWidht = DIF_SCREEN_WIDTH - DIF_PX(15);
    }
    return self;
}

- (void)createContentView
{
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(14), DIF_PX(12), DIF_PX(104), DIF_PX(20))];
    [titleLab setTag:2000];
    [titleLab setTextColor:DIF_HEXCOLOR(@"999999")];
    [titleLab setFont:DIF_DIFONTOFSIZE(14)];
    [self.contentView addSubview:titleLab];
    
    UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.right, titleLab.top, DIF_SCREEN_WIDTH-titleLab.right-DIF_PX(16), DIF_PX(20))];
    [detailLab setTag:2001];
    [detailLab setTextColor:DIF_HEXCOLOR(@"000000")];
    [detailLab setFont:DIF_DIFONTOFSIZE(14)];
    [detailLab setLineBreakMode:NSLineBreakByCharWrapping];
    [detailLab setNumberOfLines:0];
    [self.contentView addSubview:detailLab];
    
    UIButton *rightImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightImage setFrame:CGRectMake(0, 0, DIF_PX(30), DIF_PX(30))];
    [rightImage setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
    [rightImage setCenterY:DIF_PX(44/2)];
    [rightImage setRight:DIF_SCREEN_WIDTH-DIF_PX(23)];
    [rightImage setTag:2002];
    [rightImage setHidden:YES];
    [self.contentView addSubview:rightImage];
    [rightImage addTarget:self
                   action:@selector(callPhoneButtonEvent)
         forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData:(id)model
{
    NSArray *keyArr = @[@"title",@"detail"];
    UILabel *titleLab = (UILabel *)[self.contentView viewWithTag:2000];
    if ([model[keyArr[0]] isKindOfClass:[NSAttributedString class]])
    {
        [titleLab setAttributedText:model[keyArr[0]]];
    }
    else
    {
        [titleLab setText:model[keyArr[0]]];
    }
    UILabel *detailLab = (UILabel *)[self.contentView viewWithTag:2001];
    detailLab.height = DIF_PX(20);
    CGSize textSize;
    if ([model[keyArr[1]] isKindOfClass:[NSAttributedString class]])
    {
        [detailLab setAttributedText:model[keyArr[1]]];
        textSize = [detailLab.attributedText.string boundingRectWithSize:CGSizeMake(detailLab.frame.size.width, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                             attributes:@{NSFontAttributeName:detailLab.font}
                                                context:nil].size;
    }
    else
    {
        [detailLab setText:model[keyArr[1]]];
        textSize = [detailLab.text boundingRectWithSize:CGSizeMake(detailLab.frame.size.width, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                                    attributes:@{NSFontAttributeName:detailLab.font}
                                                       context:nil].size;
    }
    if (textSize.height > detailLab.height)
    {
        detailLab.height = ((textSize.height/detailLab.height))*DIF_PX(20);
    }
    self.cellHeight = self.cellHeight-DIF_PX(20) + detailLab.height;
    UIImageView *rightImage = (UIImageView *)[self.contentView viewWithTag:2002];
    [rightImage setHidden:YES];
    if (model[@"showImage"])
    {
        [rightImage setHidden:NO];
    }
}

- (void)callPhoneButtonEvent
{
    UILabel *detailLab = (UILabel *)[self.contentView viewWithTag:2001];
    NSString *phoneNum = detailLab.text;
    if (phoneNum && !phoneNum.isNull && [CommonVerify isMobileNumber:phoneNum])
    {
        NSString *urlString = [NSString stringWithFormat:@"telprompt://%@",phoneNum];
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]
                                               options:@{}
                                     completionHandler:nil];
        }
        else
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }
            else
            {
                [self makeToast:@"不支持通话功能" duration:1 position:CSToastPositionCenter];
            }
        }
    }
}

@end
