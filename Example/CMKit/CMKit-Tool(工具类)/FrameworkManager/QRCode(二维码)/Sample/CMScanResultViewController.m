//
//  CMScanResultViewController.m
//  CMKit
//
//  Created by HC on 16/12/2.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMScanResultViewController.h"

@interface CMScanResultViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *scanImg;
@property (weak, nonatomic) IBOutlet UILabel *labelScanCodeType;
@property (weak, nonatomic) IBOutlet UILabel *labelScanText;


@end

@implementation CMScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"扫码结果";
    
    if (!_imgScan) {
        
        _scanImg.backgroundColor = [UIColor grayColor];
    }
    
    _scanImg.image = _imgScan;
    _labelScanText.text = _strScan;
    _labelScanCodeType.text = [NSString stringWithFormat:@"码的类型:%@",_strCodeType];
    
    
}



@end
