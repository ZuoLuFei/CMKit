//
//  CMProgressTool.m
//  ChuangMengPack
//
//  Created by HC on 17/2/15.
//  Copyright © 2017年 UTSOFT. All rights reserved.
//

#import "CMProgressTool.h"
#import "CMProgressView.h"
#import "CMCircleProgressView.h"
#import "UICountingLabel.h"


#define AnimationDuration 1.0

@interface CMProgressTool ()

@property (nonatomic, strong) CMProgressView *progressView;

@property (nonatomic, assign) int percent;

@end

@implementation CMProgressTool


// 圆形框进度条
+ (UIView *)circleProgressViewWithFrame:(CGRect)frame percent:(int)percent{

    CMCircleProgressView *circleProgressView = [[CMCircleProgressView alloc] initWithFrame:CGRectMake(0,150.0, 100.0, 100.0) total:@100 current:[NSNumber numberWithInt:percent] clockwise:YES];
    circleProgressView.backgroundColor = [UIColor clearColor];
    circleProgressView.chartType = CMChartFormatTypePercent;
    
    [circleProgressView setStrokeColor:[UIColor blackColor]];
    [circleProgressView setStrokeColorGradientStart:[UIColor blackColor]];
    [circleProgressView strokeChart];
    
    return circleProgressView;
}


+ (UIView *)horizontalProgressViewWithFrame:(CGRect)frame percent:(int)percent{
    return [[self alloc] horizontalProgressViewWithFrame:frame percent:percent];
}


// 横向进度条
- (UIView *)horizontalProgressViewWithFrame:(CGRect)frame percent:(int)percent{
    
    // 1.
    UIView *horizontalView = [[UIView alloc] initWithFrame:frame];

    
    // 2.
    CGFloat colorLabelX = frame.size.width - 60;
    CGFloat colorLabelY = 0;
    CGFloat colorLabelW = 60;
    CGFloat colorLabelH = 40;
    UICountingLabel *colorLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(colorLabelX, colorLabelY, colorLabelW, colorLabelH)];
    colorLabel.method = UILabelCountingMethodEaseInOut;
    colorLabel.format = @"%d%%";
    colorLabel.textColor = [UIColor blackColor];
    [colorLabel countFrom:0 to:percent];
    colorLabel.animationDuration = AnimationDuration;
    [horizontalView addSubview:colorLabel];
    
    // 3.
    CGFloat progressViewX = 0;
    CGFloat progressViewY = colorLabelH;
    CGFloat progressViewW = frame.size.width;
    CGFloat progressViewH = 10;
    CMProgressView *progressView = [[CMProgressView alloc] initWithFrame:CGRectMake(progressViewX, progressViewY, progressViewW, progressViewH)];
    self.progressView = progressView;
    progressView.progressLayerCornerRadius = 5.0;
    progressView.progress = 0.0;
    progressView.layer.cornerRadius = 5.0;
    progressView.layer.masksToBounds = YES;
    progressView.popUpViewColor = [UIColor blackColor];
    //    progressView.popUpViewAnimatedColors = @[[UIColor colorWithHue:0.4 saturation:0.4 brightness:0.3 alpha:1.0],[UIColor colorWithHue:0.5 saturation:0.9 brightness:0.8 alpha:1.0]];
    
    //    [progressView showPopUpViewAnimated:YES];
    [horizontalView addSubview:progressView];
    
    
    _percent = percent;
    [self progress];
    
    return horizontalView;
}

#pragma mark - 计时器动画方法
- (void)progress {
    float progress = self.progressView.progress;
    float adds = 0.005;
    float number = (_percent/100.0) / adds;
    float timeInterval = AnimationDuration/number;
    if (progress < _percent/100.0) {
        
        progress += 0.005;
        [self.progressView setProgress:progress animated:NO];
        [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                         target:self
                                       selector:@selector(progress)
                                       userInfo:nil
                                        repeats:NO];
    }
}


@end
