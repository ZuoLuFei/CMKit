//
//  UILabel+CMKit.m
//  CMKit-HCCategory
//
//  Created by HC on 16/10/26.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "UILabel+CMKit.h"

@implementation UILabel (CMKit)

- (CGFloat)calculatedHeight {
    CGSize size = CGSizeZero;
    if (self.text.length > 0) {
        CGRect frame = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: self.font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    
    return size.height;
}

- (void)setFont:(UIFont * _Nonnull)font fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(fromIndex, toIndex - fromIndex)];
    
    [self setAttributedText:attributedString];
}


@end
