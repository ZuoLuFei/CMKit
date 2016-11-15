//
//  CMImagePickerManager.h
//  CMWQDemo
//
//  Created by yons on 16/10/25.
//  Copyright © 2016年 yons. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ImageDidFinishPickingMediaBlock)(UIImage *image);

@interface CMImagePickerManager : NSObject

@property (nonatomic, copy) void (^finishPickingPhotosWithInfosHandle)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,NSArray<NSDictionary *> *infos);



+ (instancetype)sharedCMImagePickerManager;
/**
 * 打开相册
 */
- (void)showPhotoLibraryWithViewController:(UIViewController *)viewController handler:(ImageDidFinishPickingMediaBlock)imageInfoBlock;
/**
 * 打开相机
 */
- (void)showCameraWithViewController:(UIViewController *)viewController handler:(ImageDidFinishPickingMediaBlock)imageInfoBlock;



@end
