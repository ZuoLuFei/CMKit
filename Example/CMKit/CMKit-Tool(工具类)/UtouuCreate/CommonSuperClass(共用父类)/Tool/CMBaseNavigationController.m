//
//  CMBaseNavigationController.m
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMBaseNavigationController.h"

@interface CMBaseNavigationController ()

@end

@implementation CMBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [CMBaseNavigationController setNavigationBarTitleAttribute:[UIColor redColor] tintColor:[UIColor blackColor]];
}


+ (void)setNavigationBarTitleAttribute:(UIColor * _Nullable)titleColor tintColor:(UIColor * _Nullable)tintColor{
    
    //navigationBar所有字体颜色
    if (tintColor != nil) {
        [[UINavigationBar appearance] setTintColor:tintColor];
    }
    
    //主题字颜色
    if (titleColor != nil) {
        NSDictionary *dict = @{NSForegroundColorAttributeName:titleColor};
        [[UINavigationBar appearance] setTitleTextAttributes:dict];
    }


}


+ (CMBaseNavigationController * _Nonnull)createNavigationController:(UIViewController * _Nonnull)viewController title:(NSString * _Nullable)title normalTitleColor:(UIColor * _Nullable)normalTitleColor highLightTitleColor:(UIColor * _Nullable)highLightTitleColor normalImage:(NSString * _Nullable)normalImage selectedImage:(NSString * _Nullable)selecteImage fontOfSize:(CGFloat)fontSize{
    
    // 设置标题
    UIViewController *viewVc = viewController;
    if (![self isBlankString:title]) {
        viewVc.title = title;
    }
    
    //设置tabBarItem的普通文字颜色和大小
    if (normalTitleColor != nil) {
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = normalTitleColor;
        textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:fontSize];
        [viewVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    }

    
    //设置tabBarItem的选中文字颜色和大小
    if (highLightTitleColor != nil) {
        NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
        selectedTextAttrs[NSForegroundColorAttributeName] = highLightTitleColor;
        selectedTextAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:fontSize];
        [viewVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    }
    
    // 设置tabBarItem的普通图标
    if (![self isBlankString:normalImage]) {
        UIImage *NormalImage = [UIImage imageNamed:normalImage];
        NormalImage = [NormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewVc.tabBarItem.image = NormalImage;
    }
    
    // 设置tabBarItem的高亮图标
    if (![self isBlankString:selecteImage]) {
        UIImage *selectedImage = [UIImage imageNamed:selecteImage];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewVc.tabBarItem.selectedImage = selectedImage;
    }
    
    CMBaseNavigationController *navigationController =[[CMBaseNavigationController alloc] initWithRootViewController:viewVc];
    
    return navigationController;
}

- (instancetype _Nonnull)initWithRootViewController:(UIViewController * _Nonnull)rootViewController setNavigationBarHidden:(BOOL)hidden{
    CMBaseNavigationController *ncController = [[[self class] alloc] initWithRootViewController:rootViewController];
    [ncController setNavigationBarHidden:hidden animated:NO];
//    [rootViewController useInteractivePopGestureRecognizer];
    
    return ncController;

}

#pragma mark - 覆写父类方法
//push的控制器非根控制器时，隐藏底部BottomBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 私有方法,避免导入NSString+CMKit，解耦
+ (BOOL)isBlankString:(NSString * _Nonnull)string
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
