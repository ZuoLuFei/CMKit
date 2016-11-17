//
//  CMVideoPlayerManager.h
//  CMKit
//
//  Created by HC on 16/11/16.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CMVideoPlayerManager : NSObject

+ (CMVideoPlayerManager *)shareVideoPlayerManager;

- (void)createPlayerLayerWithView:(UIView *)view;

- (void)videoPlayerWithUrl:(NSString *)urlString;

- (void)play;
@end
