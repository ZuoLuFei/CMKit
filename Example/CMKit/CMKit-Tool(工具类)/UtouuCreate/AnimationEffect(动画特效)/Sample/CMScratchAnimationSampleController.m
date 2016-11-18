//
//  CMScratchAnimationSampleController.m
//  CMKit
//
//  Created by HC on 16/11/18.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMScratchAnimationSampleController.h"
#import "MDScratchImageView.h"

@interface CMScratchAnimationSampleController ()

@end

@implementation CMScratchAnimationSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor       = [UIColor whiteColor];
    self.view.layer.masksToBounds = YES;
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    
    // 背景图片
    UIImageView *blurImageView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointZero, image.size}];
    blurImageView.image        = image;
    blurImageView.center       = self.view.center;
    [self.view addSubview:blurImageView];
    
    // 被刮的图片
    MDScratchImageView *scratchImageView = [[MDScratchImageView alloc] initWithFrame:blurImageView.frame];
    [scratchImageView setImage:[image imageBlurEffect] radius:30.f];
    [self.view addSubview:scratchImageView];
}


@end
