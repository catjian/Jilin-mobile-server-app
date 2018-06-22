//
//  CommonHttp.h
//  uavsystem
//
//  Created by jian zhang on 16/8/4.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define DIF_HTTP_NOT_HAVE_NETWORK @"网络连接失败\n请查看网络是否连接正常！"
#define DIF_HTTP_REQUEST_PARMS_NULL @"请求数据不能为空"
#define DIF_HTTP_REQUEST_URL_NULL @"网络请求异常"

#define DIF_CommonHttpAdapter [CommonHttpAdapter sharedCommonHttp]

typedef NS_ENUM(NSUInteger, ENUM_COMMONHTTP_RESPONSE_TYPE) {
    ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS, // 000000
    ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE
};

typedef void(^CommonHttpResponseBlock)(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel);
typedef void(^CommonHttpResponseFailed)(NSError *error);
typedef void(^CommonHttpResponseProgress)(NSProgress *progress);


@interface CommonHttpAdapter : NSObject

+ (CommonHttpAdapter *)sharedCommonHttp;

- (void)setBaseUrl;

-(BOOL) connectedToNetwork;

#pragma mark - 用户登录
- (void)httpRequestLoginWithParameters:(NSDictionary *)parms
                         ResponseBlock:(CommonHttpResponseBlock)successBlock
                           FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 用户退出
- (void)httpRequestPostLogoutWithParameters:(NSDictionary *)parms
                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 获取工单列表
- (void)httpRequestGetGridListWithParameters:(NSDictionary *)parms
                               ResponseBlock:(CommonHttpResponseBlock)successBlock
                                 FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 工单接收前的前期准备数据
- (void)httpRequestReceiveRfWithParameters:(NSDictionary *)parms
                             ResponseBlock:(CommonHttpResponseBlock)successBlock
                               FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 获取工区列表
- (void)httpRequestGetWareaJsonForSearchByMobileWithParameters:(NSDictionary *)parms
                                                 ResponseBlock:(CommonHttpResponseBlock)successBlock
                                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock;


#pragma mark - 添加工单处理人员
- (void)httpRequestAddExecStaffByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 获取下级工单原因
- (void)httpRequestGetWaReasonOptionsListByMobileWithParameters:(NSDictionary *)parms
                                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 接收工单/处理返单/工单错返
- (void)httpRequestSubmitServiceResultForGridWithParameters:(NSDictionary *)parms
                                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                                FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 工单申请延时
- (void)httpRequestSubmitRfDelayWithParameters:(NSDictionary *)parms
                                 ResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 修改密码/转派部门
- (void)httpRequestModPassByMobileWithParameters:(NSDictionary *)parms
                                   ResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 获取转派部门信息列表
- (void)httpRequestGetWareaJsonByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 获取新工单数据(用于消息提醒)
- (void)httpRequestCheckNewByMobileWithParameters:(NSDictionary *)parms
                                    ResponseBlock:(CommonHttpResponseBlock)successBlock
                                      FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 获取公告列表
- (void)httpRequestgetAfficheMessagesByMobileWithParameters:(NSDictionary *)parms
                                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                                FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 获取公告列表
- (void)httpRequestAfficheInfoByMobileWithParameters:(NSDictionary *)parms
                                       ResponseBlock:(CommonHttpResponseBlock)successBlock
                                         FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 取得公告附件下载路径
- (void)httpRequestDownloadFileByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock;
@end
