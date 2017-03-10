//
//  CMJHChartViewController.m
//  CMKit
//
//  Created by yons on 17/3/10.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMJHChartViewController.h"
#import "CMJHChartShowController.h"

@interface CMJHChartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray * itemsArr;
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation CMJHChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _itemsArr = @[@"折线图-第一象限",@"折线图-第一二象限",@"折线图第一四象限",@"折线图-全象限",@"饼图",@"环状图",@"柱状图",@"表格",@"雷达图",@"散点图"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate  =self;
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _itemsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    cell.textLabel.text = _itemsArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CMJHChartShowController *show = [CMJHChartShowController new];
    
    show.index = indexPath.row;
    
    [self.navigationController pushViewController:show animated:YES];
    
    
    
}

@end
