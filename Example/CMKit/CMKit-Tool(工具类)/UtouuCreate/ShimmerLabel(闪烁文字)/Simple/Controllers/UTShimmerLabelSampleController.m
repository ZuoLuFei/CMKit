//
//  UTShimmerLabelSampleController.m
//  CMKit
//
//  Created by HC on 17/1/10.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "UTShimmerLabelSampleController.h"
#import "CMShimmerLabel.h"

@interface UTShimmerLabelSampleController ()

@property (strong, nonatomic) CMShimmerLabel *label1;
@property (strong, nonatomic) CMShimmerLabel *label2;
@property (strong, nonatomic) CMShimmerLabel *label3;
@property (strong, nonatomic) CMShimmerLabel *label4;

@end

@implementation UTShimmerLabelSampleController


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
}

#pragma mark - 初始化UI
- (void)configUI {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.label1 = [[CMShimmerLabel alloc] init];
    self.label1.frame = CGRectMake(20, 75, 200, 35);
    self.label1.text = @"hello world 1";
    self.label1.textColor = [UIColor grayColor];
    self.label1.font = [UIFont systemFontOfSize:30];
    [self.label1 startShimmer];                 // 开启闪烁
    [self.view addSubview:self.label1];
    
    
    self.label2 = [[CMShimmerLabel alloc] init];
    self.label2.frame = CGRectMake(20, 145, 200, 35);
    self.label2.text = @"hello world 2";
    self.label2.textColor = [UIColor grayColor];
    self.label2.font = [UIFont systemFontOfSize:30];
    self.label2.shimmerType = ST_RightToLeft;           // 滚动方向 right to left
    self.label2.durationTime = 0.7;                     // 滚动时间
    self.label2.shimmerColor = [UIColor orangeColor];   // 高亮颜色
    [self.label2 startShimmer];                         // 开启闪烁
    [self.view addSubview:self.label2];
    
    
    self.label3 = [[CMShimmerLabel alloc] init];
    self.label3.frame = CGRectMake(20, 215, 200, 35);
    self.label3.text = @"hello world 3";
    self.label3.textColor = [UIColor grayColor];
    self.label3.font = [UIFont systemFontOfSize:30];
    self.label3.shimmerType = ST_AutoReverse;
    self.label3.shimmerWidth = 20;                      // 高亮的宽度
    self.label3.shimmerRadius = 20;                     // 阴影的宽度
    self.label3.shimmerColor = [UIColor yellowColor];   // 高亮颜色
    [self.label3 startShimmer];                         // 开启闪烁
    [self.view addSubview:self.label3];
    
    
    self.label4 = [[CMShimmerLabel alloc] init];
    self.label4.frame = CGRectMake(20, 285, 200, 35);
    self.label4.text = @"hello world 4";
    self.label4.textColor = [UIColor grayColor];
    self.label4.font = [UIFont systemFontOfSize:30];
    self.label4.shimmerType = ST_ShimmerAll;
    self.label4.durationTime = 0.5;
    self.label4.shimmerColor = [UIColor redColor];
    [self.label4 startShimmer];
    [self.view addSubview:self.label4];
    
    //    [self.label4 stopShimmer];      // 停止闪烁
}

@end
