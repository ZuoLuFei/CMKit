//
//  UILabel+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  此分类增加了一些关于UILabel的有用方法
 */
@interface UILabel (CMKit)

/**
 *  基于Label的text、width、font计算其height
 *
 *  @return 返回计算的高
 */
- (CGFloat)calculatedHeight;


/**
 *  在指定的索引范围内设置一个自定义的字体font
 *
 *  @param font      被设置的新字体格式
 *  @param fromIndex 开始索引
 *  @param toIndex   结束索引
 */
- (void)setFont:(UIFont * _Nonnull)font
      fromIndex:(NSInteger)fromIndex
        toIndex:(NSInteger)toIndex;


@end
