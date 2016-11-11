//
//  CMCyclePictureSampleController.m
//  CMKit
//
//  Created by HC on 16/11/1.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMCyclePictureSampleController.h"
#import "UTCycleScrollView.h"

@interface CMCyclePictureSampleController ()<UTCycleScrollViewDelegate>

@property (nonatomic, strong) UTCycleScrollView *scrollview;

@end

@implementation CMCyclePictureSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}


#pragma mark - 初始化UI
- (void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *scrBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 80, 80, 40)];
    [scrBtn setTitle:@"开始轮播" forState:UIControlStateNormal];
    [scrBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [scrBtn addTarget:self action:@selector(cyclePictureViewer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scrBtn];
}

#pragma mark cycle picture view
- (void)cyclePictureViewer {
    if (!self.scrollview) {
        self.scrollview = [[UTCycleScrollView alloc] initWithFrame:CGRectMake(20, 140, self.view.frame.size.width-40, 160)];
        self.scrollview.delegate = self;
        self.scrollview.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.scrollview.localizationImageNamesGroup = @[@"00.jpg",@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg"];
        
        self.scrollview.titlesGroup = @[@"00.jpg",@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg"];
        
        self.scrollview.autoScrollTimeInterval = 2.0;
        [self.view addSubview:self.scrollview];
        
        [self.scrollview adjustWhenControllerViewWillAppera];
    }
    self.scrollview.hidden = NO;
    
}


@end
