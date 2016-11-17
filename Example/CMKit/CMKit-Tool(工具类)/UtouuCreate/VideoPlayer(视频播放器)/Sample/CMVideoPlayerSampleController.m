//
//  CMVideoPlayerSampleController.m
//  CMKit
//
//  Created by HC on 16/11/16.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMVideoPlayerSampleController.h"
#import "CMVideoPlayerManager.h"
@import AVKit;



@interface CMVideoPlayerSampleController ()

@property (nonatomic, strong) CMVideoPlayerManager *videoPlayerManager;

@end

@implementation CMVideoPlayerSampleController

#pragma mark - life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //1.初始化UI
    [self initUI];
    
    //2.
    
    
    
}

#pragma mark - initUI
- (void)initUI{
    
//    AVPlayerViewController
    
    
    //1.创建播放按钮
    CGFloat playBtnY = 100;
    CGFloat playBtnW = 100;
    CGFloat playBtnH = 40;
    CGFloat playBtnX = (self.view.bounds.size.width - 100)/2;
    UIButton *playBtn = [UIButton initWithFrame:CGRectMake(playBtnX, playBtnY, playBtnW, playBtnH) title:@"playBtn" color:[UIColor grayColor]];
    [playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    
    
//    //2.添加播放器
//    
//    
//    
//    
//    CGFloat playViewX = 10;
//    CGFloat playViewY = CGRectGetMaxY(playBtn.frame) + 20;
//    CGFloat playViewW = self.view.bounds.size.width - playViewX*2;
//    CGFloat playViewH = 200;
//    UIView *playView = [UIView initWithFrame:CGRectMake(playViewX, playViewY, playViewW, playViewH) backgroundColor:[UIColor blackColor]];
//    [self.view addSubview:playView];
//    
//    CMVideoPlayerManager *videoPlayerManager = [CMVideoPlayerManager shareVideoPlayerManager];
//    self.videoPlayerManager = videoPlayerManager;
//    [videoPlayerManager createPlayerLayerWithView:playView];
//    [videoPlayerManager videoPlayerWithUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
//
//    
    
}

- (void)playBtnClick
{
    [self.videoPlayerManager play];
}

@end
