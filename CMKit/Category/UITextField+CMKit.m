//
//  UITextField+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "UITextField+CMKit.h"

@implementation UITextField (CMKit)

/**
 *  设置UITextField左边距
 *
 *  @param leftWidth 边距
 */
- (void)setTextFieldLeftPadding:(CGFloat)leftWidth
{
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
    
}

/**
 设置UITextField 右侧清除按钮图片
 
 @param normalButtonName      常规图片名
 @param highlightedButtonName 高亮图片名
 */
- (void)setTextFieldClearButtonNormal:(NSString *)normalButtonName Highlighted:(NSString *)highlightedButtonName
{
    UIButton *clearButton = [self valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:normalButtonName] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:highlightedButtonName] forState:UIControlStateHighlighted];
    self.clearButtonMode = UITextFieldViewModeAlways;
    
}

/**
 *  设置UITextField Placeholder颜色
 *
 *  @param color 颜色值
 */
- (void)setTextFieldPlaceholderColor:(UIColor *)color
{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
}

/**
 *  设置全局共用UITextField对象的指定格式
 */
+ (void)setTextFieldSpecifiedformat
{
    //设置全局共用UITextField对象的指定格式（在实际开发中自定义）
    [[self alloc] setTextFieldLeftPadding:10];
    
    // TODO:需要设置具体的图片
    [[self alloc] setTextFieldClearButtonNormal:@"" Highlighted:@""];
    
    [[self alloc] setTextFieldPlaceholderColor:[UIColor grayColor]];
    
}


@end
