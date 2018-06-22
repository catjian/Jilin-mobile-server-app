//
//  NoticeDataModel.m
//  moblieService
//
//  Created by zhang_jian on 2018/6/1.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NoticeDataModel.h"

#pragma mark - NoticeDataModel class

@implementation NoticeDataModel

- (NSDictionary *)getShowDataModel
{
    NSDictionary *dateModel = @{@"date":[CommonDate dateToString:[CommonDate dateStringToDate:self.sendDate
                                                                                      Formate:nil]
                                                         Formate:@"yyyy年MM月dd日 HH:mm:ss"],
                                @"title":self.title};
    return dateModel;
}
@end

#pragma mark - NoticeDetailDataModel class

@implementation NoticeDetailDataModel

- (NSArray *)getShowDataModel
{
    NSString *fileName = @"";
    if (self.attach && ![self.attach isEqualToString:@"null"])
    {
        fileName = [self.attach componentsSeparatedByString:@"/"].lastObject;
    }
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *content = [self.messageBlob stringByReplacingPercentEscapesUsingEncoding:gbkEncoding];
    if (!content) {
        content = @"";
    }
    NSArray *dateModel = @[@{@"title":@"公告",@"detail":self.title?self.title:@""},
                           @{@"title":@"发布人",@"detail":self.staffName?self.staffName:@""},
                           (self.attach && ![self.attach isEqualToString:@"null"])?@{@"title":@"附件",@"detail":fileName,@"showImage":@"1"}:@{@"title":@"附件",@"detail":fileName},
                           @{@"title":@"生效时间",@"detail":self.sendDate?[CommonDate dateToString:[CommonDate dateStringToDate:self.sendDate Formate:@"yyyy-MM-dd HH:mm:ss.SSSS"]
                                                                                       Formate:@"yyyy年MM月dd日 HH:mm:ss"]:@""},
                           @{@"title":@"失效时间",@"detail":self.invalidDate?[CommonDate dateToString:[CommonDate dateStringToDate:self.invalidDate Formate:@"yyyy-MM-dd HH:mm:ss.SSSS"]
                                                                                          Formate:@"yyyy年MM月dd日 HH:mm:ss"]:@""},
                           @{@"title":@"内容",@"detail":content}];
    return dateModel;
}
@end
