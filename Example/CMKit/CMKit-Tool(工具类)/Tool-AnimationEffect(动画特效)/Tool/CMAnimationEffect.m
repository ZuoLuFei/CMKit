//
//  CMAnimationEffect.m
//  CMKit
//
//  Created by jon on 16/10/25.
//  Copyright © 2016年 jon. All rights reserved.
//

#import "CMAnimationEffect.h"

@implementation CMAnimationEffect


//static id _instance = nil; \
//+ (id)allocWithZone:(struct _NSZone *)zone \
//{ \
//    static dispatch_once_t onceToken; \
//    dispatch_once(&onceToken, ^{ \
//        _instance = [super allocWithZone:zone]; \
//    }); \
//    return _instance; \
//} \
//\
//+ (instancetype)shared##name \
//{ \
//    static dispatch_once_t onceToken; \
//    dispatch_once(&onceToken, ^{ \
//        _instance = [[self alloc] init]; \
//    });\
//    return _instance; \
//} \
//+ (id)copyWithZone:(struct _NSZone *)zone \
//{ \
//    return _instance; \
//}

static id _instance = nil;

+ (instancetype)shareAnimationEffect{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}




+ (void)positionAnimation:(UIView *)animationView{
    animationView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 100, 100);
    [UIView animateWithDuration:2.0f animations:^{
        animationView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 100, 100);
    } completion:^(BOOL finished) {
        animationView.frame = CGRectMake(SCREEN_WIDTH/2.0-50, SCREEN_HEIGHT/2-50, 100, 100);
    }];
}
- (void)positionAnimation:(UIView *)animationView{
    [[_instance class] positionAnimation:animationView];
    
}

+ (void)opacityAniamtion:(UIView *)animationView{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1.0f];
    anima.toValue = [NSNumber numberWithFloat:0.2f];
    anima.duration = 2.0f;
    [animationView.layer addAnimation:anima forKey:@"opacityAniamtion"];
}
- (void)opacityAniamtion:(UIView *)animationView{
    [[_instance class] opacityAniamtion:animationView];
    
}

+ (void)scaleAnimation:(UIView *)animationView{
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima.toValue = [NSNumber numberWithFloat:2.0f];
    anima.duration = 1.0f;
    [animationView.layer addAnimation:anima forKey:@"scaleAnimation"];
    
    
}
- (void)scaleAnimation:(UIView *)animationView{
    [[_instance class] scaleAnimation:animationView];
    
}


+ (void)rotateAnimation:(UIView *)animationView{
    //    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    //    anima.toValue = [NSNumber numberWithFloat:M_PI];
    //    anima.duration = 1.0f;
    //    [animationView.layer addAnimation:anima forKey:@"rotateAnimation"];
    
    //valueWithCATransform3D作用与layer
    //        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform"];
    //        anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];//绕着矢量（x,y,z）旋转
    //        anima.duration = 1.0f;
    //        //anima.repeatCount = MAXFLOAT;
    //        [animationView.layer addAnimation:anima forKey:@"rotateAnimation"];
    
    //CGAffineTransform作用与View
    animationView.transform = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:1.0f animations:^{
        animationView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)rotateAnimation:(UIView *)animationView{
    [[_instance class] rotateAnimation:animationView];
    
}


+ (void)backgroundAnimation:(UIView *)animationView{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.toValue =(id) [UIColor greenColor].CGColor;
    anima.duration = 1.0f;
    [animationView.layer addAnimation:anima forKey:@"backgroundAnimation"];
}
- (void)backgroundAnimation:(UIView *)animationView{
    [[_instance class] backgroundAnimation:animationView];
    
}

+ (void)keyFrameAnimation:(UIView *)animationView{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima.duration = 2.0f;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏
    //anima.delegate = self;//设置代理，可以检测动画的开始和结束
    [animationView.layer addAnimation:anima forKey:@"keyFrameAnimation"];
    
}
- (void)keyFrameAnimation:(UIView *)animationView{
    [[_instance class] keyFrameAnimation:animationView];
    
}


+ (void)pathAnimation:(UIView *)animationView{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    anima.path = path.CGPath;
    anima.duration = 2.0f;
    [animationView.layer addAnimation:anima forKey:@"pathAnimation"];
}

- (void)pathAnimation:(UIView *)animationView{
    [[_instance class] pathAnimation:animationView];
    
}


+ (void)shakeAnimation:(UIView *)animationView{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    anima.values = @[value1,value2,value3];
    anima.repeatCount = 10;
    [animationView.layer addAnimation:anima forKey:@"shakeAnimation"];
    
}

- (void)shakeAnimation:(UIView *)animationView{
    [[_instance class] shakeAnimation:animationView];
    
}


+ (void)shakeItOffAnimation:(UIView *)animationView
{
    CGPoint position = [animationView.layer position];
    CGPoint y = CGPointMake(position.x - 8.0f, position.y);
    CGPoint x = CGPointMake(position.x + 8.0f, position.y);
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08f];
    [animation setRepeatCount:3];
    [animationView.layer addAnimation:animation forKey:nil];

}

- (void)shakeItOffAnimation:(UIView *)animationView{
    [[_instance class] shakeItOffAnimation:animationView];
    
}


+ (void)springingAnimation:(UIView *)animationView
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animationView.layer addAnimation:popAnimation forKey:nil];

}

- (void)springingAnimation:(UIView *)animationView{
    [[_instance class] springingAnimation:animationView];
    
}

