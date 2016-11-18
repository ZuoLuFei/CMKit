//
//  CMBaseViewController.m
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CMBaseViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    
    //1.设置导航栏返回按钮
    if (!self.navigationController.navigationBar.hidden) {
        [self addLeftNavButton];
    }
    
    //2.设置背景图片
    [self setBackgroundView];
    
    //3.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.width                                = [UIScreen mainScreen].bounds.size.width;
    self.height                               = [UIScreen mainScreen].bounds.size.height;
    self.view.backgroundColor                 = [UIColor whiteColor];
}

#pragma mark -

//设置导航栏返回按钮
- (void)addLeftNavButton{
    
    //请根据设计要求，在此处写入相应内容，此处暂定只写入一个图片
    [self addLeftNavBarBtnByNormalImage:@"back@2x.png" highLightImage:nil normalBackgroundImage:nil highLightBackgroudImage:nil normalText:nil highLightText:nil normalTextColor:nil highLightTextColor:nil];
}

- (void)addLeftNavBarBtnByNormalImage:(NSString * _Nullable)normalImageName highLightImage:(NSString * _Nullable)highLightImageName normalBackgroundImage:(NSString * _Nullable)normalBackgroundImageName highLightBackgroudImage:(NSString * _Nullable)highLightBackgroudImageName normalText:(NSString * _Nullable)normaltext highLightText:(NSString * _Nullable)highLightText normalTextColor:(UIColor * _Nullable)normalTextColor highLightTextColor:(UIColor * _Nullable)highLightTextColor{
    
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //此处的rect就不暴露了，需要时自己根据实际情况去设置
    leftButton.frame = CGRectMake(0.,0.,50/2,50/2);
    
    if (![self isBlankString:normalImageName]) {
        [leftButton setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    }
    
    if (![self isBlankString:highLightImageName]) {
        [leftButton setImage:[UIImage imageNamed:highLightImageName] forState:UIControlStateHighlighted];
    }
    
    if (![self isBlankString:normalBackgroundImageName]) {
        [leftButton setBackgroundImage:[UIImage imageNamed:normalBackgroundImageName] forState:UIControlStateNormal];
    }
    
    if (![self isBlankString:highLightBackgroudImageName]) {
        [leftButton setBackgroundImage:[UIImage imageNamed:highLightBackgroudImageName] forState:UIControlStateHighlighted];
    }
    
    if (![self isBlankString:normaltext]) {
        [leftButton setTitle:normaltext forState:UIControlStateNormal];
    }
    
    if (![self isBlankString:highLightText]) {
        [leftButton setTitle:highLightText forState:UIControlStateHighlighted];
    }
    
    if (normalTextColor != nil) {
        [leftButton setTitleColor:normalTextColor forState:UIControlStateNormal];
    }
    
    if (highLightTextColor != nil) {
        [leftButton setTitleColor:highLightTextColor forState:UIControlStateHighlighted];
    }
    

    [leftButton addTarget:self action:@selector(leftNavItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;

}


//设置控制器背景图片
- (void)setBackgroundView{
    
    //请根据设计要求，在此处写入相应图片，此处暂定为nil
    [self setBackgroundViewWithImage:nil];
}

- (void)setBackgroundViewWithImage:(NSString * _Nullable)imageName{
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (![self isBlankString:imageName]) {
        UIImageView *backgroundImage =[[UIImageView alloc] init];
        backgroundImage.image = [UIImage imageNamed:imageName];
        backgroundImage.frame = self.view.bounds;
        [self.view insertSubview:backgroundImage atIndex:0];
    }

}

- (void)useInteractivePopGestureRecognizer{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


- (void)popViewControllerAnimated:(BOOL)animated{
    [self.navigationController popViewControllerAnimated:animated];
}


- (void)popToRootViewControllerAnimated:(BOOL)animated{
    [self.navigationController popToRootViewControllerAnimated:animated];
}


#pragma mark - 重写set和get方法

@synthesize enableInteractivePopGestureRecognizer = _enableInteractivePopGestureRecognizer;

- (void)setEnableInteractivePopGestureRecognizer:(BOOL)enableInteractivePopGestureRecognizer {
    
    _enableInteractivePopGestureRecognizer                            = enableInteractivePopGestureRecognizer;
    self.navigationController.interactivePopGestureRecognizer.enabled = enableInteractivePopGestureRecognizer;
}

- (BOOL)enableInteractivePopGestureRecognizer {
    
    return _enableInteractivePopGestureRecognizer;
}


#pragma mark - 点击事件
- (void)leftNavItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

    
#pragma mark - 私有方法,避免导入NSString+CMKit，解耦
- (BOOL)isBlankString:(NSString * _Nonnull)string
{
    // 判断字符串是否为空
    if (string == nil || string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        // 去掉前后空格，判断length是否为0
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"null"] || [string isEqualToString:@"<null>"])
    {
        return YES;
    }
    
    return NO;
}


@end
