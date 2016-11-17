//
//  CMQRCodeSampleController.m
//  CMKit
//
//  Created by HC on 16/10/31.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMQRCodeSampleController.h"
#import "CMQRCodeManager.h"

@interface CMQRCodeSampleController ()
- (IBAction)createBaseQRCodeBtnClick:(UIButton *)sender;
- (IBAction)createLogoQRCodeBtnClick:(UIButton *)sender;
- (IBAction)createBarQRCodeBtnClick:(UIButton *)sender;
- (IBAction)scanQRCodeBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;


@end

@implementation CMQRCodeSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUpNavigationItem];
    
}

- (void)setUpNavigationItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消扫描"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(cancleSacn)];
}

- (void)cancleSacn {
    //取消扫描
    [[CMQRCodeManager sharedCMQRCodeManager] cancleSacn];
}


#pragma mark - 生成二维码、条形码
//绘制基础二维码
- (IBAction)createBaseQRCodeBtnClick:(UIButton *)sender {
    [self clearCodeImageView];
    
    NSString *urlStr = @"http://www.utouu.com";
    // 核心api
    [[CMQRCodeManager sharedCMQRCodeManager] creatQRCodeOnView:self.QRCodeImageView WithURL:urlStr];
    
}

//绘制带Logo二维码
- (IBAction)createLogoQRCodeBtnClick:(UIButton *)sender {
    [self clearCodeImageView];
    
    NSString *urlStr = @"http://www.utouu.com";
    NSString *logoName = @"utouu";
    // 核心api
    [[CMQRCodeManager sharedCMQRCodeManager] creatQRCodeOnView:self.QRCodeImageView URL:urlStr Logo:logoName];
}


//创建条形码
- (IBAction)createBarQRCodeBtnClick:(UIButton *)sender {
    
    [self clearCodeImageView];
    
    NSString *urlStr = @"12345678";
    // 核心api
    [[CMQRCodeManager sharedCMQRCodeManager] creatBarCodeOnView:self.QRCodeImageView WithURL:urlStr];
    
}


#pragma mark - 扫描二维码
//扫描二维码
- (IBAction)scanQRCodeBtnClick:(UIButton *)sender {
    
    [[CMQRCodeManager sharedCMQRCodeManager] scanCodeOnView:self handler:^(NSArray<AVMetadataMachineReadableCodeObject *> *metadataObjects) {
        
        //do something
        
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects firstObject];
        NSString *codeStr = [obj stringValue];
        if (codeStr && ( [codeStr containsString:@"http://"] || [codeStr containsString:@"https://"])) {
            NSURL *url = [NSURL URLWithString:codeStr];
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
        
    }];
}



- (void)clearCodeImageView {
    [[self.QRCodeImageView.subviews lastObject] removeFromSuperview];
    self.QRCodeImageView.image = nil;
}







@end
