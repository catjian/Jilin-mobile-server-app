
#import "CommonCurrentUser.h"

@implementation CommonCurrentUser

@synthesize phone = _phone;
@synthesize password = _password;
@synthesize wareaId = _wareaId;
@synthesize staffId = _staffId;
@synthesize userName = _userName;
@synthesize wareaName = _wareaName;
@synthesize autoLogin = _autoLogin;
@synthesize serviceHost = _serviceHost;
@synthesize servicePort = _servicePort;
@synthesize serviceName = _serviceName;
@synthesize pageSize = _pageSize;

+ (CommonCurrentUser *)sharedInstance
{    
    static CommonCurrentUser *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CommonCurrentUser alloc] init];
    });
    return _sharedInstance;
}

- (NSString *)phone
{
    if (!_phone)
    {
        _phone = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginPhone"];
    }
    return _phone;
}

- (void)setPhone:(NSString *)phone
{
    _phone = phone;
    [[NSUserDefaults standardUserDefaults] setObject:_phone forKey:@"loginPhone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)password
{
    if (!_password)
    {
        _password = [[NSUserDefaults standardUserDefaults] stringForKey:@"UserPassword"];
    }
    return _password;
}

- (void)setPassword:(NSString *)password
{
    _password = password;
    [[NSUserDefaults standardUserDefaults] setObject:_password forKey:@"UserPassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)wareaId
{
    if (!_wareaId)
    {
        _wareaId = [[NSUserDefaults standardUserDefaults] stringForKey:@"Warea_Id"];
    }
    return _wareaId;
}

- (void)setWareaId:(NSString *)wareaId
{
    _wareaId = wareaId;
    [[NSUserDefaults standardUserDefaults] setObject:wareaId forKey:@"Warea_Id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)staffId
{
    if (!_staffId)
    {
        _staffId = [[NSUserDefaults standardUserDefaults] stringForKey:@"Staff_Id"];
    }
    return _staffId;
}

- (void)setStaffId:(NSString *)staffId
{
    _staffId = [staffId isKindOfClass:[NSNumber class]]?[(NSNumber*)staffId stringValue]:staffId;
    [[NSUserDefaults standardUserDefaults] setObject:staffId forKey:@"Staff_Id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userName
{
    if (!_userName)
    {
        _userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Name"];
    }
    return _userName;
}

- (void)setUserName:(NSString *)userName
{
    _userName = userName;
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"User_Name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)wareaName
{
    if (!_wareaName)
    {
        _wareaName = [[NSUserDefaults standardUserDefaults] stringForKey:@"Warea_Name"];
    }
    return _wareaName;
}

- (void)setWareaName:(NSString *)wareaName
{
    _wareaName = wareaName;
    [[NSUserDefaults standardUserDefaults] setObject:wareaName forKey:@"Warea_Name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)autoLogin
{
    if (!_autoLogin)
    {
        _autoLogin = [[NSUserDefaults standardUserDefaults] stringForKey:@"autoLogin"];
    }
    return _autoLogin;
}

- (void)setAutoLogin:(NSString *)autoLogin
{
    _autoLogin = autoLogin;
    [[NSUserDefaults standardUserDefaults] setObject:autoLogin forKey:@"autoLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)serviceHost
{
    if (!_serviceHost)
    {
        _serviceHost = [[NSUserDefaults standardUserDefaults] stringForKey:@"serviceHost"];
    }
    if (!_serviceHost || _serviceHost.length <= 0)
    {
//        _serviceHost = @"222.163.24.42";    //http
        _serviceHost = @"www.jlxxxfw.cn";   //https
    }
    return _serviceHost;
}

- (void)setServiceHost:(NSString *)serviceHost
{
    _serviceHost = serviceHost;
    [[NSUserDefaults standardUserDefaults] setObject:serviceHost forKey:@"serviceHost"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)servicePort
{
    if (!_servicePort)
    {
        _servicePort = [[NSUserDefaults standardUserDefaults] stringForKey:@"servicePort"];
    }
    if (!_servicePort || _servicePort.length <= 0)
    {
//        _servicePort = @"9088";   //http
        _servicePort = @"8443";     //https
    }
    return _servicePort;
}

- (void)setServicePort:(NSString *)servicePort
{
    _servicePort = servicePort;
    [[NSUserDefaults standardUserDefaults] setObject:servicePort forKey:@"servicePort"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)serviceName
{
    if (!_serviceName)
    {
        _serviceName = [[NSUserDefaults standardUserDefaults] stringForKey:@"serviceName"];
    }
    if (!_serviceName || _serviceName.length <= 0)
    {
        _serviceName = @"ccps";
    }
    return _serviceName;
}

- (void)setServiceName:(NSString *)serviceName
{
    _serviceName = serviceName;
    [[NSUserDefaults standardUserDefaults] setObject:serviceName forKey:@"serviceName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)pageSize
{
    if (!_pageSize)
    {
        _pageSize = [[NSUserDefaults standardUserDefaults] stringForKey:@"pageSize"];
    }
    if (!_pageSize)
    {
        _pageSize = @"10";
    }
    return _pageSize;
}

- (void)setPageSize:(NSString *)pageSize
{
    _pageSize = pageSize;
    [[NSUserDefaults standardUserDefaults] setObject:pageSize forKey:@"pageSize"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
