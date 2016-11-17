//
//  CMDataStructures.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/28.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "CMDataStructures.h"
#import "NSArray+CMKit.h"

#pragma mark - 堆栈

@interface Stack () {
    NSMutableArray *stack;
}
@end

@implementation Stack

- (instancetype _Nonnull)init {
    if (self = [super init]) {
        stack = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString * _Nonnull)description {
    return [NSString stringWithFormat:@"%@", stack];
}

- (BOOL)empty {
    return stack.count > 0 ? YES : NO;
}

- (void)push:(id _Nonnull)object {
    [stack addObject:object];
}

- (id _Nullable)pop {
    id popped = nil;
    if (![self empty]) {
        popped = stack[stack.count - 1];
        [stack removeObjectAtIndex:stack.count - 1];
    }
    
    return popped;
}

@end

#pragma mark - 列表

@interface List () {
    NSMutableArray *list;
}
@end

@implementation List

- (instancetype _Nonnull)init {
    if (self = [super init]) {
        list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString * _Nonnull)description {
    return [NSString stringWithFormat:@"%@", list];
}

- (NSInteger)searchObject:(id _Nonnull)object {
    return [list indexOfObject:object];
}

- (id _Nullable)searchObjectAtIndex:(NSInteger)index {
    return [list safeObjectAtIndex:index];
}

- (void)insert:(id _Nonnull)object {
    [list addObject:object];
}

- (BOOL)deleteObject:(id _Nonnull)object {
    if ([self searchObject:object]) {
        [list removeObject:object];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)deleteObjectAtIndex:(NSInteger)index {
    if (index > 0 && index <= list.count) {
        [list removeObjectAtIndex:index];
        return YES;
    } else {
        return NO;
    }
}

@end

#pragma mark - 队列

@interface Queue () {
    NSMutableArray *queue;
}
@end

@implementation Queue

- (instancetype _Nonnull)init {
    if (self = [super init]) {
        queue = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString * _Nonnull)description {
    return [NSString stringWithFormat:@"%@", queue];
}

- (void)enqueue:(id _Nonnull)object {
    [queue addObject:object];
}

- (BOOL)dequeue {
    if (queue.count > 0) {
        [queue removeObjectAtIndex:0];
        return YES;
    } else {
        return NO;
    }
}

- (id _Nullable)top {
    if (queue.count > 0) {
        return [queue objectAtIndex:queue.count -1];
    } else {
        return nil;
    }
}

- (void)emptyQueue {
    [queue removeAllObjects];
}

@end
