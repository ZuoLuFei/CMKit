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
#import "CMScratchAnimationSampleController.h"

@interface CMAnimationSampleController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *animationEffectArray;

@end

@implementation CMAnimationSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化数据
    [self initData];
    
    
    //2.创建UI
    [self initUI];
}

#pragma mark - 初始化数据
- (void)initData{
    self.animationEffectArray = @[@{@"name":@"BasicAnimation(基础/关键帧动画)",@"classType":[CMBaseAnimationSampleController class]},
                                  @{@"name":@"TransitionAnimation(转场动画)",@"classType":[CMTransitionAnimationSampleController class]},
                                  @{@"name":@"ScratchAnimation(刮奖动画)",@"classType":[CMScratchAnimationSampleController class]},];
    
    
}

#pragma mark - 初始化UI
//创建UI
- (void)initUI{
    
    //1.创建TableView
    UITableView *tableView = [UITableView initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];
    
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.animationEffectArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMAnimationSampleController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.animationEffectArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    return cell;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.animationEffectArray[indexPath.row];

    UIViewController *Vc = [[dict[@"classType"] alloc] init];
    Vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
