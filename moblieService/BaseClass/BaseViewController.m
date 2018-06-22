//
//  BaseViewController.m
//  uavsystem
//
//  Created by zhang_jian on 16/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseViewController.h"


UIKIT_STATIC_INLINE UIImage *imageWithColor(UIColor *color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, DIF_SCREEN_WIDTH, DIF_TOP_POINT);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.ShowBackButton = YES;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIView setAnimationsEnabled:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.interactivePopGestureRecognizer setEnabled:NO];
    
    [self.view setBackgroundColor:[CommonTool colorWithHexString:DIF_TABLEVIEW_BACKGROUNDCOLOR Alpha:1]];
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    if(is_IOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
        
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)] )
    {
        [self setNavBarBackGroundColor:@"ffffff"]; 
    }
    
    [self setNavTarBarTitle:self.navigationItem.title];
    
    if (self.ShowBackButton)
    {
//        [self setBackItem];
        [self setLeftItemWithContentName:@"" imageName:@"ic_back"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view setHidden:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view setHidden:YES];
    [super viewWillDisappear:animated];
}

- (void)setNavBarBackGroundColor:(NSString *)hexColor
{
    CGFloat alpha = 1;
    if ([hexColor isEqualToString:@"#000000"])
    {
        alpha = 0;
    }
    UIImage *image = imageWithColor([self colorWithHexString:hexColor Alpha:alpha]);
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark interface
-(UILabel *)setNavTarBarTitle:(id)title
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((DIF_SCREEN_WIDTH-100)/2.0, 0,100,44)];
    if ([title isKindOfClass:[NSAttributedString class]])
    {
        [lab setAttributedText:(NSAttributedString *)title];
        self.navigationItem.title = [(NSAttributedString *)title string];
    }
    else
    {
        [lab setTextColor:DIF_HEXCOLOR(@"#25313F")];
        self.navigationItem.title = title;
        [lab setText:title];
    }
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setFont:DIF_DIFONTOFSIZE(17)];
    [self.navigationItem setTitleView:lab];
    return lab;
}

-(id)loadViewController:(NSString *)viewController
{
    return [self loadViewController:viewController hidesBottomBarWhenPushed:NO];
}

-(id)loadViewController:(NSString *)viewController hidesBottomBarWhenPushed:(BOOL)ishide
{
    return [self loadViewController:viewController hidesBottomBarWhenPushed:ishide isNowPush:YES];
}

