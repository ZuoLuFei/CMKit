//
//  CMProgressViewSampleController.m
//  CMKit
//
//  Created by HC on 17/2/15.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMProgressViewSampleController.h"
#import "CMProgressTool.h"

@interface CMProgressViewSampleController ()

@end

@implementation CMProgressViewSampleController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

#pragma mark - 初始化UI
- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 0.
    int percent = 72;
    
    // 1.圆形框进度条
    CGFloat circleProgressViewX = 0;
    CGFloat circleProgressViewY = 150.0;
    CGFloat circleProgressViewW = 100.0;
    CGFloat circleProgressViewH = 100.0;
    CGRect rect = CGRectMake(circleProgressViewX, circleProgressViewY, circleProgressViewW, circleProgressViewH);
    UIView *circleProgressView = [CMProgressTool circleProgressViewWithFrame:rect percent:percent];
    [self.view addSubview:circleProgressView];
    
    
    // 2.横向进度条
    CGFloat horizontalProgressViewX = 20;
    CGFloat horizontalProgressViewY = CGRectGetMaxY(rect) +10;
    CGFloat horizontalProgressViewW = DEF_SCREEN_WIDTH - horizontalProgressViewX * 2;
    CGFloat horizontalProgressViewH = 80;
    CGRect rect2 = CGRectMake(horizontalProgressViewX, horizontalProgressViewY, horizontalProgressViewW, horizontalProgressViewH);
    UIView *horizontalProgressView = [CMProgressTool horizontalProgressViewWithFrame:rect2 percent:percent];
    [self.view addSubview:horizontalProgressView];
    
    
}

@end
