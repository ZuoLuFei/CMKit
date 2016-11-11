//
//  NSMutableDictionary+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "NSMutableDictionary+CMKit.h"

@implementation NSMutableDictionary (CMKit)

- (BOOL)safeSetObject:(id _Nonnull)anObject forKey:(id<NSCopying> _Nonnull)aKey {
    if (anObject == nil) {
        return NO;
    }
    
    [self setObject:anObject forKey:aKey];
    
    return YES;
}

@end
