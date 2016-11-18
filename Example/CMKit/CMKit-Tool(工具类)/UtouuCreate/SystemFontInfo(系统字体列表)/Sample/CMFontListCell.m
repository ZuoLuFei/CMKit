//
//  CMFontListCell.m
//  CMKit
//
//  Created by HC on 16/11/17.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMFontListCell.h"

@interface CMFontListCell ()

@property (nonatomic, strong) UILabel *fontLabel;

@end

@implementation CMFontListCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        self.fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, DEF_SCREEN_WIDTH - 20, 40)];
        [self addSubview:self.fontLabel];

    }
    
    return self;
}

- (void)setFontStr:(NSString *)fontStr{
    
    _fontStr = fontStr;
    
    self.fontLabel.text = fontStr;
    self.fontLabel.font = [UIFont fontWithName:fontStr size:12.f];
    
    
}


@end
