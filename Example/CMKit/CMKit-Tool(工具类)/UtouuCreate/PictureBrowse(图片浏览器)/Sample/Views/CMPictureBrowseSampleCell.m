//
//  CMPictureBrowseSampleCell.m
//  CMKit
//
//  Created by HC on 16/11/25.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMPictureBrowseSampleCell.h"
#import "UIImageView+WebCache.h"

@interface CMPictureBrowseSampleCell ()

@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation CMPictureBrowseSampleCell


#pragma mark - set方法
- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"profile-image-placeholder.png"]];
    
}

#pragma mark -
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
}

@end
