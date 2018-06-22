//
//  NoticeDetailTableViewCell.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NoticeDetailTableViewCell.h"

@implementation NoticeDetailTableViewCell
{
    UIWebView *m_WebView;
}

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
    [rightImage setImage:[UIImage imageNamed:@"下载"] forState:UIControlStateNormal];
    [rightImage setCenterY:DIF_PX(44/2)];
    [rightImage setRight:DIF_SCREEN_WIDTH-DIF_PX(23)];
    [rightImage setTag:2002];
    [rightImage setHidden:YES];
    [self.contentView addSubview:rightImage];
    [rightImage addTarget:self
                   action:@selector(downloadButtonEvent)
         forControlEvents:UIControlEventTouchUpInside];
    
    m_WebView  = [[UIWebView alloc] initWithFrame:detailLab.frame];
    [m_WebView setBackgroundColor:DIF_HEXCOLOR(@"000000")];
    [m_WebView setHidden:YES];
    [m_WebView.scrollView setBounces:NO];
    [self.contentView addSubview:m_WebView];

}

- (void)loadData:(id)model
{
    NSArray *keyArr = @[@"title",@"detail"];
    UILabel *titleLab = (UILabel *)[self.contentView viewWithTag:2000];
    [titleLab setText:model[keyArr[0]]];
    UILabel *detailLab = (UILabel *)[self.contentView viewWithTag:2001];
    detailLab.height = DIF_PX(20);
    [detailLab setText:model[keyArr[1]]];
    CGSize textSize = [detailLab.text boundingRectWithSize:CGSizeMake(detailLab.frame.size.width, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                                attributes:@{NSFontAttributeName:detailLab.font}
                                                   context:nil].size;
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
    [m_WebView setHidden:YES];
    [m_WebView setHeight:detailLab.height];
    if ([titleLab.text isEqualToString:@"内容"] && [detailLab.text rangeOfString:@"<p+class"].location == 0)
    {
        [m_WebView setHeight:detailLab.height];
        [m_WebView loadHTMLString:detailLab.text baseURL:nil];
        [m_WebView setHidden:NO];
    }
}

- (void)downloadButtonEvent
{
    if (self.downloadBlock)
    {
        self.downloadBlock();
    }
}

@end
