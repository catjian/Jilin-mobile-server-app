//
//  CommonTool.m
//  uavsystem
//
//  Created by zhang_jian on 16/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool

+(UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha
{
    NSString *cString=[[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if(cString.length<6)
    {
        return [UIColor clearColor];
    }
    
    if([cString hasPrefix:@"0X"])
    {
        cString=[cString substringFromIndex:2];
    }
    if([cString hasPrefix:@"#"])
    {
        cString=[cString substringFromIndex:1];
    }
    if(cString.length!=6)
    {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location=0;
    range.length=2;
    //r
    NSString *rString=[cString substringWithRange:range];
    //g
    range.location=2;
    NSString *gString=[cString substringWithRange:range];
    //b
    range.location=4;
    NSString *bString=[cString substringWithRange:range];
    
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
}

+ (UIView *)traverseSubView:(UIView *)view
{
    UIView *subView = view;
    for (UIView *viewSub in view.subviews)
    {
        subView = [CommonTool traverseSubView:viewSub];
    }
    return subView;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width>0?size.width:1, size.height>0?size.height:1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIView *)backViewWithFrame:(CGRect)frame ColorHexValue:(NSString *)color
{
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:frame];
    [backImage setImage:DIF_IMAGE_HEXCOLOR(color)];
    return backImage;
}

+ (NSURL *)urlWithString:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:path];
    if (!url)
    {
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        path = [path stringByTrimmingCharactersInSet:allowedCharacters];
//        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  用上面替代这个方法
        url = [NSURL URLWithString:path];
    }
    return url;
}

+ (NSString *)stringFromFormatUrl:(NSURL *)url
{
    NSString *urlstr = url.absoluteString;
    NSRange rangHttp = [urlstr rangeOfString:@"http://"];
    urlstr = [urlstr substringFromIndex:rangHttp.location+rangHttp.length];
    NSArray *urlArr = [urlstr componentsSeparatedByString:@"/"];
    NSMutableString *str = [NSMutableString string];
    for (NSString *one in urlArr)
    {
        [str appendString:one];
    }
    return str;
}

+ (CGFloat)scaleImageSizeWithBaseSize:(CGSize)baseSize ImageSize:(CGSize)imageSize
{
    CGFloat sale = 1;
    if (baseSize.width > imageSize.width && baseSize.height > imageSize.height)
    {
        sale = (baseSize.width/imageSize.width > baseSize.height/imageSize.height ?
                baseSize.height/imageSize.height:baseSize.width/imageSize.width);
    }
    if (baseSize.width < imageSize.width && baseSize.height < imageSize.height)
    {
        sale = (baseSize.width/imageSize.width > baseSize.height/imageSize.height ?
                baseSize.height/imageSize.height:baseSize.width/imageSize.width);
    }
    if (baseSize.width > imageSize.width && baseSize.height < imageSize.height)
    {
        sale = baseSize.height/imageSize.height;
    }
    if (baseSize.width < imageSize.width && baseSize.height > imageSize.height)
    {
        sale = baseSize.width/imageSize.width;
    }    
    return sale;
}

+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 6; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 6;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    CGSize maxSize=CGSizeMake(width, MAXFLOAT);
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

+ (void)addWindowPopView:(UIView *)popView
{
    UIView * alView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT)];
    alView.backgroundColor = [UIColor blackColor];
    alView.alpha = 0.36f;
    [DIF_APPDELEGATE.window.rootViewController.view addSubview:alView];
    [alView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)]];
    popView.frame = CGRectMake((DIF_SCREEN_WIDTH - popView.width)/2.f, (DIF_SCREEN_HEIGHT - popView.height)/2.f, popView.width, popView.height);
    [DIF_APPDELEGATE.window.rootViewController.view addSubview:popView];
    alView.tag = 999999;
    popView.tag = 888888;
}

+ (void)tapGestureAction
{
    [[DIF_KeyWindow viewWithTag:999999] removeFromSuperview];
    [[DIF_KeyWindow viewWithTag:888888] removeFromSuperview];
}

+ (void)writeHandleToLoactionFile:(NSString *)content FileName:(NSString *)fileName
{
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *homePath = [paths objectAtIndex:0];
    
    NSString *filePath = [homePath stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:filePath]) //如果不存在
    {
        [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    
    [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
    
    NSData* stringData  = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileHandle writeData:stringData]; //追加写入数据
    
    [fileHandle closeFile];
}

+ (NSString *)writeToLoactionFile:(NSString *)content FileName:(NSString *)fileName
{
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *homePath = [paths objectAtIndex:0];
    NSArray *filenameArr = [fileName componentsSeparatedByString:@"/"];
    if (filenameArr.count > 1)
    {
        NSMutableString *cusFilePath = [NSMutableString string];
        for (int i = 0; i < filenameArr.count-1; i++)
        {
            NSString *pathOne = filenameArr[i];
            if (!pathOne || pathOne.length <= 0)
            {
                continue;
            }
            [cusFilePath appendFormat:@"/%@",pathOne];
        }
        homePath = [homePath stringByAppendingPathComponent:cusFilePath];
        if(![[NSFileManager defaultManager] fileExistsAtPath:homePath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:homePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return filePath;
}

+ (id)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id jsonRsp = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return jsonRsp;
}

@end
