//
//  ZJVc7Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc7Controller.h"
#import "ZJScrollPageView.h"
#import "ZJTestViewController.h"

@interface ZJVc7Controller ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@property (weak, nonatomic) ZJScrollPageView *scrollPageView;

@end

@implementation ZJVc7Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"效果示例";

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
    self.titles = @[@"新闻头条",
                    @"国际要闻",
                    @"体育",
                    @"中国足球",
                    @"汽车",
                    @"囧途旅游",
                    @"幽默搞笑",
                    @"视频",
                    @"无厘头",
                    @"美女图片",
                    @"今日房价",
                    @"头像",
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    self.scrollPageView = scrollPageView;
    
    [self.view addSubview:self.scrollPageView];
    
    
    
    // 左导航内容
    NSString *leftNavTitle = @"切换内容";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    CGSize size = [leftNavTitle sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(CGFLOAT_MAX, 25)];
    button.frame = CGRectMake(0, 0, size.width+28, 44);
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [button setTitle:leftNavTitle forState:UIControlStateNormal];
    [button setTitle:leftNavTitle forState:UIControlStateHighlighted];
  
    
    [button addTarget:self action:@selector(changeBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.exclusiveTouch = YES;//关闭多点
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -15;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSeperator,rightItem, nil];
    } else {
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}




- (void)changeBtnOnClick:(UIBarButtonItem *)sender {
    self.titles = [self setupNewTitles];
    // 传入新的titles同时reload
    [self.scrollPageView reloadWithNewTitles:self.titles];
    
}

- (NSArray *)setupNewTitles {
    
    NSMutableArray *tempt = [NSMutableArray array];
    for (int  i =0; i < 20; i++) {
        [tempt addObject:[NSString stringWithFormat:@"新标题%d",i]];
    }
    
    return tempt;
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}


- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [[ZJTestViewController alloc] init];
    }
    
    
    if (index%2==0) {
        childVc.view.backgroundColor = [UIColor blueColor];
    } else {
        childVc.view.backgroundColor = [UIColor greenColor];
        
    }
    
    return childVc;
}


@end
