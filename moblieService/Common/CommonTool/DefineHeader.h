//
//  DefineHeader.h
//  uavsystem
//
//  Created by zhang_jian on 16/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h


#define DIF_Async_Main_Queue(block) dispatch_async(dispatch_get_main_queue(), block)

#ifndef is_IOS7
#define is_IOS7     ([[UIDevice currentDevice].systemVersion intValue] >= 7?YES:NO)
#endif

#ifndef is_IOS10
#define is_IOS10    ([[UIDevice currentDevice].systemVersion intValue] >= 10?YES:NO)
#endif

#ifndef is_iPhone4
#define is_iPhone4  (([[UIScreen mainScreen]bounds].size.height-568) < 0?YES:NO)
#endif
#ifndef is_iPhone5
#define is_iPhone5  (([[UIScreen mainScreen]bounds].size.height-568) == 0?YES:NO)
#endif
#ifndef is_iPhone5AndEarly
#define is_iPhone5AndEarly  (([[UIScreen mainScreen]bounds].size.height-568) <= 0?YES:NO)
#endif

#ifndef is_iPhone6
#define is_iPhone6  (([[UIScreen mainScreen]bounds].size.height-667) == 0 ?YES:NO)
#endif

#ifndef is_iPhone6P
#define is_iPhone6P  (([[UIScreen mainScreen]bounds].size.height-667) > 0 ?YES:NO)
#endif

#ifndef is_iPad
#define is_iPad     ([[UIDevice currentDevice].model rangeOfString:@"iPad"].length>0?YES:NO)
#endif

#ifndef is_iPHONE_X
#define is_iPHONE_X     (([[UIScreen mainScreen]bounds].size.height == 812.0f) ? YES : NO)
#define Height_NavBar   ((is_iPHONE_X==YES)?88.0f: 64.0f)
#endif

#ifndef DIF_TOP_POINT
#define DIF_TOP_POINT   (is_IOS7?64:0)
#endif

#ifndef DIF_SCREEN_BOUNDS
#define DIF_SCREEN_BOUNDS   CGRectMake(0,0,DIF_SCREEN_WIDTH,DIF_SCREEN_HEIGHT)
#endif
#ifndef DIF_SCREEN_WIDTH
#define DIF_SCREEN_WIDTH    ([[UIScreen mainScreen]bounds].size.width)
#endif
#ifndef DIF_SCREEN_HEIGHT
#define DIF_SCREEN_HEIGHT   ([[UIScreen mainScreen]bounds].size.height)
#endif
#ifndef DIF_SCREEN_CENTER
#define DIF_SCREEN_CENTER   CGPointMake(DIF_SCREEN_WIDTH/2, DIF_SCREEN_HEIGHT/2)
#endif

#ifndef DIF_IOS_VERSION
#define DIF_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue] //获得iOS版本
#endif

#ifndef DIF_AUTO_WIDTH
#define DIF_AUTO_WIDTH(s)   ((s)*DIF_SCREEN_WIDTH/414)
#endif

#ifndef DIF_SandBox_Path
#define DIF_SandBox_Path(directory) [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject]
#endif

