//
//  BaseViewController.h
//  uavsystem
//
//  Created by zhang_jian on 16/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
{
    UIButton *m_RightBtn;
}
@property (nonatomic) BOOL showback;    
@property (nonatomic) BOOL ShowBackButton;

-(UILabel *)setNavTarBarTitle:(id)title;

-(id)loadViewController:(NSString *)viewController;

-(id)loadViewController:(NSString *)viewController hidesBottomBarWhenPushed:(BOOL)ishide;

-(id)loadViewController:(NSString *)viewController hidesBottomBarWhenPushed:(BOOL)ishide isNowPush:(BOOL)isPush;

-(UIButton *)setLeftItemWithContentName:(NSString *)name;

- (void)setLeftItemWithContentName:(NSString *)name imageName:(nullable NSString *)imageName;

-(UIButton *)setRightItemWithContentName:(NSString *)name;

- (void)setRightItemWithContentName:(NSString *)name imageName:(nullable NSString *)imageName;

-(void)setRightItemsWithContentNames:(NSArray *)names;

//reload in subClass
-(void)backBarButtonItemAction:(UIButton *)btn;

-(void)leftBarButtonItemAction:(UIButton *)btn;

-(void)rightBarButtonItemAction:(UIButton *)btn;

- (void)setNavBarBackGroundColor:(NSString *)hexColor;

- (void)setStatusBarBackgroundColor:(UIColor *)color;

@end
NS_ASSUME_NONNULL_END
