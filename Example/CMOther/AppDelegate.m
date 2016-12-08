//
//  AppDelegate.m
//  CMKit
//
//  Created by HC on 16/10/31.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "AppDelegate.h"

#import "CMToolViewController.h"
#import "CMFoundationCategoryController.h"
#import "CMUIKitCategoryController.h"
#import "CMAnimationSampleController.h"
#import "CM3DTouchSampleController.h"
#import "CMBaseNavigationController.h"
#import "CMNewFeaturesController.h"
#import "CMThirdFrameworkController.h"



static NSString * const shortItemType1 = @"com.utouu.CMKit.Animatation";
static NSString * const shortItemType2 = @"com.utouu.CMKit.Foundation";
static NSString * const shortItemType3 = @"com.utouu.CMKit.UIKit";
static NSString * const shortItemType4 = @"com.utouu.CMKit.3DTouch";

@interface AppDelegate ()

@property (nonatomic, strong) UITabBarController *tabBarController;

@property (nonatomic, strong) CMBaseNavigationController *toolNavigationController;

@property (nonatomic, strong) CMBaseNavigationController *thirdFrameworkNavigationController;

@property (nonatomic, strong) CMBaseNavigationController *foundationNavigationController;

@property (nonatomic, strong) CMBaseNavigationController *uiKitNavigationController;





@property (nonatomic, assign , getter=isLoaded) BOOL loaded;//程序是否载入过

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (!self.isLoaded) {
        //记录表示程序已加载
        self.loaded = YES;
        
        //1.设置根控制器
        [self setupRootViewController];
        
        //2.设置3D Toucn启动设置
        if (DEF_iOS9_LATER) {
            [self createItemsWithIcons];
        }
    }
    
    return YES;
}


#pragma mark - 设置根控制器
- (void)setupRootViewController{
    
    _toolNavigationController = [CMBaseNavigationController createNavigationController:[CMToolViewController new] title:@"UtouuCreate" normalTitleColor:nil highLightTitleColor:nil normalImage:@"utouu" selectedImage:nil fontOfSize:12.0f];
    
    
    _thirdFrameworkNavigationController = [CMBaseNavigationController createNavigationController:[CMThirdFrameworkController new] title:@"Framework" normalTitleColor:nil highLightTitleColor:nil normalImage:@"utouu" selectedImage:nil fontOfSize:12.0f];
    
    
    _foundationNavigationController = [CMBaseNavigationController createNavigationController:[CMFoundationCategoryController new] title:@"Foundation" normalTitleColor:nil highLightTitleColor:nil normalImage:@"utouu" selectedImage:nil fontOfSize:12.0f];
    

    _uiKitNavigationController = [CMBaseNavigationController createNavigationController:[CMUIKitCategoryController new] title:@"UIKit" normalTitleColor:nil highLightTitleColor:nil normalImage:@"utouu" selectedImage:nil fontOfSize:12.0f];
    
    _tabBarController = [[UITabBarController alloc] init];
    [_tabBarController setViewControllers:@[_toolNavigationController,_thirdFrameworkNavigationController,_foundationNavigationController,_uiKitNavigationController]];
    
    self.window.rootViewController = _tabBarController;
    [self.window makeKeyAndVisible];
}



#pragma mark - 创建Touch Items
- (void)createItemsWithIcons{
    
    // 使用系统自带的图标创建icons
    UIApplicationShortcutIcon *playIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay];
    UIApplicationShortcutIcon *pauseIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePause];
    UIApplicationShortcutIcon *shareIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutIcon *searchIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    
    //使用自定义图标创建icons
//    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon1"];

    //特别说明：创建shortcut item分静态创建和动态创建两种方法，尽量使用一种方法创建shortcut item，避免同时使用两种方法创建（如避免同时使用纯代码和xib创建UI一样）
    //动态创建shortcut item
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:shortItemType1 localizedTitle:@"动画特效" localizedSubtitle:@"(动态创建)进入动画特效选择界面" icon:playIcon userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:shortItemType2 localizedTitle:@"Foundation分类" localizedSubtitle:@"(动态创建)进入Foundation分类板块" icon:pauseIcon userInfo:nil];
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:shortItemType3 localizedTitle:@"UIKit分类" localizedSubtitle:@"(动态创建)进入UIkit分类板块" icon:shareIcon userInfo:nil];
    UIMutableApplicationShortcutItem *item4 = [[UIMutableApplicationShortcutItem alloc]initWithType:shortItemType4 localizedTitle:@"3D Touch" localizedSubtitle:@"(动态创建)进入3D Touch展示界面" icon:searchIcon userInfo:nil];
    
    //增加所有的items到一个数组
    NSArray *items = @[item1,item2,item3,item4];
    
    //将动态创建的items和plist中静态创建的items添加到一个新的数组
    NSArray *existingItems = [UIApplication sharedApplication].shortcutItems;
    if (existingItems.count == 0) {
        NSArray *updatedItems = [existingItems arrayByAddingObjectsFromArray:items];
        //重新设置应用的shortcutItems
        [UIApplication sharedApplication].shortcutItems = updatedItems;
    }
    
}


#pragma mark - 3D Touch启动代理
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    if ([shortcutItem.type isEqualToString:shortItemType1]) {
        
        [_tabBarController setSelectedIndex:0];
        CMAnimationSampleController *animationVc = [[CMAnimationSampleController alloc] init];
        animationVc.hidesBottomBarWhenPushed = YES;
        [_toolNavigationController pushViewController:animationVc animated:YES];
        
        
    }else if ([shortcutItem.type isEqualToString:shortItemType2]) {
        [_tabBarController setSelectedIndex:2];
        
    }else if ([shortcutItem.type isEqualToString:shortItemType3]) {
        [_tabBarController setSelectedIndex:3];
        
    }else if ([shortcutItem.type isEqualToString:shortItemType4]) {
        [_tabBarController setSelectedIndex:0];
        CM3DTouchSampleController *touchVc = [[CM3DTouchSampleController alloc] init];
        touchVc.hidesBottomBarWhenPushed = YES;
        [_toolNavigationController pushViewController:touchVc animated:YES];
        
    }
    

}


#pragma mark -
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
