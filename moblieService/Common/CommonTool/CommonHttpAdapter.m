//
//  CommonHttp.m
//  uavsystem
//
//  Created by jian zhang on 16/8/4.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonHttpAdapter.h"
#import <netinet/in.h>

static CommonHttpAdapter *comHttp = nil;

@implementation CommonHttpAdapter
{
    AFHTTPSessionManager *httpSessionManager;
    AFSecurityPolicy *securityPolicy;
    NSString *sessionString;
    NSString *m_BaseUrl;
}

+ (CommonHttpAdapter *)sharedCommonHttp
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        comHttp = [[CommonHttpAdapter alloc] init];
    });
    return comHttp;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSString *requsetType = @"https";
        if (![DIF_CommonCurrentUser.serviceHost isEqualToString:@"www.jlxxxfw.cn"])
        {
            requsetType = @"http";
        }
        m_BaseUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/",requsetType,DIF_CommonCurrentUser.serviceHost,DIF_CommonCurrentUser.servicePort,DIF_CommonCurrentUser.serviceName];
        httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:m_BaseUrl]];
        [httpSessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        httpSessionManager.requestSerializer.timeoutInterval = 30;
        [httpSessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)httpSessionManager.responseSerializer;
        httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml",@"application/json", @"text/json", @"text/javascript",@"text/html",@"application/x-www-form-urlencoded", nil];
        response.removesKeysWithNullValues = YES;
        if ([DIF_CommonCurrentUser.serviceHost isEqualToString:@"www.jlxxxfw.cn"])
        {
            [self setHttpsCertificate];
        }
    }
    return self;
}

- (void)setBaseUrl
{
    NSString *requsetType = @"https";
    if (![DIF_CommonCurrentUser.serviceHost isEqualToString:@"www.jlxxxfw.cn"])
    {
        requsetType = @"http";
    }
    m_BaseUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/",requsetType,DIF_CommonCurrentUser.serviceHost,DIF_CommonCurrentUser.servicePort,DIF_CommonCurrentUser.serviceName];
    [httpSessionManager setBaseURL:[NSURL URLWithString:m_BaseUrl]];
    if ([DIF_CommonCurrentUser.serviceHost isEqualToString:@"www.jlxxxfw.cn"])
    {
        [self setHttpsCertificate];
    }
}

-(BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

- (void)setHttpsCertificate
{
    __block NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"appClient" ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
//    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:cerData, nil];
    securityPolicy.pinnedCertificates = set;
    
    httpSessionManager.securityPolicy = securityPolicy;
}

- (NSString *)parametersToString:(NSDictionary *)params
{
    NSMutableString *paramString = [NSMutableString string];
    for (NSString *key in params.allKeys)
    {
        [paramString appendFormat:@"%@=%@",key,params[key]];
        [paramString appendString:@"&"];
    }
    [paramString deleteCharactersInRange:NSMakeRange(paramString.length-1, 1)];
    return paramString;
}

#pragma mark Get请求
- (void)HttpGetRequestWithCommand:(NSString *)command
                       parameters:(NSDictionary *)parms
                    ResponseBlock:(CommonHttpResponseBlock)block
                      FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    if (![self connectedToNetwork])
    {
        block?block(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_NOT_HAVE_NETWORK):nil;
        return;
    }
    if (!command)
    {
        block?block(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_REQUEST_PARMS_NULL):nil;
        return;
    }
    NSString *urlPara = command;
    DebugLog(@"command = %@",command);
    if (![command isEqualToString:@"loginByMobile.action"])
    {
        urlPara = [command stringByAppendingFormat:@";jsessionid=%@",sessionString];
    }
    if (parms)
    {
        urlPara = [urlPara stringByAppendingFormat:@"?%@",[self parametersToString:parms]];
    }
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *retStr = [[NSString alloc] initWithData:urlPara.UTF8String encoding:enc];
    [httpSessionManager GET:[urlPara stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                 parameters:nil
                   progress:nil
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        DebugLog(@"responseObject = %@",responseObject);
                        if (block)
                        {
                            block(ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS,responseObject);
                        }
                    }
                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        DebugLog(@"error = %@",error);
                        if (failedBlock)
                        {
                            failedBlock(error);
                        }
                    }];
}

#pragma mark - 用户登录
- (void)httpRequestLoginWithParameters:(NSDictionary *)parms
                         ResponseBlock:(CommonHttpResponseBlock)successBlock
                           FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    if (!parms)
    {
        successBlock?successBlock(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_REQUEST_PARMS_NULL):nil;
        return;
    }
    DIF_WeakSelf(self)
    [self HttpGetRequestWithCommand:@"loginByMobile.action"
                          parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              responseModel[@"staffId"])
                          {
                              DIF_StrongSelf
                              NSString *loginUrl = [m_BaseUrl stringByAppendingFormat:@"loginByMobile.action?staff.wcode=%@&staff.password=%@",parms[@"staff.wcode"], parms[@"staff.password"]];
                              NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:loginUrl]];
                              NSDictionary *Request = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
                              strongSelf->sessionString = [Request objectForKey:@"Cookie"];
                              strongSelf->sessionString = [strongSelf->sessionString substringFromIndex:[strongSelf->sessionString rangeOfString:@"JSESSIONID="].length];
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                         FailedBlcok:failedBlock];
}

