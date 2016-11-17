//
//  UTTestCell.m
//  UTDemo
//
//  Created by yons on 16/10/31.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "UTTestCell.h"

@implementation UTTestCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    
    return self;
}
@end
