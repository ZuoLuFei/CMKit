//
//  CMRevealSampleController.m
//  CMKit
//
//  Created by HC on 16/11/21.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMRevealSampleController.h"
#import "PKRevealController.h"

@interface CMRevealSampleController ()<PKRevealing>

@property (nonatomic, strong, readwrite) PKRevealController *revealController;

@property (nonatomic, strong) UIViewController *frontViewController;

@property (nonatomic, strong) UIViewController *leftViewController;

@property (nonatomic, strong) UIViewController *rightViewController;


@end

@implementation CMRevealSampleController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

#pragma mark - 初始化UI
- (void)initUI{
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建侧滑控制器
    self.revealController = [PKRevealController revealControllerWithFrontViewController:[self frontNavigationController] leftViewController:[self leftViewController] rightViewController:[self rightViewController]];
    [self addChildViewController:self.revealController];
    [self.view addSubview:self.revealController.view];
    
    // 配置侧滑控制器
    self.revealController.delegate = self;
    self.revealController.animationDuration = 0.25;
}


#pragma mark - PKRevealing

- (void)revealController:(PKRevealController *)revealController didChangeToState:(PKRevealControllerState)state
{
    NSLog(@"%@ (%d)", NSStringFromSelector(_cmd), (int)state);
}

- (void)revealController:(PKRevealController *)revealController willChangeToState:(PKRevealControllerState)next
{
    PKRevealControllerState current = revealController.state;
    NSLog(@"%@ (%d -> %d)", NSStringFromSelector(_cmd), (int)current, (int)next);
}



#pragma mark - Helpers
- (UINavigationController *)frontNavigationController{
    
    UIViewController *frontViewController = [[UIViewController alloc] init];
    frontViewController.view.backgroundColor = [UIColor orangeColor];
    _frontViewController = frontViewController;
    frontViewController.title = @"侧滑控制器";
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    
    
    
    //设置leftBarButton
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    leftButton.frame = CGRectMake(0.,0.,50/2,50/2);
    [leftButton addTarget:self action:@selector(leftNavItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    frontViewController.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    //设置rightBarButton
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    rightButton.frame = CGRectMake(0.,0.,50/2,50/2);
    [rightButton addTarget:self action:@selector(rightNavItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    frontViewController.navigationItem.rightBarButtonItem = rightBarButton;
    
    //退出按钮
    UIButton *outBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    outBtn.center = frontViewController.view.center;
    [outBtn setTitle:@"退出侧滑菜单控制器" forState:UIControlStateNormal];
    [outBtn addTarget:self action:@selector(outBtnClick) forControlEvents:UIControlEventTouchUpInside];
    outBtn.backgroundColor = [UIColor blueColor];
    [frontViewController.view addSubview:outBtn];
    
    
    return frontNavigationController;
}

- (UIViewController *)leftViewController
{
    UIViewController *leftViewController = [[UIViewController alloc] init];
    leftViewController.view.backgroundColor = [UIColor yellowColor];
    _leftViewController = leftViewController;
    
    UIButton *presentationModeButton = [[UIButton alloc] initWithFrame:CGRectMake(20.0, 60.0, 180.0, 30.0)];
    [presentationModeButton setTitle:@"Presentation Mode" forState:UIControlStateNormal];
    [presentationModeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [presentationModeButton addTarget:self.revealController
                               action:@selector(startPresentationMode)
                     forControlEvents:UIControlEventTouchUpInside];
    
    [leftViewController.view addSubview:presentationModeButton];
    
    return leftViewController;
}

- (UIViewController *)rightViewController
{
    UIViewController *rightViewController = [[UIViewController alloc] init];
    rightViewController.view.backgroundColor = [UIColor redColor];
    _rightViewController = rightViewController;
    
    UIButton *presentationModeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds])-200.0, 60.0, 180.0, 30.0)];
    presentationModeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [presentationModeButton setTitle:@"Presentation Mode" forState:UIControlStateNormal];
    [presentationModeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [presentationModeButton addTarget:self.revealController
                               action:@selector(startPresentationMode)
                     forControlEvents:UIControlEventTouchUpInside];
    
    [rightViewController.view addSubview:presentationModeButton];
    
    return rightViewController;
}


#pragma mark - selector
- (void)startPresentationMode
{
    if (![self.revealController isPresentationModeActive])
    {
        [self.revealController enterPresentationModeAnimated:YES completion:nil];
    }
    else
    {
        [self.revealController resignPresentationModeEntirely:NO animated:YES completion:nil];
    }
}

- (void)leftNavItemClick{
    
    [self.revealController showViewController:_leftViewController];
}

- (void)rightNavItemClick{
    
    [self.revealController showViewController:_rightViewController];
}

- (void)outBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}







@end
