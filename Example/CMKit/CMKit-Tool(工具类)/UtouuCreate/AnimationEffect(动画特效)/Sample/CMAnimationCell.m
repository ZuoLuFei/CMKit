//
//  CMAnimationCell.m
//  CMKit
//
//  Created by HC on 16/11/3.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMAnimationCell.h"


@interface CMAnimationCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CMAnimationCell


- (void)setCellStr:(NSString *)cellStr{
    _cellStr = cellStr;
    self.label.text = cellStr;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _label.backgroundColor = [UIColor lightGrayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        [self addSubview:_label];
    }
    
    return self;
}

@end
