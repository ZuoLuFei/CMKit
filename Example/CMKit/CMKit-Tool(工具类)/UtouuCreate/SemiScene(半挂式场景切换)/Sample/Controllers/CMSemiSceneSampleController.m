//
//  CMSemiSceneSampleController.m
//  CMKit
//
//  Created by HC on 17/1/9.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMSemiSceneSampleController.h"
#import "KNFirstViewController.h"
#import "KNSecondViewController.h"
#import "KNTableDemoController.h"


@interface CMSemiSceneSampleController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *toolArray;

@end

@implementation CMSemiSceneSampleController


#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initUI];
    
}

#pragma mark - 初始化数据
- (void)initData{
    self.toolArray = @[@{@"name":@"Demo1",@"classType":[KNFirstViewController class]},
                       @{@"name":@"Demo2",@"classType":[KNSecondViewController class]},
                       @{@"name":@"Demo3",@"classType":[KNTableDemoController class]}];
    
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
    
    return self.toolArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMSemiSceneSampleController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.toolArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    return cell;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.toolArray[indexPath.row];
    if (dict) {
        
        if ([dict[@"classType"] isEqual:[KNSecondViewController class]]) {
            UIViewController *Vc = [[dict[@"classType"] alloc] init];
            Vc.hidesBottomBarWhenPushed = YES;
            [self presentViewController:Vc animated:YES completion:nil];
            
        }else if([dict[@"classType"] isEqual:@""]){
            [MBProgressHUD showError:@"功能暂未完善"];
            
        }else{
            UIViewController *Vc = [[dict[@"classType"] alloc] init];
            Vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Vc animated:YES];
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