-(id)loadViewController:(NSString *)viewController hidesBottomBarWhenPushed:(BOOL)ishide isNowPush:(BOOL)isPush
{
    UIViewController *vc = [[NSClassFromString(viewController) alloc]init];
    if (!vc)
    {
        return nil;
    }
    DIF_HideTabBarAnimation(ishide)
    [self.tabBarController.tabBar setHidden:ishide];
    if (isPush)
    {
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    return vc;
}

-(void)setBackItem
{
    UIImage *btnImage = [UIImage imageNamed:@"bottom_left"];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, btnImage.size.width, btnImage.size.height)];
    [leftBtn setImage:[btnImage stretchableImageWithLeftCapWidth:2 topCapHeight:2] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(UIButton *)setLeftItemWithContentName:(NSString *)name
{
    UIImage *btnImage = [UIImage imageNamed:name];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (btnImage)
    {
        [leftBtn setFrame:CGRectMake(0, 0, btnImage.size.width<DIF_PX(60)?DIF_PX(60):btnImage.size.width, btnImage.size.height)];
        [leftBtn setImage:btnImage forState:UIControlStateNormal];
    }
    else
    {
        CGSize size = [name sizeWithAttributes:@{NSFontAttributeName: DIF_DIFONTOFSIZE(16)}];
        [leftBtn setFrame:CGRectMake(0, 0, size.width<DIF_PX(60)?DIF_PX(60):size.width, DIF_PX(30))];
        [leftBtn setTitle:name forState:UIControlStateNormal];
        [leftBtn setTitleColor:DIF_HEXCOLOR(@"#333333") forState:UIControlStateNormal];
        [leftBtn.titleLabel setFont:DIF_DIFONTOFSIZE(16)];
        [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, size.width-leftBtn.frame.size.width, 0, 0)];
    }
    [leftBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    return leftBtn;
}

-(UIButton *)setRightItemWithContentName:(NSString *)name
{
    if (!name)
    {
        self.navigationItem.rightBarButtonItem = nil;
        return nil;
    }
    UIImage *btnImage = [UIImage imageNamed:name];
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    if (btnImage)
    {
        [rightBut setFrame:CGRectMake(0, 0, btnImage.size.width<DIF_PX(60)?DIF_PX(60):btnImage.size.width, btnImage.size.height)];
        [rightBut setImage:btnImage forState:UIControlStateNormal];
        [rightBut setImageEdgeInsets:UIEdgeInsetsMake(0,  (rightBut.frame.size.width - btnImage.size.width), 0, 0)];
    }
    else
    {
        CGSize size = [name sizeWithAttributes:@{NSFontAttributeName:DIF_DIFONTOFSIZE(16)}];
        [rightBut setFrame:CGRectMake(0, 0, size.width<DIF_PX(60)?DIF_PX(60):(DIF_PX(25)*((int)size.width/16)), DIF_PX(30))];
        [rightBut setTitle:name forState:UIControlStateNormal];
        [rightBut setTitleColor:DIF_HEXCOLOR(@"#CED2D6") forState:UIControlStateNormal];
        [rightBut.titleLabel setFont:DIF_DIFONTOFSIZE(16)];
        [rightBut setTitleEdgeInsets:UIEdgeInsetsMake(0, (rightBut.frame.size.width - size.width), 0, 0)];
    }
    [rightBut addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightItem;
    m_RightBtn = rightBut;
    return rightBut;
}

-(void)setRightItemsWithContentNames:(NSArray *)names
{
    NSMutableArray *btnArr = [NSMutableArray array];
    for (int i = 0; i < names.count; i++)
    {
        NSString *name = names[i];
        UIImage *btnImage = [UIImage imageNamed:name];
        UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBut setTag:50010+i];
        if (btnImage)
        {
            [rightBut setFrame:CGRectMake(0, 0, btnImage.size.width, btnImage.size.height)];
            [rightBut setImage:btnImage forState:UIControlStateNormal];
        }
        else
        {
            CGSize size = [name sizeWithAttributes:@{NSFontAttributeName:DIF_DIFONTOFSIZE(16)}];
            [rightBut setFrame:CGRectMake(0, 0, size.width<DIF_PX(60)?DIF_PX(60):size.width, DIF_PX(30))];
            [rightBut setTitle:name forState:UIControlStateNormal];
        }
        [rightBut addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
        [btnArr addObject:rightItem];
    }
    [self.navigationItem setRightBarButtonItems:btnArr];
}

-(void)backBarButtonItemAction:(UIButton *)btn
{
    //reload in subclass
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)leftBarButtonItemAction:(UIButton *)btn
{
    //reload in subclass
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBarButtonItemAction:(UIButton *)btn
{
    //reload in SubClass
}

- (void)setLeftItemWithContentName:(NSString *)name imageName:(nullable NSString *)imageName
{
	UIImage *btnImage = [UIImage imageNamed:imageName];
	UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	CGSize size = CGSizeZero;
	if (name)
    {
		size = [name sizeWithAttributes:@{NSFontAttributeName: DIF_DIFONTOFSIZE(16)}];
	}
	leftBtn.titleLabel.font = DIF_DIFONTOFSIZE(16);
	[leftBtn setTitle:name forState:UIControlStateNormal];
	[leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(0, 0, size.width<DIF_PX(60)?DIF_PX(60):size.width, DIF_PX(30))];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, size.width-leftBtn.frame.size.width, 0, 0)];
	if (btnImage)
    {
		[leftBtn setFrame:CGRectMake(0, 0, btnImage.size.width, btnImage.size.height)];
		[leftBtn setImage:btnImage forState:UIControlStateNormal];
		[leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        size.width += btnImage.size.width + DIF_PX(10);
        [leftBtn setFrame:CGRectMake(0, 0, size.width<DIF_PX(60)?DIF_PX(60):size.width, DIF_PX(30))];
        [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, DIF_PX(10), 0, 0)];
	}
	[leftBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
	self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setRightItemWithContentName:(NSString *)name imageName:(nullable NSString *)imageName
{
	UIImage *btnImage = [UIImage imageNamed:imageName];
	UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
	UIFont *font = [UIFont systemFontOfSize:16];
	CGSize size = CGSizeZero;
	if (name) {
		size = [name sizeWithAttributes:@{NSFontAttributeName: font}];
	}
	rightBut.titleLabel.font = font;
	[rightBut setTitle:name forState:UIControlStateNormal];
	[rightBut setTitleColor:DIF_HEXCOLOR(@"151515") forState:UIControlStateNormal];
	if (btnImage){
		[rightBut setFrame:CGRectMake(0, 0, btnImage.size.width, btnImage.size.width)];
		[rightBut setImage:btnImage forState:UIControlStateNormal];
		[rightBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
	}else{
		[rightBut setFrame:CGRectMake(0, 0, size.width < 50 ? 50:size.width, 30)];
	}
	[rightBut addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
	self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (UIImage*) imageWithColor:(UIColor*)color
//{
//    CGRect rect = CGRectMake(0.0f, 0.0f, DIF_SCREEN_WIDTH, DIF_TOP_POINT);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}

- (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha
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

- (void)setStatusBarBackgroundColor:(UIColor *)color
{
    if ([color isEqual:DIF_HEXCOLOR(@"000000")])
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    else
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    //    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    //    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    //    {
    //        statusBar.backgroundColor = color;
    //    }
}

@end
