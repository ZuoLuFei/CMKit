//
//  CMDropdownAmplifyView.h
//  CMKit
//
//  Created by HC on 17/1/10.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMDropdownAmplifyView : UIView
/** 内容显示View */
@property (nonatomic, strong) UIView *contentView;
/** 图片拉伸View */
@property (nonatomic, strong) UIView *stretchView;

#pragma mark - 工厂方法
/**
 快速创建方法一
 */
+ (instancetype)dropHeaderViewWithFrame:(CGRect)frame;
/**
 快速创建方法二
 */
+ (instancetype)dropHeaderViewWithFrame:(CGRect)frame contentView:(UIView *)contentView stretchView:(UIView *)stretchView;

@end
