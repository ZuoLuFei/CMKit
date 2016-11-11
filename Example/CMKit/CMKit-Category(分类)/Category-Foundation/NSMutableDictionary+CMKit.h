//
//  NSMutableDictionary+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  此分类增加了一些关于NSMutableDictionary的有用方法
 */
@interface NSMutableDictionary (CMKit)

/**
 *  安全的在字典中设置key对应value值
 *
 *  @param anObject value值
 *  @param aKey     key值
 *
 *  @return YES操作成功，NO失败
 */
- (BOOL)safeSetObject:(id _Nonnull)anObject
               forKey:(id<NSCopying> _Nonnull)aKey;

@end
