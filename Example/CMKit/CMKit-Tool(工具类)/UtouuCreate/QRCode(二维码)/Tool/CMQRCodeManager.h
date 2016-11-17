//
//  CMQRCodeManager.h
//  CMKit
//
//  Created by HC on 16/11/3.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

typedef void(^CaptureResponseBlock)(NSArray <AVMetadataMachineReadableCodeObject *> *metadataObjects);

@interface CMQRCodeManager : NSObject
#pragma mark - 单例构造方法
+ (instancetype)sharedCMQRCodeManager;


#pragma mark - 二维码/条形码生成
/**
 * 绘制基础二维码
 */
- (UIImageView *)creatQRCodeOnView:(UIImageView *)imageView WithURL:(NSString *)url;
/**
 * 绘制带logo二维码
 */
- (void)creatQRCodeOnView:(UIImageView *)imageView URL:(NSString *)url Logo:(NSString *)logoName;
/**
 * 绘制条形码
 */
- (void)creatBarCodeOnView:(UIImageView *)imageView WithURL:(NSString *)url;

#pragma mark - 二维码扫描
/**
 * 扫描
 */
- (void)scanCodeOnView:(UIViewController *)viewController handler:(CaptureResponseBlock)responseBlock;
/**
 * 取消扫描
 */
- (void)cancleSacn;


@end
