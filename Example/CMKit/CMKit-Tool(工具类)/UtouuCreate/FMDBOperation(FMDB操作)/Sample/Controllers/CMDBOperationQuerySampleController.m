//
//  CMDBOperationQuerySampleController.m
//  CMKit
//
//  Created by HC on 16/11/23.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMDBOperationQuerySampleController.h"
#import "CMDBUserModel.h"
#import "CMDBOperationQueryCell.h"

@interface CMDBOperationQuerySampleController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSMutableArray *dbOperationData;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CMDBOperationQuerySampleController

#pragma mark - 懒加载
- (NSMutableArray *)dbOperationData{
    
    if (!_dbOperationData) {
        _dbOperationData = [NSMutableArray array];
    }
    
    return _dbOperationData;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    //2.初始化界面
    [self initUI];
}


#pragma mark - 初始化UI
- (void)initUI{
    
    //1.创建TableView
    UITableView *tableView = [UITableView initWithFrame:self.view.bounds style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    tableView.tableFooterView = [UIView new];
    if (_type == 4) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        [button setTitle:@"点击加载更多" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
        tableView.tableFooterView = button;
    }
    
    //2.初始化数据
    [self initData];
    
}

#pragma mark - 初始化数据
- (void)initData{
    switch (_type) {
        case 1:
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"第一条");
                CMDBUserModel *user = [CMDBUserModel findFirstWithFormat:@" WHERE %@ = %d ",@"age",10];
                if (!user)  return;
                [self.dbOperationData addObject:user];
                [self.tableView reloadData];
            });
            break;
        }
        case 2:
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"小于20岁");
                //                [self.data addObjectsFromArray:[User findByCriteria:@" WHERE age < 20 "]];
                [self.dbOperationData addObjectsFromArray:[CMDBUserModel findWithFormat:@" WHERE %@ < %d",@"age",20]];
                [self.tableView reloadData];
            });
            break;
        }
        case 3:
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"全部");
                [self.dbOperationData addObjectsFromArray:[CMDBUserModel findAll]];
                [self.tableView reloadData];
            });
            break;
        }
        case 4:
        {
            [self loadMore];
        }
            break;
            
        default:
            break;
    }
}


- (void)loadMore
{
    static int pk = 5;
    NSArray *array = [CMDBUserModel findByCriteria:[NSString stringWithFormat:@" WHERE pk > %d limit 10",pk]];
    pk = ((CMDBUserModel *)[array lastObject]).pk;
    [self.dbOperationData addObjectsFromArray:array];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dbOperationData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CMDBOperationQueryCell *cell = [CMDBOperationQueryCell createTableViewCellWith:tableView];
    cell.userModel = self.dbOperationData[indexPath.row];

    return cell;
    
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}





@end
