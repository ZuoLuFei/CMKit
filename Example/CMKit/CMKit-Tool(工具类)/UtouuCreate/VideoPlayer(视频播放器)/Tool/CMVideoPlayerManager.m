//
//  CMVideoPlayerManager.m
//  CMKit
//
//  Created by HC on 16/11/16.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMVideoPlayerManager.h"
@import AVFoundation;
#import <MediaPlayer/MediaPlayer.h>



@interface CMVideoPlayerManager ()

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) AVPlayer *player;



@end

@implementation CMVideoPlayerManager

#pragma mark - 单例构造方法
/**
 * 单例
 */
static CMVideoPlayerManager *_CMVideoPlayerManager = nil;
+ (instancetype)shareVideoPlayerManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CMVideoPlayerManager = [[CMVideoPlayerManager alloc] init];
    });
    return _CMVideoPlayerManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CMVideoPlayerManager = [super allocWithZone:zone];
    });
    return _CMVideoPlayerManager;
}



@end
