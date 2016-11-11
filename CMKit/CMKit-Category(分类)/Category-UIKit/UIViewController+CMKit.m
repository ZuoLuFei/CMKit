//
//  UIViewController+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/28.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "UIViewController+CMKit.h"
#import <objc/message.h>


typedef void (*_VIMP)(id,SEL,...);
typedef id (*_IMP)(id,SEL,...);

@implementation UIViewController (CMKit)

/** -------------------------分割线------------------------- */
#pragma mark - method swizzling（method_exchangeImplementations交换方法）-->推荐使用
//加载分类到内存的时候调用，只执行一次
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获取到这个类的viewDidLoad方法,它的类型是一个objc_method结构体指针
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        //获取到自己刚刚新建的一个方法
        Method viewDidLoaded = class_getInstanceMethod(self, @selector(viewDidLoaded));
        
        //互换两个方法实现
        method_exchangeImplementations(viewDidLoad, viewDidLoaded);
        
    });
    
}


//不能在分类中重写系统方法viewDidLoad，因为会把系统的功能给覆盖掉，而且分类中不能调用super.

//替换viewDidLoad的方法
- (void)viewDidLoaded{
    // 这里调用viewDidLoaded，相当于调用viewDidLoad
    [self viewDidLoaded];//进过验证，其实这样注释掉也不会影响使用，为什么？
    
    NSLog(@"%@ did load",self);
    
    //打印结果是：<UIStatusBarViewController: 0x7f9042d15e10> did load
}

/** -------------------------分割线------------------------- */
#pragma mark - IMP指针-->不推荐使用
////加载分类到内存的时候调用，只执行一次
//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//       //获取到这个类的viewDidLoad方法,它的类型是一个objc_method结构体指针
//        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
//        //获取方法实现
//        _VIMP viewDidLoad_IMP = (_VIMP)method_getImplementation(viewDidLoad);
//        //重新设置方法实现
//        method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target,SEL action){
//            //调用原有方法实现
//            viewDidLoad_IMP(target,@selector(viewDidLoad));
//            //新增代码
//            NSLog(@"%@ did load",self);
//
//            //打印结果是：UIViewController did load
//
//        }));
//
//    });
//
//}

@end
