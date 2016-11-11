//
//  CMQRCodeManager.m
//  CMKit
//
//  Created by HC on 16/11/3.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMQRCodeManager.h"
#import "CMAlertView.h"


@interface CMQRCodeManager ()<AVCaptureMetadataOutputObjectsDelegate>

/** 添加扫描功能的View */
@property (nonatomic, strong) UIView *scanView;
/** 添加扫描功能的ViewController */
@property (nonatomic, strong) UIViewController *scanViewController;

/** 连接输入流 和 输出流 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 用于展示输出流到界面的layer */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoLayer;
/** 二维码扫描成功的block*/
@property (nonatomic, copy)CaptureResponseBlock responseBlock;

/** 扫描框 */
@property (nonatomic, strong) UIImageView *backImgV;
/** 扫描线 */
@property (nonatomic, strong) UIImageView *lineImgV;


@property (nonatomic, assign) CGRect scanBorderRect;

@end

@implementation CMQRCodeManager

#pragma mark - 单例构造方法
/**
 * 单例
 */
static CMQRCodeManager *_CMQRCodeManager = nil;
+ (instancetype)sharedCMQRCodeManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CMQRCodeManager = [[CMQRCodeManager alloc] init];
    });
    return _CMQRCodeManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CMQRCodeManager = [super allocWithZone:zone];
    });
    return _CMQRCodeManager;
}


#pragma mark - 二维码/条形码生成
/**
 * 绘制基础二维码
 */
- (UIImageView *)creatQRCodeOnView:(UIImageView *)imageView WithURL:(NSString *)url {
    //创建一个二维码种类的路径
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认设置
    [filter setDefaults];
    //把一个网站字符串转换 二进制数据
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    //设置 滤镜 inputMessage 属性
    [filter setValue:data forKey:@"inputMessage"];
    //输出二维码图片
    CIImage *image = [filter outputImage];
    UIImage *QRCodeImage = [self excludeFuzzyImageFromCIImage:image size:imageView.frame.size.width];
    //设置imageView的图片
    imageView.image = QRCodeImage;
    
    return imageView;
}
/**
 * 绘制带logo二维码
 */
- (void)creatQRCodeOnView:(UIImageView *)imageView URL:(NSString *)url Logo:(NSString *)logoName {
    
    CGFloat logoImageWidth = imageView.frame.size.width / 5;
    CGFloat logoImageHeight = logoImageWidth;
    CGFloat pathWidth = 2.0;
    UIImageView *QRCodeImageView = [self creatQRCodeOnView:imageView WithURL:url];
    UIImage *logoImage = [UIImage imageNamed:logoName];
    UIImageView *logoView = [UIImageView new];
    logoView.frame = CGRectMake((QRCodeImageView.bounds.size.width - logoImageWidth) * 0.5, (QRCodeImageView.bounds.size.height - logoImageHeight) * 0.5 , logoImageWidth, logoImageHeight);
    [QRCodeImageView addSubview:logoView];
    //创建一张临时的空白画布
    UIGraphicsBeginImageContext(logoView.bounds.size);
    CGRect imageRect = CGRectMake(pathWidth, pathWidth, logoImageWidth - pathWidth * 2, logoImageHeight - pathWidth * 2);
    //在上下文环境中写绘制代码
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:imageRect];
    [[UIColor redColor] setStroke];
    path.lineWidth = pathWidth;
    [path stroke];
    [path addClip];
    [logoImage drawInRect:imageRect];
    //用画布中的生成一个 UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭绘制 的上下文区间
    UIGraphicsEndImageContext();
    logoView.image = newImage;
}
/**
 * 绘制条形码
 */
- (void)creatBarCodeOnView:(UIImageView *)imageView WithURL:(NSString *)url {
    //创建一个二维码种类的路径
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    //恢复滤镜的默认设置
    [filter setDefaults];
    //把一个网站字符串转换 二进制数据
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    //设置 滤镜 inputMessage 属性
    [filter setValue:data forKey:@"inputMessage"];
    //输出二维码图片
    CIImage *image = [filter outputImage];
    UIImage *QRCodeImage = [self excludeFuzzyImageFromCIImage:image size:imageView.frame.size.width];
    //设置imageView的图片
    imageView.image = QRCodeImage;
}

/**
 * 对生成图像进行清晰化处理
 */
- (UIImage *)excludeFuzzyImageFromCIImage: (CIImage *)image size: (CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建灰度色调空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext * context = [CIContext contextWithOptions: nil];
    CGImageRef bitmapImage = [context createCGImage: image fromRect: extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage: scaledImage];
}

#pragma mark - 二维码扫描
/**
 * 扫描
 */
- (void)scanCodeOnView:(UIViewController *)viewController handler:(CaptureResponseBlock)responseBlock {
    
    _scanView = viewController.view;
    _scanViewController = viewController;
    _responseBlock = responseBlock;
    
    if ([self isCameraPermissionAvailable]) {
        // 后置摄像头管理对象
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
#if TARGET_IPHONE_SIMULATOR
        NSLog(@"当前为模拟器");
#elif TARGET_OS_IPHONE
        // 获取输入流
        NSError *error = nil;
        AVCaptureDeviceInput *inputStream = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (error) {
            NSLog(@"获取输入流失败");
        }else{
            NSLog(@"获取输入流成功");
        }
        // 创建输出流
        AVCaptureMetadataOutput *outputStream = [AVCaptureMetadataOutput new];
        // 设置代理
        [outputStream setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        _session = [AVCaptureSession new];
        [_session addInput:inputStream];
        [_session addOutput:outputStream];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        // 设置监听类型  必须在管道设置流之后
        outputStream.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode128Code];
        // 把数据输出到屏幕上 显示给用户看
        _videoLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _videoLayer.frame = _scanView.bounds;
        [_scanView.layer addSublayer:self.videoLayer];
        // 启动管道
        [self.session startRunning];
        
        /*添加视图*/
        [self showView:_scanView];
        
#endif
    }
}

