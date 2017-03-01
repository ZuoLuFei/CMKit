//
//  CMNewFeaturesController.m
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMNewFeaturesController.h"


/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *	生成RGB颜色
 *
 *	@param 	_red 	red值（0~255）
 *	@param 	_green 	green值（0~255）
 *	@param 	_blue 	blue值（0~255）
 *
 *	@return	UIColor对象
 */
#define DEF_RGB_COLOR(_red, _green, _blue) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:1]

/**
 *  iPhone4_4s设备
 */
#define DEF_iPhone4_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

@interface CMNewFeaturesController () <UIScrollViewDelegate>

/** ScrollView */
@property (strong , nonatomic) UIScrollView *scrollView;

/** PageControl */
@property (strong , nonatomic) UIPageControl *pageControl;

@end

@implementation CMNewFeaturesController

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 创建UI
        [self initUI];
        
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //  配置UI
    [self configUI];
}


#pragma mark - 创建UI控件
- (void)initUI {
    
    // 创建scrollView
    [self createScrollView];
    
    // 创建pageControl
    [self createPageControl];
    
    
    // 创建关联UI
    [self createExperienceBtn];
    
}

//创建立即体验Btn
- (void)createExperienceBtn {
    UIButton *experienceBtn = [[UIButton alloc] init];
    self.experienceBtn = experienceBtn;
    [experienceBtn setTitle:@"退出新特性 >" forState:UIControlStateNormal];
    experienceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [experienceBtn setBackgroundImage:[UIImage imageNamed:@"btn01_normal@2x.png"] forState:UIControlStateNormal];
    [experienceBtn setBackgroundImage:[UIImage imageNamed:@"btn01_on@2x.png"] forState:UIControlStateHighlighted];
    [experienceBtn addTarget:self action:@selector(experienceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//创建PageControl
- (void)createPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.pageIndicatorTintColor = DEF_RGB_COLOR(133, 128, 127);
    pageControl.currentPageIndicatorTintColor = DEF_RGB_COLOR(171, 11, 66);
}


//创建scrollView
- (void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;

    
}

#pragma mark - 配置UI
- (void)configUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configScrollViewFrame];
    
    if (self.featuresArray.count > 1) {
        [self configPageControlFrame];
    }
    
    
    [self configAssociatedUIFrame];
    
}

// 配置pageControl
- (void)configScrollViewFrame
{
    self.scrollView.contentSize = CGSizeMake(DEF_SCREEN_WIDTH * self.featuresArray.count,DEF_SCREEN_HEIGHT);
    [self.view addSubview:self.scrollView];
    
}


// 配置pageControl
- (void)configPageControlFrame
{
    
    self.pageControl.numberOfPages = self.featuresArray.count;
    self.pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
    
    
    CGFloat pageControlW = 100;
    CGFloat pageControlH = 20;
    CGFloat pageControlX = (DEF_SCREEN_WIDTH - pageControlW) / 2 ;
    CGFloat pageControlY = DEF_SCREEN_HEIGHT - 30 - pageControlH;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    [self.view addSubview:self.pageControl];
    
}

// 配置关联UI
- (void)configAssociatedUIFrame {
    
    
    for (int i = 0; i<self.featuresArray.count; i++) {
        
        //1.创建imageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *imageStr = [NSString stringWithFormat:@"%@",self.featuresArray[i]];
        imageView.image = [UIImage imageNamed:imageStr];
        
        CGFloat imageViewX = i * DEF_SCREEN_WIDTH;
        CGFloat imageViewY = 0;
        CGFloat imageViewW = DEF_SCREEN_WIDTH;
        CGFloat imageViewH = DEF_SCREEN_HEIGHT;
        
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        
        [self.scrollView addSubview:imageView];
        
        
        //2.在ScrollView中最后一张添加“立即体验”按钮
        if (i == (self.featuresArray.count - 1)) {
            [self configExperienceBtn:(int)(self.featuresArray.count - 1)];
        }
    }
}

/** 设置立即体验按钮 */
- (void)configExperienceBtn:(int)i
{
    CGFloat experienceBtnX = 20 + DEF_SCREEN_WIDTH * i;
    CGFloat experienceBtnW = DEF_SCREEN_WIDTH - 2 * 20;
    CGFloat experienceBtnH = 40;
    CGFloat experienceBtnY;
    
    if (DEF_iPhone4_4s) {//iPhone 4/4s
        experienceBtnY = DEF_SCREEN_HEIGHT - 50 - experienceBtnH - 20;
    }else{//iPhone 5以上屏幕
        experienceBtnY = DEF_SCREEN_HEIGHT - 50 - experienceBtnH - 30;
    }
    
    self.experienceBtn.frame = CGRectMake(experienceBtnX, experienceBtnY, experienceBtnW, experienceBtnH);
    
    [self.scrollView addSubview:self.experienceBtn];
    
}

#pragma mark - 按钮事件
/** 立即体验按钮事件 */
- (void)experienceBtnClick
{
    if (self.experienceBtnBlock) {
        self.experienceBtnBlock();
    }
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //设置pageControl的currentPage属性
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    int pageNumber = (int)(doublePage + 0.5);
    self.pageControl.currentPage = pageNumber;
    
}


@end
