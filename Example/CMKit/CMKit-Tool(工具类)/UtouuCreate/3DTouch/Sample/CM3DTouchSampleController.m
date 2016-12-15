//
//  CM3DTouchSampleController.m
//  CMKit
//
//  Created by HC on 16/11/7.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CM3DTouchSampleController.h"
#import "CM3DTouchPreviewSampleController.h"
#import "CM3DTouchCommitSampleController.h"

@interface CM3DTouchSampleController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end

@implementation CM3DTouchSampleController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self check3DTouch];
}


#pragma mark - 初始化UI
- (void)initUI{
    self.view.backgroundColor = [UIColor orangeColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = @"请压力按压屏幕(真机)\n具体应用可参考'新浪新闻'App";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.frame = self.view.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}


#pragma mark - 3DTouch
- (void)check3DTouch {
    
    //检查3D Touch是否可用
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
        NSLog(@"3D Touch可用");
        
        // 不需要替代方案
        self.longPress.enabled = NO;
        
    } else {
        if (DEF_iOS9_LATER) {
            
            [[CMAlertView alloc] showAlertController:self title:@"3D Touch未开启" message:@"请在iPhone的\"设置>通用>辅助功能>3D Touch\"选项中,开启3D Touch功能." cancelTitle:@"确定" actionBlock:^(NSInteger buttonTag) {
                
            } otherButtonTitles:nil];
            
        }else{
            NSLog(@"3D Touch不可用");
            // 模拟3D Touch方案
            self.longPress.enabled = YES;
            
        }
        
    }
}


- (UILongPressGestureRecognizer *)longPress {
    
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showPeek)];
        [self.view addGestureRecognizer:_longPress];
    }
    return _longPress;
    /**************/
}



#pragma mark - 3D Touch代理
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    NSLog(@"previewingContext->%@",previewingContext);
    
    //检测是否已经展示了预览界面
    if ([self.presentedViewController isKindOfClass:[CM3DTouchPreviewSampleController class]]) {
        return nil;
    }
    
    // 内容预览控制器(peek)
    CM3DTouchPreviewSampleController *previewVc = [[CM3DTouchPreviewSampleController alloc] init];
    return previewVc;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    //继续深度按压：显示详情界面（pop）
    CM3DTouchCommitSampleController *commitVc = [[CM3DTouchCommitSampleController alloc] init];
    [self showViewController:commitVc sender:self];
}

#pragma mark - 3D Touch Alternative
- (void)showPeek {
    
    self.longPress.enabled = NO;
    
    // 展现内容预览控制器(peek)
    CM3DTouchPreviewSampleController *previewVc = [[CM3DTouchPreviewSampleController alloc] init];
    
    UIViewController *presenter = [self grabTopViewController];
    [presenter showViewController:previewVc sender:self];
    
}

- (UIViewController *)grabTopViewController {
    
    // helper method to always give the top most view controller
    // avoids "view is not in the window hierarchy" error
    // http://stackoverflow.com/questions/26022756/warning-attempt-to-present-on-whose-view-is-not-in-the-window-hierarchy-sw
    
    UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (top.presentedViewController) {
        top = top.presentedViewController;
    }
    
    return top;
}



#pragma mark - 设置环境改变回调
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    

    //当设置环境改变时回调，不管3D Touch开启与否，都再检查设置一次
    [self check3DTouch];
}




@end
