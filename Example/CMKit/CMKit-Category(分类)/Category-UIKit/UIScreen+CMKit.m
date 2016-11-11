//
//  UIScreen+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "UIScreen+CMKit.h"

@implementation UIScreen (CMKit)

+ (BOOL)isRetina {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0 || [UIScreen mainScreen].scale == 3.0)) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isRetinaHD {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 3.0)) {
        return YES;
    } else {
        return NO;
    }
}

+ (CGFloat)brightness {
    return [UIScreen mainScreen].brightness;
}

+ (void)setBrightness:(CGFloat)brightness {
    [[UIScreen mainScreen] setBrightness:brightness];
}

@end
