//
//  CommonPictureSelect.m
//  uavsystem
//
//  Created by zhang_jian on 16/7/7.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonPictureSelect.h"

#ifndef DIF_PictureSelect_BtnTitles
#define DIF_PictureSelect_BtnTitles @[@"拍照", @"从相册选择", @"取消"]
#endif

CommonPictureSelect *picSel = nil;
const CGFloat btnBackView_height = 150;

@interface CommonPictureSelect () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation CommonPictureSelect
{
    BOOL isShowController;
    UIViewController *m_VC;
    
    CommonPictureSelectResponse m_Block;
}

+ (CommonPictureSelect *)sharedPictureSelect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picSel = [[CommonPictureSelect alloc] initWithFrame:CGRectZero];
    });
    return picSel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
//        [self setTop:self.height];
        [self setBackgroundColor:[UIColor colorWithRed:0.7556 green:0.7556 blue:0.7556 alpha:0.4]];
        [self setAlpha:0];
        [self initSelectView];
    }
    return self;
}

- (void)initSelectView
{
    __weak typeof(self) weakSelf = self;
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(btnBackView_height);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).offset(is_iPHONE_X?-39:0);
    }];
    
    [DIF_PictureSelect_BtnTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(5, 10+idx*(45), DIF_SCREEN_WIDTH-10, 40)];
        [btn.layer setCornerRadius:5];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setBackgroundColor:(idx == 2?[UIColor colorWithRed:0.9889 green:0.3876 blue:0.0315 alpha:1.0] : DIF_HEXCOLOR(DIF_BACK_BLUE_COLOR))];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTag:idx+100];
        [btn addTarget:weakSelf action:@selector(SelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }];
}

- (void)showWithViewController:(UIViewController *)vc ResponseBlock:(CommonPictureSelectResponse)block
{
    m_VC = vc;
    m_Block = block;
    [DIF_APPDELEGATE.window addSubview:self];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf setAlpha:1];
    }];
}

- (void)hide
{
    m_VC = nil;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf setAlpha:0];
    } completion:^(BOOL finished) {
        DIF_StrongSelf
        if (!strongSelf->isShowController)
        {
            [strongSelf removeFromSuperview];
        }
    }];
}

- (void)SelectButtonAction:(UIButton *)btn
{
    isShowController = YES;
    switch (btn.tag-100)
    {
        case 0:
        {
            [self showCameraController];
        }
            break;
        case 1:
        {
            [self showPhotoLibraryController];
        }
            break;
        default:
        {
            isShowController = NO;
            if (m_Block)
            {
                m_Block(nil);
            }
        }
            break;
    }
    [self hide];
}

- (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)showCameraController
{
    DIF_ReviewCamareAuthorizationStatus;
    if ([self isCameraAvailable])
    {
        UIImagePickerController *cameraCon = [[UIImagePickerController alloc] init];
        [cameraCon setSourceType:UIImagePickerControllerSourceTypeCamera];
        [cameraCon setAllowsEditing:NO];
        [cameraCon setDelegate:self];
        UIViewController *vc = m_VC;
        [vc presentViewController:cameraCon animated:YES completion:^{
            
        }];
    }
    else
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:@"错误" Message:@"没有找到设备的摄像头" ButtonTitle:@"确定"];
    }
}

- (void)showPhotoLibraryController
{
    DIF_ReviewLibraryAuthorizationStatus;
    if ([self isPhotoLibraryAvailable])
    {
        UIImagePickerController *photoLibController = [[UIImagePickerController alloc] init];
        [photoLibController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [photoLibController setDelegate:self];
        UIViewController *vc = m_VC;
        [vc presentViewController:photoLibController animated:YES completion:^{
            
        }];
    }
    else
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:@"错误" Message:@"相册不可用" ButtonTitle:@"确定"];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (m_Block)
    {
        m_Block(nil);
    }
//    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
//        [weakSelf removeFromSuperview];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (m_Block)
    {
        m_Block(image);
    }
//    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
//        [weakSelf removeFromSuperview];
    }];
}

@end
