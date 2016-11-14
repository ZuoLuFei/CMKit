//
//  CMCyclePictureSampleController.m
//  CMKit
//
//  Created by HC on 16/11/1.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMCyclePictureSampleController.h"
#import "SDCycleScrollView.h"

@interface CMCyclePictureSampleController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *demoContainerView;

//本地图片实现数组
@property (nonatomic, strong) NSArray *imageNames;

//网络图片实现数组
@property (nonatomic, strong) NSArray *imagesURLStrings;

//图片配文字数组
@property (nonatomic, strong) NSArray *titles;

@end

@implementation CMCyclePictureSampleController

    
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化数据
    [self initData];
    
    //2.初始化UI
    [self initUI];

    
}
    
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    //    [你的CycleScrollview adjustWhenControllerViewWillAppera];
}
    
#pragma mark - 初始化数据
- (void)initData{
    
    //本地图片实现数组
    self.imageNames = @[@"h1.jpg",
                        @"h2.jpg",
                        @"h3.jpg",
                        @"h4.jpg",
                        @"h7.png"];
    
    //网络图片实现数组
    self.imagesURLStrings = @[@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                              @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                              @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    
    //配文字数组
    self.titles = @[@"新建交流QQ群：185534916 ",
                    @"感谢您的支持，如果下载的",
                    @"如果代码在使用过程中出现问题",
                    @"您可以发邮件到gsdios@126.com"];
    
    
}
    
#pragma mark - 初始化UI
- (void)initUI{
    
    //1.初始化背景图片
    [self setupBackground];
    
    //2.本地加载 --- 创建不带标题的图片轮播器
    [self demo1];
    
    //3.网络加载 --- 创建带标题的图片轮播器
    [self demo2];
    
    //4.网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    [self demo3];
    
    //5.网络加载 --- 创建只上下滚动展示文字的轮播器
    [self demo4];
}
    
//初始化背景图片
- (void)setupBackground{

    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
    backgroundView.frame = self.view.bounds;
    [self.view addSubview:backgroundView];
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.demoContainerView = demoContainerView;
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    [self.view addSubview:demoContainerView];
    
    self.title = @"轮播Demo";
}
    
//本地加载 --- 创建不带标题的图片轮播器
-(void)demo1{
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 180) shouldInfiniteLoop:YES imageNamesGroup:self.imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.demoContainerView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;
}
  
// 网络加载 --- 创建带标题的图片轮播器
-(void)demo2{
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, self.view.bounds.size.width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x.png"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = self.titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.demoContainerView addSubview:cycleScrollView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = self.imagesURLStrings;
    });
    
    /*
     block监听点击方式
     
     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
     NSLog(@">>>>>  %ld", (long)index);
     };
     
     */
}

// 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
-(void)demo3{
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图3 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 500, self.view.bounds.size.width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x.png"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot@2x.png"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot@2x.png"];
    cycleScrollView3.imageURLStringsGroup = self.imagesURLStrings;
    
    [self.demoContainerView addSubview:cycleScrollView3];
}
    
// 网络加载 --- 创建只上下滚动展示文字的轮播器
-(void)demo4{
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图4 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    

    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    SDCycleScrollView *cycleScrollView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 750, self.view.bounds.size.width, 40) delegate:self placeholderImage:nil];
    cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScrollView4.onlyDisplayText = YES;
    
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"纯文字上下滚动轮播"];
    [titlesArray addObject:@"纯文字上下滚动轮播 -- demo轮播图4"];
    [titlesArray addObjectsFromArray:self.titles];
    cycleScrollView4.titlesGroup = [titlesArray copy];
    
    [self.demoContainerView addSubview:cycleScrollView4];
    
}
  
#pragma mark - SDCycleScrollViewDelegate
    
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
        NSLog(@"---点击了第%ld张图片", (long)index);
        
        [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}
    
    
/*
 
 // 滚动到第几张图回调
 - (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
 {
    NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
 }
 
 */



@end
