//
//  CMAnimationSampleController.m
//  CMKit
//
//  Created by HC on 16/10/31.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMAnimationSampleController.h"
#import "CMBaseAnimationSampleController.h"
#import "CMTransitionAnimationSampleController.h"

@interface CMAnimationSampleController ()

@end

@implementation CMAnimationSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)animationButtonClick:(id)sender {
    CMBaseAnimationSampleController *animation = [[CMBaseAnimationSampleController alloc] init];
    [self.navigationController pushViewController:animation animated:YES];
}
- (IBAction)TransitionAnimationButtonClick:(id)sender {
    CMTransitionAnimationSampleController *transition = [[CMTransitionAnimationSampleController alloc] init];
    [self.navigationController pushViewController:transition animated:YES];
}

@end
