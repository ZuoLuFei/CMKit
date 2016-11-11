//
//  NSProcessInfo+CMKIt.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  此分类增加了一些关于NSProcessInfo的有用方法
 */
@interface NSProcessInfo (CMKIt)

/**
 *  返回当前APP对CPU的使用量
 *
 *  @return 返回当前APP对CPU的使用量
 */
+ (float)currentAppCPUUsage;

@end
