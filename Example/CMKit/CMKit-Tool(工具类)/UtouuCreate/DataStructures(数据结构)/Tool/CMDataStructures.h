//
//  CMDataStructures.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/28.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - 堆栈
/**
 *  原始的堆栈实现
 */
@interface Stack : NSObject
/**
 *  初始化堆栈
 *
 *  @return 返回堆栈对象
 */
- (instancetype _Nonnull)init;

/**
 *  堆栈的描述
 *
 *  @return 堆栈的描述
 */
- (NSString * _Nonnull)description;

/**
 *  返回堆栈是否为空
 *
 *  @return YES空，NO非空
 */
- (BOOL)empty;

/**
 *  在栈顶增加一个元素
 *
 *  @param object 被增加的元素
 */
- (void)push:(id _Nonnull)object;

/**
 *  从栈顶移除一个元素
 *
 *  @return 返回被移除的元素
 */
- (id _Nullable)pop;

@end

#pragma mark - 列表
/**
 *  原始的列表实现
 */
@interface List : NSObject

/**
 *  初始化列表
 *
 *  @return 返回列表对象
 */
- (instancetype _Nonnull)init;

/**
 *  列表的描述
 *
 *  @return 列表的描述
 */
- (NSString * _Nonnull)description;

/**
 *  搜索一个元素并返回索引值
 *
 *  @param object 被搜索的元素
 *
 *  @return 返回被搜索元素的索引值
 */
- (NSInteger)searchObject:(NSObject * _Nonnull)object;

/**
 *  通过索引值搜索并返回一个元素
 *
 *  @param index 索引值
 *
 *  @return 返回通过索引值搜索到的元素
 */
- (id _Nullable)searchObjectAtIndex:(NSInteger)index;

/**
 *  添加一个元素到列表
 *
 *  @param object 被添加到列表的元素
 */
- (void)insert:(id _Nonnull)object;

/**
 *  从列表中删除一个元素
 *
 *  @param object 被删除的对象
 *
 *  @return YES删除成功，NO删除失败
 */
- (BOOL)deleteObject:(id _Nonnull)object;

/**
 *  通过给出的索引值删除一个元素
 *
 *  @param index 索引值
 *
 *  @return YES删除成功，NO删除失败
 */
- (BOOL)deleteObjectAtIndex:(NSInteger)index;

@end

#pragma mark - 队列
/**
 *  原始的队列实现
 */
@interface Queue : NSObject

/**
 *  初始化队列
 *
 *  @return 返回队列对象
 */
- (_Nonnull instancetype)init;

/**
 *  队列的描述
 *
 *  @return 队列的描述
 */
- (NSString * _Nonnull)description;

/**
 *  添加一个元素到队列中
 *
 *  @param object 被添加的元素
 */
- (void)enqueue:(id _Nonnull)object;

/**
 *  移除队列中的第一个元素
 *
 *  @return YES移除成功，NO移除失败
 */
- (BOOL)dequeue;

/**
 *  返回队列顶部的元素
 *
 *  @return 返回队列顶部的元素
 */
- (id _Nullable)top;

/**
 *  移除队列中的所有元素
 */
- (void)emptyQueue;

@end
