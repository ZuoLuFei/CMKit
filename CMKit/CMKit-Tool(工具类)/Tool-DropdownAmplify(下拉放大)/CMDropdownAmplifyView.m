//
//  CMDropdownAmplifyView.m
//  CMKit
//
//  Created by HC on 17/1/10.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMDropdownAmplifyView.h"

@interface CMDropdownAmplifyView ()

@property (nonatomic, assign) CGFloat initOffsetY;
@property (nonatomic, assign) CGRect initStretchViewFrame;
@property (nonatomic, assign) CGFloat initSelfHeight;
@property (nonatomic, assign) CGFloat initContentHeight;

@end

@implementation CMDropdownAmplifyView


#pragma mark - 工厂方法
+ (instancetype)dropHeaderViewWithFrame:(CGRect)frame {
    return [self dropHeaderViewWithFrame:frame contentView:nil stretchView:nil];
}

+ (instancetype)dropHeaderViewWithFrame:(CGRect)frame contentView:(UIView *)contentView stretchView:(UIView *)stretchView
{
    CMDropdownAmplifyView *dropHeaderView = [[CMDropdownAmplifyView alloc] init];
    dropHeaderView.frame = frame;
    dropHeaderView.stretchView = stretchView;
    dropHeaderView.contentView = contentView;
    
    stretchView.contentMode = UIViewContentModeScaleAspectFill;
    stretchView.clipsToBounds = YES;
    return dropHeaderView;
}

#pragma mark - set方法
- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    if (_stretchView) {
        [self insertSubview:contentView aboveSubview:_stretchView];
    }else{
        [self addSubview:contentView];
    }
    
    [self addSubview:contentView];
}

- (void)setStretchView:(UIView *)stretchView {
    _stretchView = stretchView;
    
    if (_contentView) {
        [self insertSubview:stretchView belowSubview:_contentView];
    }else{
        [self addSubview:stretchView];
    }
    
}

#pragma mark - 父类方法重写
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    if (newSuperview != nil) {
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        UIScrollView *scrollView = (UIScrollView *)newSuperview;
        
        self.initOffsetY = scrollView.contentOffset.y;
        self.initStretchViewFrame = self.stretchView.frame;
        self.initSelfHeight = CGRectGetHeight(self.bounds);
        self.initContentHeight = CGRectGetHeight(self.contentView.bounds);
        
    }
    
}





#pragma mark - KVO属性监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGFloat offsetY = [change[@"new"] CGPointValue].y - self.initOffsetY;
    
    //    NSLog(@"\nself.initOffsetY->%f \noffsetY->%f",self.initOffsetY,offsetY);
    CGRect newFrame   = self.stretchView.frame;
    newFrame.origin.y = self.initStretchViewFrame.origin.y + offsetY;
    newFrame.size.height = self.initStretchViewFrame.size.height - offsetY;
    self.stretchView.frame       = newFrame;
    
    
    
}

@end
