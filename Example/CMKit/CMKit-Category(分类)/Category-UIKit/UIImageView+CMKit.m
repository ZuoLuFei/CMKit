//
//  UIImageView+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "UIImageView+CMKit.h"

@implementation UIImageView (CMKit)

+ (instancetype _Nonnull)initWithImage:(UIImage * _Nonnull)image frame:(CGRect)rect {
    UIImageView *_image = [[UIImageView alloc] init];
    [_image setFrame:rect];
    [_image setImage:image];
    return _image;
}

+ (instancetype _Nonnull)initWithImage:(UIImage * _Nonnull)image size:(CGSize)size center:(CGPoint)center {
    UIImageView *_image = [[UIImageView alloc] init];
    [_image setFrame:CGRectMake(0, 0, size.width, size.height)];
    [_image setImage:image];
    [_image setCenter:center];
    return _image;
}

+ (instancetype _Nonnull)initWithImage:(UIImage * _Nonnull)image center:(CGPoint)center {
    UIImageView *_image = [[UIImageView alloc] init];
    [_image setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [_image setImage:image];
    [_image setCenter:center];
    return _image;
}

+ (instancetype _Nonnull)initWithImageAsTemplate:(UIImage * _Nonnull)image tintColor:(UIColor * _Nonnull)tintColor {
    UIImageView *_image = [[UIImageView alloc] init];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_image setImage:image];
    [_image setTintColor:tintColor];
    return _image;
}

- (void)setImageShadowColor:(UIColor * _Nonnull)color radius:(CGFloat)radius offset:(CGSize)offset opacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
}

- (void)setMaskImage:(UIImage * _Nonnull)image {
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[image CGImage];
    mask.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.layer.mask = mask;
    self.layer.masksToBounds = YES;
}

- (void)setFrameInSuperViewCenterWithSize:(CGSize)size
{
    self.frame = CGRectMake((self.superview.frame.size.width - size.width) / 2, (self.superview.frame.size.height - size.height) / 2, size.width, size.height);
}

@end
