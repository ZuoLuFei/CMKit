//
//  UIToolbar+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIToolbar的有用方法
 */
@interface UIToolbar (CMKit)

/**
 *  设置UIToolbar是否透明
 *
 *  @param transparent YES透明，NO不透明
 */
- (void)setTransparent:(BOOL)transparent;

@end