#ifdef DEBUG_MODE
#define DebugLog(s,...) if(1)\
                        {\
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
                            [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
                            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];\
                            printf("\nDebugLog ->->->-> %s \n文件：%s \n方法名：%s\n第%d \n>---Begin---> \n%s\n>---End--->\n",\
                                    [dateString UTF8String],\
                                    [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],\
                                    [[NSString stringWithUTF8String:__FUNCTION__] UTF8String],\
                                    __LINE__,\
                                    [[NSString stringWithFormat:(s),##__VA_ARGS__] UTF8String]);\
                        }
#else
#define DebugLog(s,...)
#endif

#ifdef DEBUG_MODE
#define InfoLog(s,...)  if(0)\
                        {\
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
                            [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
                            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];\
                            printf("\nInfoLog ->->->-> %s \n文件：%s \n方法名：%s\n第%d \n>---Begin---> \n%s\n>---End--->\n",\
                                    [dateString UTF8String],\
                                    [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],\
                                    [[NSString stringWithUTF8String:__FUNCTION__] UTF8String],\
                                    __LINE__,\
                                    [[NSString stringWithFormat:(s),##__VA_ARGS__] UTF8String]);\
                        }
#else
#define InfoLog(s,...)
#endif

#ifdef DEBUG_MODE
#define ErrorLog(s,...) if(1)\
                        {\
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
                            [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
                            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];\
                            printf("\nErrorLog ->->->-> %s \n文件：%s \n方法名：%s\n第%d \n>---Begin---> \n%s\n>---End--->\n",\
                                    [dateString UTF8String],\
                                    [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],\
                                    [[NSString stringWithUTF8String:__FUNCTION__] UTF8String],\
                                    __LINE__,\
                                    [[NSString stringWithFormat:(s),##__VA_ARGS__] UTF8String]);\
                        }
#else
#define ErrorLog(s,...)
#endif

#ifdef DEBUG_MODE
#define WriteLocalLog(s,...)    if(1)\
                                {\
DebugLog((s),##__VA_ARGS__)\
                                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
                                    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
                                    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];\
                                    NSString *content = [NSString stringWithFormat:@"\n->->->-> %@ \n文件：%@ \n方法名：%@\n第%d \n>---Begin---> \n%@\n>---End--->\n",\
                                    dateString, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], [NSString stringWithUTF8String:__FUNCTION__] ,\
                                    __LINE__, [NSString stringWithFormat:(s),##__VA_ARGS__]];\
                                    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);\
                                    NSString *homePath = [paths objectAtIndex:0];\
                                    NSString *filePath = [homePath stringByAppendingPathComponent:@"WriteLocalLog.txt"];\
                                    NSFileManager *fileManager = [NSFileManager defaultManager];\
                                    if(![fileManager fileExistsAtPath:filePath]) \
                                    {\
                                        [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];\
                                    }\
                                    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];\
                                    [fileHandle seekToEndOfFile];  \
                                    NSData* stringData  = [content dataUsingEncoding:NSUTF8StringEncoding];\
                                    [fileHandle writeData:stringData]; \
                                    [fileHandle closeFile];\
                                }
#else
#define WriteLocalLog(s,...)
#endif

#ifndef DIF_APPDELEGATE
#define DIF_APPDELEGATE [AppDelegate sharedAppDelegate]
#endif
#ifndef DIF_MENU
#define DIF_MENU DIF_APPDELEGATE.sideMenu
#endif
#ifndef DIF_KeyWindow
#define DIF_KeyWindow [UIApplication sharedApplication].keyWindow
#endif
#ifndef DIF_TabBar
#define DIF_TabBar DIF_APPDELEGATE.baseTB
#endif

#ifndef DIF_ShowTabBarAnimation
#define DIF_ShowTabBarAnimation(isAnimation) [DIF_TabBar showTabBarViewControllerIsAnimation:isAnimation];
#endif
#ifndef DIF_HideTabBarAnimation
#define DIF_HideTabBarAnimation(isAnimation) [DIF_TabBar hideTabBarViewControllerIsAnimation:isAnimation];
#endif

#ifndef DIF_Weak_Strong_Self
#define DIF_WeakSelf(s) __weak typeof(s) weakSelf = s;
#define DIF_StrongSelf if(!weakSelf){\
                            [CommonHUD hideHUD];\
                            return ;\
                        }\
                        __strong typeof(weakSelf) strongSelf = weakSelf;
#endif

#ifndef DIF_TopViewController
typedef UIViewController *(^GetTopViewControllerBlock)(void);
#define DIF_TopViewControllerBlock ^UIViewController *(void){\
UINavigationController *nvc = [DIF_APPDELEGATE.baseTB.viewControllers objectAtIndex:DIF_APPDELEGATE.baseTB.selectedIndex];\
BaseViewController *bvc = (BaseViewController *)nvc.topViewController;\
return bvc;}
#define DIF_TopViewController DIF_TopViewControllerBlock()
#endif

#ifndef DIF_COMMON_ANIMATION
#define DIF_COMMON_ANIMATION [CommonAnimation sharedCommonAnimation]
#endif

#define DIF_IMAGE_HEXCOLOR(s) [CommonTool imageWithColor:[CommonTool colorWithHexString:s Alpha:1] size:CGSizeMake(1.0f, 1.0f)]
#define DIF_IMAGE_HEXCOLOR_ALPHA(s,a) [CommonTool imageWithColor:[CommonTool colorWithHexString:s Alpha:a] size:CGSizeMake(1.0f, 1.0f)]

#define DIF_USERLOCATION [DIF_APPDELEGATE userLocation]

#define DIF_HEXCOLOR(s)             [CommonTool colorWithHexString:s Alpha:1]
#define DIF_HEXCOLOR_ALPHA(s,a)     [CommonTool colorWithHexString:s Alpha:a]

#pragma mark - 颜色
#define DIF_NORMAL_THEME_COLOR @"#1D1F24"

#define DIF_USER_TEXTCOLOR @"#3c3c3c"

#define DIF_TABLEVIEW_BACKGROUNDCOLOR @"#f1f2f4"

#define DIF_CELL_SEPARATOR_COLOR @"#cfd0d0"

#define DIF_PHONE_COLOR @"#0072fe"

#define DIF_BACK_ORANGE_COLOR @"#ff7900"
#define DIF_BACK_BLUE_COLOR @"#1a99ff"

#ifndef DIF_BASE_COLOR
#define DIF_BASE_COLOR [CommonTool colorWithHexString:DIF_NORMAL_THEME_COLOR Alpha:1]
#endif

#ifndef DIF_GET_APPICON
#define DIF_GET_APPICON [[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]
#endif

#ifndef DIF_FONT
#define DIF_PX(s)                   (round(((s))*DIF_SCREEN_WIDTH/375))
#define DIF_FONT_6(s)               (round(((s)/2.f)))
#define DIF_FONT(s)                 round((is_iPhone6P?(DIF_FONT_6(s)*1.1):(DIF_FONT_6(s))))
#define DIF_UIFONTOFSIZE(s)         [UIFont systemFontOfSize:(s)]
#define DIF_DIFONTOFSIZE(s)         [UIFont systemFontOfSize:DIF_FONT(((s)*2))]
#endif

#define DIF_BaseFont_Size 28

#define DIF_Request_NET_ERROR @"网络错误"

#define DIF_ReviewCamareAuthorizationStatus \
{AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];\
    if (authStatus ==AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) \
    {\
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"相机不可用"\
        message:@"请在设置中允许访问你的相机"\
        delegate:nil\
        cancelButtonTitle:@"确定"\
        otherButtonTitles:nil, nil];\
        [alertView show];\
        return;\
    }\
}

#define DIF_ReviewLibraryAuthorizationStatus \
{ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];\
    if (authStatus == kCLAuthorizationStatusRestricted || authStatus == kCLAuthorizationStatusDenied) \
    {\
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"相册不可用"\
        message:@"请在设置中允许访问你的相册"\
        delegate:nil\
        cancelButtonTitle:@"确定"\
        otherButtonTitles:nil, nil];\
        [alertView show];\
        return;\
    }\
}

#define DIF_ReviewAudioAuthorizationStatus \
{AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];\
    if (authStatus ==AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) \
    {\
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"麦克风不可用"\
        message:@"请在设置中允许访问你的麦克风"\
        delegate:nil\
        cancelButtonTitle:@"确定"\
        otherButtonTitles:nil, nil];\
        [alertView show];\
        return NO; \
    }\
}