/**
 * 取消扫描
 */
- (void)cancleSacn {
    
    if ([self.session isRunning]) {
        [self.session stopRunning];
        [_videoLayer removeFromSuperlayer]; ;
        [self removeAnimation];
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
// 当扫描到数据的时候
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    //metadataObjects 这里放的就是扫描到的数据
    if(metadataObjects.count > 0){
        [self.session stopRunning];
        [_videoLayer removeFromSuperlayer];
        [self removeAnimation];
        
        // 取出扫描数据
        self.responseBlock(metadataObjects);
        
    }
}


#pragma mark - 扫描框、线、扫描动画
/*添加视图*/
- (void)showView:(UIView *)view{
    
    [self setupScanBorder:view];
    [self addAnimation];
}


/* 设置扫描边框/线 */
- (void)setupScanBorder:(UIView *)view{
    
    CGFloat X = 60;
    CGFloat W = CGRectGetWidth(view.bounds)-X*2;
    CGFloat H = W;
    CGFloat Y = (CGRectGetHeight(view.bounds)-W)/2;
    
    CGRect rect = CGRectMake(X, Y, W, H);
    self.scanBorderRect = rect;
    
    //扫描框
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:rect];
    self.backImgV = backImgV;
    backImgV.backgroundColor = [UIColor clearColor];
    backImgV.image = [UIImage imageNamed:@"扫描框@2x.png"];
    [view addSubview:backImgV];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(rect)+10, CGRectGetWidth(view.frame)-60, 60)];
    msg.backgroundColor = [UIColor clearColor];
    msg.textColor = [UIColor whiteColor];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.font = [UIFont systemFontOfSize:16];
    msg.text = @"将二维码放入框内,即可自动扫描";
    [view addSubview:msg];
    
    //扫描线
    self.lineImgV = [[UIImageView alloc] initWithFrame:CGRectMake(X, Y, W, 2)];
    self.lineImgV.image = [UIImage imageNamed:@"扫描线@2x.png"];
    self.lineImgV.contentMode = UIViewContentModeScaleAspectFill;
    self.lineImgV.backgroundColor = [UIColor clearColor];
    [view addSubview:self.lineImgV];
    
    
}


/**
 *  添加扫码动画
 */
- (void)addAnimation{
    self.lineImgV.hidden = NO;
    CABasicAnimation *animation = [self moveYTime:2 rep:OPEN_MAX];
    [self.lineImgV.layer addAnimation:animation forKey:@"LineAnimation"];
}

- (CABasicAnimation *)moveYTime:(float)time rep:(int)rep
{
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"position"];
    animationMove.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.scanView.frame)/2.0, self.scanBorderRect.origin.y)];
    animationMove.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.scanView.frame)/2.0, self.scanBorderRect.size.height+self.scanBorderRect.origin.y)];
    animationMove.duration = time;
    animationMove.repeatCount  = rep;
    animationMove.fillMode = kCAFillModeForwards;
    animationMove.removedOnCompletion = NO;
    return animationMove;
}

/**
 *  去除扫描框、扫描线、扫描动画
 */
- (void)removeAnimation{
    [self.lineImgV.layer removeAnimationForKey:@"LineAnimation"];
    [self.lineImgV removeFromSuperview];
    self.lineImgV = nil;
    [self.backImgV removeFromSuperview];
    self.backImgV = nil;
}

#pragma mark - 摄像头状态判断
/*判断摄像头状态*/
- (BOOL)isCameraPermissionAvailable{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        if(authStatus == AVAuthorizationStatusDenied ||authStatus == AVAuthorizationStatusRestricted){
   
            [[CMAlertView sharedInstance] showAlertController:self.scanViewController title:@"相机权限受限" message:@"请在iPhone的\"设置->隐私->相机\"选项中,允许APP访问您的相机." cancelTitle:@"取消" actionBlock:^(NSInteger buttonTag) {
                switch (buttonTag) {
                    case 1:
                        [self systemSettingView];
                        
                        break;
                        
                    default:
                        break;
                }
            } otherButtonTitles:@"设置",nil];
 
            return NO;
            
        }
        return YES;
    }else{
        
        
        [[CMAlertView sharedInstance] showAlertController:self.scanViewController title:@"请使用真机" message:@"您的设备没有相机." cancelTitle:@"知道了" actionBlock:^(NSInteger buttonTag) {
            switch (buttonTag) {
                case 0:
                    //do something
                    break;
                    
                default:
                    break;
            }
        } otherButtonTitles:nil];
        
        
        return NO;
    }
    
    
}
/*打开系统设置*/
- (void)systemSettingView {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=10.0) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] openURL:url];
#pragma clang diagnostic pop
            
        }
        
    }
}



@end
