//
//  UIView+Layout.h
//
//  Created by yons on 15/2/24.
//  Copyright © 2015年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,UTOscillatoryAnimationType) {
    UTOscillatoryAnimationToBigger,
    UTOscillatoryAnimationToSmaller,
};

@interface UIView (Layout)

@property (nonatomic) CGFloat ut_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat ut_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat ut_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat ut_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat ut_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat ut_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat ut_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat ut_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint ut_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  ut_size;        ///< Shortcut for frame.size.

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(UTOscillatoryAnimationType)type;

@end
