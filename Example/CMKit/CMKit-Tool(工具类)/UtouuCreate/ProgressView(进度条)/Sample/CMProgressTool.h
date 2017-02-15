//
//  CMProgressTool.h
//  ChuangMengPack
//
//  Created by HC on 17/2/15.
//  Copyright © 2017年 UTSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CMProgressTool : NSObject

/**
 圆形框进度条
 */
+ (UIView *)circleProgressViewWithFrame:(CGRect)frame percent:(int)percent;


/**
 横向进度条
 */
+ (UIView *)horizontalProgressViewWithFrame:(CGRect)frame percent:(int)percent;

@end
