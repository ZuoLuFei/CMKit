//
//  CMImagePickerManager.m
//  CMWQDemo
//
//  Created by yons on 16/10/25.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "CMImagePickerManager.h"
@import AVFoundation;
@import AssetsLibrary;
@import Photos;


@interface CMImagePickerManager ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 图片选择完成回调的block*/
@property(nonatomic, copy)ImageDidFinishPickingMediaBlock imageInfoBlock;
@end

@implementation CMImagePickerManager
/**
 * 单例
 */
static CMImagePickerManager *_CMImagePickerManager = nil;
+ (instancetype)sharedCMImagePickerManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CMImagePickerManager = [[CMImagePickerManager alloc] init];
    });
    return _CMImagePickerManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CMImagePickerManager = [super allocWithZone:zone];
    });
    return _CMImagePickerManager;
}

/**
 * 打开相册
 */
- (void)showPhotoLibraryWithViewController:(UIViewController *)viewController handler:(ImageDidFinishPickingMediaBlock)imageInfoBlock {
    //缓存block
    self.imageInfoBlock = imageInfoBlock;
    //是否授权访问相册

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        
        PHAuthorizationStatus author =  [PHPhotoLibrary authorizationStatus];
        if (author == PHAuthorizationStatusRestricted ||author == PHAuthorizationStatusDenied) {
            //弹出警告
            [self showAlertOnController:viewController];
        }else {
            //打开相册
            [self imagePickerOnViewController:viewController soureType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        
    }else{
    
        
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted ||author == ALAuthorizationStatusDenied) {
            //弹出警告
            [self showAlertOnController:viewController];
        }else {
            //打开相册
            [self imagePickerOnViewController:viewController soureType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }
}


/**
 * 打开相机
 */
- (void)showCameraWithViewController:(UIViewController *)viewController handler:(ImageDidFinishPickingMediaBlock)imageInfoBlock {
    //缓存block
    self.imageInfoBlock = imageInfoBlock;
    //是否授权访问相机
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        //弹出警告
        [self showAlertOnController:viewController];
    } else {
#if TARGET_IPHONE_SIMULATOR
        NSLog(@"当前为模拟器");
        [MBProgressHUD showError:@"模拟器无法打开相机"];
#elif TARGET_OS_IPHONE
        //打开相机
        [self imagePickerOnViewController:viewController soureType:UIImagePickerControllerSourceTypeCamera];
#endif
    }
}


#pragma mark UIImagePickerViewDelegate
// 拍照|选择图片后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (info) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        self.imageInfoBlock(image);
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
// 点中取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -Private
//打开imagePicker
- (void)imagePickerOnViewController:(UIViewController *)viewController soureType:(UIImagePickerControllerSourceType)soureType {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.sourceType = soureType;
    [viewController presentViewController:picker animated:YES completion:nil];
}

//弹出警告框
- (void)showAlertOnController:(UIViewController *)viewController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无相机访问权限"
                                                                   message:@"请在设备的 设置-隐私-相机 中允许访问相机"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                   }];
    
    [alert addAction:action];
    
    [viewController presentViewController:alert animated:YES completion:nil];
    
}
@end
