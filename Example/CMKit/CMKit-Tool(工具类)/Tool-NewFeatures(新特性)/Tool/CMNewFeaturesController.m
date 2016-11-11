//
//  CMNewFeaturesController.m
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMNewFeaturesController.h"

@interface CMNewFeaturesController () <UIScrollViewDelegate>

/** ScrollView */
@property (strong , nonatomic) UIScrollView *scrollView;

/** PageControl */
@property (strong , nonatomic) UIPageControl *pageControl;

@end

@implementation CMNewFeaturesController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建ScrollView
    [self initUI];
    
    //2.创建Data
    [self initData];
    
}


#pragma mark - 创建UI
- (void)initUI
{
    //1.创建scrollView
    [self initScrollView];
    
    //2.创建pageControl
    [self initPageControl];
    
}

//创建scrollView
- (void)initScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(DEF_SCREEN_WIDTH * self.featuresArray.count,DEF_SCREEN_HEIGHT);
    [self.view addSubview:scrollView];
    
}

//创建pageControl
- (void)initPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.numberOfPages = self.scrollView.contentSize.width / DEF_SCREEN_WIDTH;
    pageControl.pageIndicatorTintColor = DEF_RGB_COLOR(133, 128, 127);
    pageControl.currentPageIndicatorTintColor = DEF_RGB_COLOR(171, 11, 66);
    
    
    CGFloat pageControlW = 100;
    CGFloat pageControlH = 20;
    CGFloat pageControlX = (DEF_SCREEN_WIDTH - pageControlW) / 2 ;
    CGFloat pageControlY = DEF_SCREEN_HEIGHT - 30 - pageControlH;
    pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    [self.view addSubview:pageControl];
    
}

#pragma mark - 设置Data
- (void)initData
{
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
            [self setExperienceBtn:(int)(self.featuresArray.count - 1)];
        }
        
    }
}

/** 设置立即体验按钮 */
- (void)setExperienceBtn:(int)i
{
    UIButton *experienceBtn = [[UIButton alloc] init];
    [experienceBtn setTitle:@"立即体验 >" forState:UIControlStateNormal];
    experienceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [experienceBtn setBackgroundImage:[UIImage imageNamed:@"btn01_normal@2x.png"] forState:UIControlStateNormal];
    [experienceBtn setBackgroundImage:[UIImage imageNamed:@"btn01_on@2x.png"] forState:UIControlStateHighlighted];
    [experienceBtn addTarget:self action:@selector(experienceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat experienceBtnX = 20 + DEF_SCREEN_WIDTH * i;
    CGFloat experienceBtnW = DEF_SCREEN_WIDTH - 2 * 20;
    CGFloat experienceBtnH = 40;
    CGFloat experienceBtnY;
    
    if (DEF_iPhone4_4s) {//iPhone 4/4s
        experienceBtnY = CGRectGetMinY(self.pageControl.frame) - experienceBtnH - 20;
    }else{//iPhone 5以上屏幕
        experienceBtnY = CGRectGetMinY(self.pageControl.frame) - experienceBtnH - 30;
    }
    
    experienceBtn.frame = CGRectMake(experienceBtnX, experienceBtnY, experienceBtnW, experienceBtnH);
    
    [self.scrollView addSubview:experienceBtn];
    
    
}

/** 立即体验按钮事件 */
- (void)experienceBtnClick
{

    [self dismissViewControllerAnimated:YES completion:nil];
    
//    //2.存储当前版本号
//    // 获得当前打开软件的版本号
//    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
//    
//    // 存储这次使用的软件版本
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:currentVersion forKey:versionKey];
//    [defaults synchronize];
    
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
