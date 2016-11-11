//
//  UIWebView+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIWebView的有用方法
 */
@interface UIWebView (CMKit)

/**
 *  移除当前UIWebView的背景阴影
 */
- (void)removeBackgroundShadow;

/**
 *  加载网址
 *
 *  @param website 需要加载的网址
 */
- (void)loadWebsite:(NSString * _Nonnull)website;

@end
