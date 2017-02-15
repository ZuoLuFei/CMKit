//
//  CMProgressView.h
//  ChuangMengPack
//
//  Created by HC on 17/2/15.
//  Copyright © 2017年 UTSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CMProgressView : UIView
/** 范围：0.0 .. 1.0,默认是0.0，超出范围的值无效  */
@property(nonatomic) float progress;

/**
 设置精度
 */
- (void)setProgress:(float)progress animated:(BOOL)animated;

// 设置'popUpViewColor'的值将会复写'popUpViewAnimatedColors'的值，'popUpViewColor'的值显示当前精度条的颜色，如果设置了‘popUpViewAnimatedColors’的值，显示效果会不同
@property (strong, nonatomic) UIColor *popUpViewColor;

// 传递至少2组的动画数组以改变进度条的动画效果
@property (strong, nonatomic) NSArray *popUpViewAnimatedColors;

// 进度条Layer的边角圆度度数，默认是0.0
@property (nonatomic) CGFloat progressLayerCornerRadius;

@end
