//
//  NSObject+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "NSObject+CMKit.h"

@implementation NSObject (CMKit)

- (BOOL)isValid {
    return !(self == nil || [self isKindOfClass:[NSNull class]]);
}


@end
