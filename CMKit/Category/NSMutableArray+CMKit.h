//
//  NSMutableArray+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  此分类增加了一些关于NSMutableArray的有用方法
 */
@interface NSMutableArray (CMKit)

/**
 *  将指定索引位置的对象移动到另一个索引位置
 *
 *  @param from 原索引位置
 *  @param to   指定索引位置
 */
- (void)moveObjectFromIndex:(NSUInteger)from
                    toIndex:(NSUInteger)to;

/**
 *  根据自身创建一个倒序的数组
 *
 *  @return 返回倒序数组
 */
- (NSMutableArray * _Nonnull)reversedArray;

/**
 *  根据指定的key对数组进行升序或降序排序
 *
 *  @param key       排序参照key
 *  @param array     被排序处理的数组
 *  @param ascending YES升序，NO降序
 *
 *  @return 返回被处理后的数组
 */
+ (NSMutableArray * _Nonnull)sortArrayByKey:(NSString * _Nonnull)key
                                      array:(NSMutableArray * _Nonnull)array
                                  ascending:(BOOL)ascending;

@end
