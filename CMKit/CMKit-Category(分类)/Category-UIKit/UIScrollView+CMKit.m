//
//  UIScrollView+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "UIScrollView+CMKit.h"

@implementation UIScrollView (CMKit)

+ (instancetype _Nonnull)initWithFrame:(CGRect)frame contentSize:(CGSize)contentSize clipsToBounds:(BOOL)clipsToBounds pagingEnabled:(BOOL)pagingEnabled showScrollIndicators:(BOOL)showScrollIndicators delegate:(id<UIScrollViewDelegate> _Nullable)delegate {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [scrollView setDelegate:delegate];
    [scrollView setPagingEnabled:pagingEnabled];
    [scrollView setClipsToBounds:clipsToBounds];
    [scrollView setShowsVerticalScrollIndicator:showScrollIndicators];
    [scrollView setShowsHorizontalScrollIndicator:showScrollIndicators];
    [scrollView setContentSize:contentSize];
    
    return scrollView;
}

@end
