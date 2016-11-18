//
//  CMCollectionViewWaterfallCell.m
//  CMKit
//
//  Created by HC on 16/11/18.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMCollectionViewWaterfallCell.h"

@interface CMCollectionViewWaterfallCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CMCollectionViewWaterfallCell

#pragma mark - Accessors
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

#pragma mark - Overwrite set
- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
    self.imageView.alpha = 0;
    self.imageView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    
    [UIView animateWithDuration:1.0f animations:^{
        
        self.imageView.alpha = 1.f;
        self.imageView.transform = CGAffineTransformMakeScale(1.f, 1.f);
    }];
    
}


@end
