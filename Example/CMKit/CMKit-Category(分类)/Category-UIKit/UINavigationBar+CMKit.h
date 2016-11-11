//
//  UINavigationBar+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UINavigationBar的有用方法
 */
@interface UINavigationBar (CMKit)

/**
 *  设置UINavigationBar是否透明
 *
 *  @param transparent YES透明，NO不透明
 */
- (void)setTransparent:(BOOL)transparent;

/**
 *  设置UINavigationBar是否透明、半透明
 *
 *  @param transparent YES透明，NO不透明
 *  @param translucent 一个决定UINavigationBar是否半透明的Boolean值参数
 */
- (void)setTransparent:(BOOL)transparent translucent:(BOOL)translucent;

@end
