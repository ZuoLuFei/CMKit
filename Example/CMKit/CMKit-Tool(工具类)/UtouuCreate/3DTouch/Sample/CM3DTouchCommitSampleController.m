//
//  CM3DTouchCommitSampleController.m
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CM3DTouchCommitSampleController.h"

@interface CM3DTouchCommitSampleController ()

@end

@implementation CM3DTouchCommitSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMe)];
    [self.view addGestureRecognizer:tap];
    
    
}

- (void)dismissMe {
    
    // dismisses the current view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
