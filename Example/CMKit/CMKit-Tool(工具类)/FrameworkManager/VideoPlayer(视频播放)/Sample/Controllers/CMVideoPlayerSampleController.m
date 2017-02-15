//
//  CMVideoPlayerSampleController.m
//  CMKit
//
//  Created by HC on 17/2/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMVideoPlayerSampleController.h"
#import "CMVideoListController.h"
#import "CMMoviePlayerTableTableViewController.h"


@interface CMVideoPlayerSampleController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;

@end

@implementation CMVideoPlayerSampleController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化数据
    [self initData];
    
    
    //2.创建UI
    [self initUI];
}

#pragma mark - 初始化数据
- (void)initData{
    self.array = @[
                         @{@"titleName":@"单独视频列表",@"classType":[CMVideoListController class]},
                         @{@"titleName":@"集合视频列表",@"classType":[CMMoviePlayerTableTableViewController class]},
                         @{@"titleName":@"视频下载管理",@"classType":@""}
                         ];
    
}

#pragma mark - 初始化UI
//创建UI
- (void)initUI{
    
    //1.创建TableView
    UITableView *tableView = [UITableView initWithFrame:self.view.bounds style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];
    
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMVideoPlayerSampleController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.array[indexPath.row];
    cell.textLabel.text = dict[@"titleName"];
    
    return cell;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict = self.array[indexPath.row];
    if (dict) {
        
        if ([dict[@"classType"] isEqual:[MBProgressHUD class]]) {
            [MBProgressHUD showSuccess:@"this is a test"];
            
        }else if([dict[@"classType"] isEqual:@""]){
            [MBProgressHUD showError:@"功能暂未完善"];
            
        }else{
            UIViewController *Vc = [[dict[@"classType"] alloc] init];
            Vc.title = dict[@"titleName"];
            [self.navigationController pushViewController:Vc animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
