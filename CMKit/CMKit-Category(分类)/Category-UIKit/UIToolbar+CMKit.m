//
//  UIToolbar+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "UIToolbar+CMKit.h"

@implementation UIToolbar (CMKit)

- (void)setTransparent:(BOOL)transparent {
    if (transparent) {
        [self setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
    } else {
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self setShadowImage:nil forToolbarPosition:UIBarPositionAny];
    }
}

@end
