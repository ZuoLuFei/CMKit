//
//  CMDetailedFunctionController.m
//  CMKit
//
//  Created by HC on 16/11/1.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMDetailedFunctionController.h"

@interface CMDetailedFunctionController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CMDetailedFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建UI
    [self initUI];
}

#pragma mark - 初始化UI
//创建UI
- (void)initUI{
    
    self.title = self.vcTitle;
    
    //1.创建TableView
    UITableView *tableView = [UITableView initWithFrame:self.view.bounds style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.functionArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMDetailedFunctionController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSString *functionStr = self.functionArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.  %@",(long)indexPath.row+1,functionStr];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [MBProgressHUD showSuccess:@"请移步源码对应的分类"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;

}

@end
