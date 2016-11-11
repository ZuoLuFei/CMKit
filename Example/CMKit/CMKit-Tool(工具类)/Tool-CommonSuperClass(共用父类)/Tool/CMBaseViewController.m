//
//  CMBaseViewController.m
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseViewController ()

@end

@implementation CMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置导航栏返回按钮
    [self addLeftNavButton];
    
    //2.设置背景图片
    [self setBackgroundView];
}


//设置导航栏返回按钮
- (void)addLeftNavButton{
    
    //请根据设计要求，在此处写入相应内容，此处暂定只写入一个图片
    [self addLeftNavBarBtnByNormalImage:@"back@2x.png" highLightImage:nil normalBackgroundImage:nil highLightBackgroudImage:nil normalText:nil highLightText:nil normalTextColor:nil highLightTextColor:nil];
}

- (void)addLeftNavBarBtnByNormalImage:(NSString * _Nullable)normalImageName highLightImage:(NSString * _Nullable)highLightImageName normalBackgroundImage:(NSString * _Nullable)normalBackgroundImageName highLightBackgroudImage:(NSString * _Nullable)highLightBackgroudImageName normalText:(NSString * _Nullable)normaltext highLightText:(NSString * _Nullable)highLightText normalTextColor:(UIColor * _Nullable)normalTextColor highLightTextColor:(UIColor * _Nullable)highLightTextColor{
    
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //此处的rect就不暴露了，需要时自己根据实际情况去设置
    leftButton.frame = CGRectMake(0.,0.,50/2,50/2);
    
    if (![normalImageName isBlank]) {
        [leftButton setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    }
    
    if (![highLightImageName isBlank]) {
        [leftButton setImage:[UIImage imageNamed:highLightImageName] forState:UIControlStateHighlighted];
    }
    
    if (![normalBackgroundImageName isBlank]) {
        [leftButton setBackgroundImage:[UIImage imageNamed:normalBackgroundImageName] forState:UIControlStateNormal];
    }
    
    if (![highLightBackgroudImageName isBlank]) {
        [leftButton setBackgroundImage:[UIImage imageNamed:highLightBackgroudImageName] forState:UIControlStateHighlighted];
    }
    
    if (![normaltext isBlank]) {
        [leftButton setTitle:normaltext forState:UIControlStateNormal];
    }
    
    if (![highLightText isBlank]) {
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
    
    if (![imageName isBlank]) {
        UIImageView *backgroundImage =[[UIImageView alloc] init];
        backgroundImage.image = [UIImage imageNamed:imageName];
        backgroundImage.frame = self.view.bounds;
        [self.view insertSubview:backgroundImage atIndex:0];
    }

}


#pragma mark - 点击事件
- (void)leftNavItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}




@end
