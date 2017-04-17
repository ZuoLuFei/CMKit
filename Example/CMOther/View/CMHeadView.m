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

@property (nonatomic, strong) UIView *lineView;




@end

@implementation CMHeadView


#pragma mark - 属性设置
- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    
    self.titleLabel.text = titleStr;
    
}

- (void)setHight:(CGFloat)hight {
    _hight = hight;
    
    [self layoutIfNeeded];

}


#pragma mark - 工厂方法
+ (instancetype)headView {
    
    CMHeadView *headView = [[CMHeadView alloc] initWithReuseIdentifier:@"CMHeadView"];
    return headView;
    
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //1.背景色
//        self.contentView.backgroundColor = [UIColor redColor];
//        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
        
        //2.
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
        self.titleLabel = label;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.font = [UIFont boldSystemFontOfSize:17.0f];
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        
        //3.分割线
        UIView *lineView         = [[UIView alloc] init];
        self.lineView = lineView;
        lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
        [self.contentView addSubview:lineView];

    }
    
    return self;
}

- (void)layoutSubviews {

    if (!_hight) {
        self.titleLabel.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 35.0);
        
        self.lineView.frame = CGRectMake(0, 34.0, DEF_SCREEN_WIDTH, 1.0f);
    }else{
        self.titleLabel.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, _hight);
        
        self.lineView.frame = CGRectMake(0, _hight-1.0f, DEF_SCREEN_WIDTH, 1.0f);
    }
    
    
}



@end
