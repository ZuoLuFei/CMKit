//
//  CMPNChartViewController.m
//  CMKit
//
//  Created by yons on 17/3/10.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMPNChartViewController.h"
#import "CMChartViewController.h"

@interface CMPNChartViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *chartsArray;

@end

@implementation CMPNChartViewController

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
    self.chartsArray = @[
                         @{@"titleName":@"Line Chart"},
                         @{@"titleName":@"Bar Chart"},
                         @{@"titleName":@"Circle Chart"},
                         @{@"titleName":@"Pie Chart"},
                         @{@"titleName":@"Scatter Chart"},
                         @{@"titleName":@"Radar Chart"}
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
    
    return self.chartsArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMChartsTableViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.chartsArray[indexPath.row];
    cell.textLabel.text = dict[@"titleName"];
    
    return cell;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.chartsArray[indexPath.row];
    if (dict) {
        
        CMChartViewController *Vc = [[CMChartViewController alloc] init];
        Vc.title = dict[@"titleName"];
        [self.navigationController pushViewController:Vc animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
