//
//  CMAnimationEffect.h
//  CMKit
//
//  Created by jon on 16/10/25.
//  Copyright © 2016年 jon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface CMAnimationEffect : NSObject


+ (instancetype)shareAnimationEffect;

/**
 ! 位移动画演示
 */
+ (void)positionAnimation:(UIView *)animationView;
- (void)positionAnimation:(UIView *)animationView;

/**
 *  透明度动画
 */
+ (void)opacityAniamtion:(UIView *)animationView;
- (void)opacityAniamtion:(UIView *)animationView;
/**
 *  缩放动画
 */
+ (void)scaleAnimation:(UIView *)animationView;
- (void)scaleAnimation:(UIView *)animationView;
/**
 *  旋转动画
 */
+ (void)rotateAnimation:(UIView *)animationView;
- (void)rotateAnimation:(UIView *)animationView;
/**
 *  背景色变化动画
 */
+ (void)backgroundAnimation:(UIView *)animationView;
- (void)backgroundAnimation:(UIView *)animationView;
/**
 *  关键帧动画
 */
+ (void)keyFrameAnimation:(UIView *)animationView;
- (void)keyFrameAnimation:(UIView *)animationView;
/**
 *  path动画
 */
+ (void)pathAnimation:(UIView *)animationView;
- (void)pathAnimation:(UIView *)animationView;
/**
 *  抖动效果
 */
+ (void)shakeAnimation:(UIView *)animationView;
- (void)shakeAnimation:(UIView *)animationView;
/**
 *  摇一摇效果
 */
+ (void)shakeItOffAnimation:(UIView *)animationView;
- (void)shakeItOffAnimation:(UIView *)animationView;

/**
 * 弹跳动画
 */
+ (void)springingAnimation:(UIView *)animationView;
- (void)springingAnimation:(UIView *)animationView;

/**
 * 冲击动画
 */
+ (void)praiseAnimation:(UIView *)animationView;
- (void)praiseAnimation:(UIView *)animationView;

/**
 *  组合效果
 */
+ (void)groupAnimation:(UIView *)animationView;
- (void)groupAnimation:(UIView *)animationView;
/**
 *  顺序执行的组动画
 */
+ (void)plainAnimation:(UIView *)animationView;
- (void)plainAnimation:(UIView *)animationView;


#pragma-mark 转场动画
/**
 *  逐渐消失
 */
+ (void)fadeAnimation:(UIView *)animationView;
- (void)fadeAnimation:(UIView *)animationView;
+ (void)moveInAnimation:(UIView *)animationView;
- (void)moveInAnimation:(UIView *)animationView;
+ (void)pushAnimation:(UIView *)animationView;
- (void)pushAnimation:(UIView *)animationView;
+ (void)revealAnimation:(UIView *)animationView;
- (void)revealAnimation:(UIView *)animationView;


/**
 *  立体翻滚效果
 */
+ (void)cubeAnimation:(UIView *)animationView;
- (void)cubeAnimation:(UIView *)animationView;
+ (void)suckEffectAnimation:(UIView *)animationView;
- (void)suckEffectAnimation:(UIView *)animationView;
+ (void)oglFlipAnimation:(UIView *)animationView;
- (void)oglFlipAnimation:(UIView *)animationView;
+ (void)rippleEffectAnimation:(UIView *)animationView;
- (void)rippleEffectAnimation:(UIView *)animationView;
+ (void)pageCurlAnimation:(UIView *)animationView;
- (void)pageCurlAnimation:(UIView *)animationView;
+ (void)pageUnCurlAnimation:(UIView *)animationView;
- (void)pageUnCurlAnimation:(UIView *)animationView;
+ (void)cameraIrisHollowOpenAnimation:(UIView *)animationView;
- (void)cameraIrisHollowOpenAnimation:(UIView *)animationView;
+ (void)cameraIrisHollowCloseAnimation:(UIView *)animationView;
- (void)cameraIrisHollowCloseAnimation:(UIView *)animationView;
@end