#pragma mark - 用户退出
- (void)httpRequestPostLogoutWithParameters:(NSDictionary *)parms
                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    if (!parms)
    {
        successBlock?successBlock(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_REQUEST_PARMS_NULL):nil;
        return;
    }
    [self HttpGetRequestWithCommand:@"logoutByMobile.action"
                          parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 获取工单列表
- (void)httpRequestGetGridListWithParameters:(NSDictionary *)parms
                               ResponseBlock:(CommonHttpResponseBlock)successBlock
                                 FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"getService4MobileGrid.action"
                          parameters:parms
                       ResponseBlock:successBlock
                         FailedBlcok:failedBlock];
}

#pragma mark - 添加工单处理人员
- (void)httpRequestAddExecStaffByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"addExecStaffByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 删除工单处理人员
- (void)httpRequestDelExecStaffByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"delExecStaffByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 获取工区列表
- (void)httpRequestGetWareaJsonForSearchByMobileWithParameters:(NSDictionary *)parms
                                                 ResponseBlock:(CommonHttpResponseBlock)successBlock
                                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"getWareaJsonForSearchByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 获取考核数据信息
- (void)httpRequestGetKaoheDataByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"getKaoheDataByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 获取下级工单原因
- (void)httpRequestGetWaReasonOptionsListByMobileWithParameters:(NSDictionary *)parms
                                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"getWaReasonOptionsListByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 工单接收前的前期准备数据
- (void)httpRequestReceiveRfWithParameters:(NSDictionary *)parms
                             ResponseBlock:(CommonHttpResponseBlock)successBlock
                               FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"receiveRf.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 接收工单/处理返单/工单错返
- (void)httpRequestSubmitServiceResultForGridWithParameters:(NSDictionary *)parms
                                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                                FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"submitServiceResultForGrid.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 工单申请延时
- (void)httpRequestSubmitRfDelayWithParameters:(NSDictionary *)parms
                                 ResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"submitRfDelay.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 修改密码/转派部门
- (void)httpRequestModPassByMobileWithParameters:(NSDictionary *)parms
                                   ResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"modPassByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 获取转派部门信息列表
- (void)httpRequestGetWareaJsonByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"getWareaJsonByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 获取新工单数据(用于消息提醒)
- (void)httpRequestCheckNewByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"checkNewByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 获取公告列表
- (void)httpRequestgetAfficheMessagesByMobileWithParameters:(NSDictionary *)parms
                                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                                FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"getAfficheMessagesByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 获取公告列表
- (void)httpRequestAfficheInfoByMobileWithParameters:(NSDictionary *)parms
                                       ResponseBlock:(CommonHttpResponseBlock)successBlock
                                         FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"afficheInfoByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

#pragma mark - 取得公告附件下载路径
- (void)httpRequestDownloadFileByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"downloadFileByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

- (void)downLoadFileEventWithUrlString:(NSString *)urlPara
                          fieldTxtFile:(NSString *)filePath
                         ResponseBlock:(CommonHttpResponseBlock)successBlock
                        uploadProgress:(CommonHttpResponseProgress)progressBlock
{
    if (![self connectedToNetwork])
    {
        if (successBlock)
        {
            successBlock(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,@"网络连接失败\n请查看网络是否连接正常！");
        }
        return;
    }
    NSError *serializationError = nil;
    
    AFHTTPSessionManager *downLoadManger = [AFHTTPSessionManager manager];
    downLoadManger.responseSerializer = [AFJSONResponseSerializer serializer];
    downLoadManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSMutableURLRequest *request = [downLoadManger.requestSerializer
                                    requestWithMethod:@"GET"
                                    URLString:urlPara.mj_url.absoluteString
                                    parameters:nil
                                    error:&serializationError];
    __block NSURLSessionDownloadTask *dataTask =
    [downLoadManger downloadTaskWithRequest:request
                                   progress:^(NSProgress * _Nonnull downloadProgress) {
                                       if (progressBlock)
                                       {
                                           progressBlock(downloadProgress);
                                       }
                                   }
                                destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                    
                                    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                                    //使用建议的路径
                                    path = [path stringByAppendingPathComponent:@"/downloadFile"];
                                    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
                                    {
                                        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                                    }
                                    path = [path stringByAppendingPathComponent:filePath];
                                    InfoLog(@"%@",path);
                                    NSURL *url = [NSURL fileURLWithPath:path];
                                    return url;
                                }
                          completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                              //                                                                           [m_AllTask removeObject:dataTask];
                              if (successBlock)
                              {
                                  if (error == nil)
                                  {
                                      successBlock(ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS,@{@"message":@"下载完成",
                                                                                           @"filePath":filePath.absoluteString});
                                  }
                                  else
                                  {//下载失败的时候，只列举判断了两种错误状态码
                                      NSString * message = nil;
                                      if (error.code == - 1005) {
                                          message = @"网络异常";
                                      }else if (error.code == -1001){
                                          message = @"请求超时";
                                      }else if (error.code == -1011){
                                          message = @"文件已过期";
                                      }else{
                                          message = @"未知错误";
                                      }
                                      successBlock(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,message);
                                      if (filePath && filePath.absoluteString.length > 0)
                                      {
                                          [[NSFileManager defaultManager] removeItemAtURL:filePath error:nil];
                                      }
                                  }
                              }
                          }];
    [dataTask resume];
}

@end