#define DIF_ReviewLocationAuthorizationStatus \
{CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];\
    if (authStatus == kCLAuthorizationStatusRestricted || authStatus == kCLAuthorizationStatusDenied) \
    {\
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"位置服务不可用"\
        message:@"请在设置中允许访问你的位置"\
        delegate:nil\
        cancelButtonTitle:@"确定"\
        otherButtonTitles:nil, nil];\
        [alertView show];\
        return;\
    }\
}

#define DIF_Key_Picture(s1,s2) [NSString stringWithFormat:@"%@%@-picture",s1,s2]
#define DIF_Key_Remark(s1,s2) [NSString stringWithFormat:@"%@%@-remark",s1,s2]
#define DIF_Key_Field(s1,s2) [NSString stringWithFormat:@"%@%@-field",s1,s2]

#ifndef DIF_POP_TO_LOGIN
#define DIF_POP_TO_LOGIN [DIF_APPDELEGATE showLoginVC];
#endif

//是校正过
#ifndef DIF_Is_Corrected
#define DIF_Is_Corrected (([CommonMemonyCache MemoneyCacherReadWithKeyValue:DIF_MemonyCache_Key_CorrectNumber] && [[CommonMemonyCache MemoneyCacherReadWithKeyValue:DIF_MemonyCache_Key_CorrectNumber] length] > 0 && [[CommonMemonyCache MemoneyCacherReadWithKeyValue:DIF_MemonyCache_Key_CorrectNumber] componentsSeparatedByString:@","].count == 2)?YES:NO )
#endif

#ifndef DIF_NavigationControlls_ViewController_Count
typedef int (^GetNavigationControllsViewControllerCountBlock)(void);
#define DIF_NavigationControlls_ViewController_Count_Block(VCName) ^int(void){\
int vcCount = 0;\
for (UIViewController *vc in self.navigationController.viewControllers) { \
    if ([NSStringFromClass(vc.class) isEqualToString:VCName]) {\
        vcCount++;\
    }\
}\
return vcCount;}
#define DIF_NavigationControlls_ViewController_Count(s) DIF_NavigationControlls_ViewController_Count_Block(s)()
#endif


typedef NS_ENUM(NSUInteger, enum_survey_event) {
    enum_survey_event_mapStart,
    enum_survey_event_back,
    enum_survey_event_new,
    enum_survey_event_save,
    enum_survey_event_edit,
    enum_survey_event_delete,
    enum_survey_event_rename,
    enum_survey_event_upload,
    enum_survey_event_Calibration,
    enum_survey_event_cancel,
    enum_survey_event_use_CalibrationData,
    enum_survey_event_NoUseAndUpdate,
    enum_survey_event_Refresh_FieldList
};



typedef NS_ENUM(NSUInteger, Enum_MapEdit_Button_Event) {
    Enum_MapEdit_Button_Event_close = 0,
    Enum_MapEdit_Button_Event_clean,
    Enum_MapEdit_Button_Event_addPoint,
    Enum_MapEdit_Button_Event_repeal,
    Enum_MapEdit_Button_Event_add,
    Enum_MapEdit_Button_Event_native_edit,
    Enum_MapEdit_Button_Event_native_pic,
    Enum_MapEdit_Button_Event_native_start,
    Enum_MapEdit_Button_Event_native_end,
    Enum_MapEdit_Button_Event_start
};

#endif /* DefineHeader_h */
