//
//  CMFontListHeaderView.m
//  CMKit
//
//  Created by HC on 16/11/17.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMFontListHeaderView.h"

@interface CMFontListHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CMFontListHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //1.背景色
        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
        
        //2.
        UILabel *colorLabel = [[UILabel alloc] init];
        colorLabel.textColor = [UIColor blackColor];
        colorLabel.backgroundColor = [UIColor redColor];
        colorLabel.frame = CGRectMake(0, 2, 5, 21);
        [self.contentView addSubview:colorLabel];
        
        //3.
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.frame = CGRectMake(5, 0, DEF_SCREEN_WIDTH-5, 25);
        [self.contentView addSubview:titleLabel];
        
        //4.分割线
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 24, DEF_SCREEN_WIDTH, 1.0f)];
        lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        [self.contentView addSubview:lineView];
        
    }
    
    return self;
}


- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    
    self.titleLabel.text = titleStr;
    self.titleLabel.font = [UIFont fontWithName:titleStr size:12.f];
}



@end