+ (void)praiseAnimation:(UIView *)animationView
{
    CAKeyframeAnimation *praiseAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    praiseAnimation.values = @[@(0.1),@(1.0),@(1.5)];
    praiseAnimation.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    praiseAnimation.calculationMode = kCAAnimationLinear;
    [animationView.layer addAnimation:praiseAnimation forKey:@"praiseAnimation"];

}

- (void)praiseAnimation:(UIView *)animationView{
    [[_instance class] praiseAnimation:animationView];
    
}


+ (void)groupAnimation:(UIView *)animationView{
    //    //位移动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];
    groupAnimation.duration = 4.0f;
    
    [animationView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
    
}

- (void)groupAnimation:(UIView *)animationView{
    [[_instance class] groupAnimation:animationView];
    
}


+ (void)plainAnimation:(UIView *)animationView{
    CFTimeInterval currentTime = CACurrentMediaTime();
    //位移动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-75)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-75)];
    anima1.beginTime = currentTime;
    anima1.duration = 1.0f;
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = NO;
    [animationView.layer addAnimation:anima1 forKey:@"aa"];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime+1.0f;
    anima2.duration = 1.0f;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = NO;
    [animationView.layer addAnimation:anima2 forKey:@"bb"];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime+2.0f;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [animationView.layer addAnimation:anima3 forKey:@"cc"];
}
- (void)plainAnimation:(UIView *)animationView{
    [[_instance class] plainAnimation:animationView];
    
}



#pragma-mark 翻页动画

+ (void)fadeAnimation:(UIView *)animationView{
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionFade;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    //anima.startProgress = 0.3;//设置动画起点
    //anima.endProgress = 0.8;//设置动画终点
    anima.duration = 1.0f;
    [animationView.layer addAnimation:anima forKey:@"fadeAnimation"];
}
- (void)fadeAnimation:(UIView *)animationView{
    [[_instance class] fadeAnimation:animationView];

}

+ (void)moveInAnimation:(UIView *)animationView{
    
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionMoveIn;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [animationView.layer addAnimation:anima forKey:@"moveInAnimation"];
}

- (void)moveInAnimation:(UIView *)animationView{
    [[_instance class] moveInAnimation:animationView];

}

+ (void)pushAnimation:(UIView *)animationView{
    
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [animationView.layer addAnimation:anima forKey:@"pushAnimation"];
}
- (void)pushAnimation:(UIView *)animationView{
    [[_instance class] pushAnimation:animationView];
    
}

+ (void)revealAnimation:(UIView *)animationView{
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionReveal;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [animationView.layer addAnimation:anima forKey:@"revealAnimation"];
}
- (void)revealAnimation:(UIView *)animationView{
    [[_instance class] revealAnimation:animationView];
    
}

/*--------------------private api-------------------*/
+ (void)cubeAnimation:(UIView *)animationView{
    
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [animationView.layer addAnimation:anima forKey:@"revealAnimation"];
}

- (void)cubeAnimation:(UIView *)animationView{
    [[_instance class] cubeAnimation:animationView];
    
}

+(void)suckEffectAnimation:(UIView *)animationView{
    
    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [animationView.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}
- (void)suckEffectAnimation:(UIView *)animationView{
    [[_instance class] suckEffectAnimation:animationView];
    
}

+ (void)oglFlipAnimation:(UIView *)animationView{
    CATransition *anima = [CATransition animation];
    anima.type = @"oglFlip";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [animationView.layer addAnimation:anima forKey:@"oglFlipAnimation"];
}
- (void)oglFlipAnimation:(UIView *)animationView{
    [[_instance class] oglFlipAnimation:animationView];
    
}

+ (void)rippleEffectAnimation:(UIView *)animationView{
    CATransition *anima = [CATransition animation];
    anima.type = @"rippleEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [animationView.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}
- (void)rippleEffectAnimation:(UIView *)animationView{
    [[_instance class] rippleEffectAnimation:animationView];
    
}

+ (void)pageCurlAnimation:(UIView *)animationView{
    CATransition *anima = [CATransition animation];
    anima.type = @"pageCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [animationView.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}
- (void)pageCurlAnimation:(UIView *)animationView{
    [[_instance class] pageCurlAnimation:animationView];
    
}

+ (void)pageUnCurlAnimation:(UIView *)animationView{
    CATransition *anima = [CATransition animation];
    anima.type = @"pageUnCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [animationView.layer addAnimation:anima forKey:@"pageUnCurlAnimation"];
}
- (void)pageUnCurlAnimation:(UIView *)animationView{
    [[_instance class] pageUnCurlAnimation:animationView];
    
}

+ (void)cameraIrisHollowOpenAnimation:(UIView *)animationView{
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowOpen";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [animationView.layer addAnimation:anima forKey:@"cameraIrisHollowOpenAnimation"];
}
- (void)cameraIrisHollowOpenAnimation:(UIView *)animationView{
    [[_instance class] cameraIrisHollowOpenAnimation:animationView];
    
}

+ (void)cameraIrisHollowCloseAnimation:(UIView *)animationView{
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowClose";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [animationView.layer addAnimation:anima forKey:@"cameraIrisHollowCloseAnimation"];
}
- (void)cameraIrisHollowCloseAnimation:(UIView *)animationView{
    [[_instance class] cameraIrisHollowCloseAnimation:animationView];
    
}



@end
