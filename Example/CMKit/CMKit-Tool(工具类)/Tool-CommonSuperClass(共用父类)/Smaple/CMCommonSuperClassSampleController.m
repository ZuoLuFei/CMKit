//
//  CMCommonSuperClassSampleController.m
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMCommonSuperClassSampleController.h"

@interface CMCommonSuperClassSampleController ()

@end

@implementation CMCommonSuperClassSampleController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
}
    
#pragma mark - 初始化UI
- (void)initUI{
    self.title = @"共用父类";
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"详细使用请看AppDelegate和\nCMCommonSuperClassSampleController类的使用";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.frame = self.view.bounds;
    [self.view addSubview:label];
    
    
    
}



@end
