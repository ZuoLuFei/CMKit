//
//  CMHeadView.m
//  CMKit
//
//  Created by HC on 16/11/17.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMHeadView.h"

@interface CMHeadView ()

@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation CMHeadView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //1.背景色
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        
        //2.
        UILabel *label = [[UILabel alloc] init];
        self.titleLabel = label;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:17.0f];
        label.textColor = [UIColor blackColor];
        label.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 35);
        [self.contentView addSubview:label];
        
        //3.分割线
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 34.0, self.bounds.size.width, 1.0f)];
        lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
        [self.contentView addSubview:lineView];

    }
    
    return self;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    
    self.titleLabel.text = titleStr;
    
}


@end
