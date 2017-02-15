//
//  CMProgressView.m
//  ChuangMengPack
//
//  Created by HC on 17/2/15.
//  Copyright © 2017年 UTSOFT. All rights reserved.
//

#import "CMProgressView.h"

@interface CMProgressView()
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@end

@implementation CMProgressView
{
    UIColor *_popUpViewColor;
    NSArray *_keyTimes;
    BOOL _shouldAnimate;
    CALayer *_progressLayer;
    CAGradientLayer *_gradientLayer;
}

#pragma mark - initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - public
- (void)setTrackTintColor:(UIColor *)color
{
    self.backgroundColor = color;
}

- (UIColor *)trackTintColor
{
    return self.backgroundColor;
}

// return the currently displayed color if possible, otherwise return _popUpViewColor
// if animated colors are set, the color will change each time the progress view updates
- (UIColor *)popUpViewColor
{
    return _popUpViewColor;
}

- (void)setPopUpViewColor:(UIColor *)color
{
    _popUpViewColor = color;
    _popUpViewAnimatedColors = nil; // animated colors should be discarded
    [self setGradientColors:@[color, color] withPositions:nil];
}

- (void)setPopUpViewAnimatedColors:(NSArray *)colors
{
    [self setPopUpViewAnimatedColors:colors withPositions:nil];
}

// if 2 or more colors are present, set animated colors
// if only 1 color is present then call 'setPopUpViewColor:'
// if arg is nil then restore previous _popUpViewColor
- (void)setPopUpViewAnimatedColors:(NSArray *)colors withPositions:(NSArray *)positions
{
    if (positions) {
        NSAssert([colors count] == [positions count], @"popUpViewAnimatedColors and locations should contain the same number of items");
    }
    
    _popUpViewAnimatedColors = colors;
    _keyTimes = positions;
    
    if ([colors count] >= 2) {
        [self setGradientColors:colors withPositions:positions];
    } else {
        [self setGradientColors:colors withPositions:positions];
    }
}


- (void)setProgressLayerCornerRadius:(CGFloat)progressLayerCornerRadius {
    _progressLayer.cornerRadius = progressLayerCornerRadius;
}

- (CGFloat)progressLayerCornerRadius {
    return _progressLayer.cornerRadius;
}


// returns the current progress in the range 0.0 – 1.0
- (CGFloat)currentValueOffset
{
    return self.progress;
}

#pragma mark - private

- (void)setup
{
    _progressLayer = [CALayer layer];
    _progressLayer.masksToBounds = YES;
    _progressLayer.anchorPoint = CGPointMake(0, 0);
    [self.layer addSublayer:_progressLayer];
    
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.startPoint = CGPointZero;
    _gradientLayer.endPoint = CGPointMake(1, 0);
    [_progressLayer addSublayer:_gradientLayer];
    
    self.progress = 0;
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    _numberFormatter = formatter;
    
    self.popUpViewColor = [UIColor colorWithHue:0.6 saturation:0.6 brightness:0.5 alpha:0.8];
    
}


#pragma mark - subclassed

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateProgressLayer];
}

- (void)updateProgressLayer
{
    _gradientLayer.frame = self.bounds;
    _progressLayer.frame = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
}

- (void)setProgress:(float)progress
{
    _progress = MAX(0.0, MIN(progress, 1.0));
    [self updateProgressLayer];
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    _shouldAnimate = animated;
    
    if (animated) {
        CFTimeInterval duration = 1.0;
            CABasicAnimation *anim = [CABasicAnimation animation];
            anim.duration = duration;
            anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            anim.fromValue = [_progressLayer.presentationLayer valueForKey:@"bounds"];
            _progressLayer.actions = @{@"bounds" : anim};
            
            [UIView animateWithDuration:duration animations:^{
                self.progress = progress;
                [self layoutIfNeeded];
            }];
    } else {
        _progressLayer.actions = @{@"bounds" : [NSNull null]};
        self.progress = progress;
    }
}

- (void)setGradientColors:(NSArray *)gradientColors withPositions:(NSArray *)positions
{
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *col in gradientColors) {
        [cgColors addObject:(id)col.CGColor];
    }
    
    _gradientLayer.colors = cgColors;
    _gradientLayer.locations = positions;
}


@end
