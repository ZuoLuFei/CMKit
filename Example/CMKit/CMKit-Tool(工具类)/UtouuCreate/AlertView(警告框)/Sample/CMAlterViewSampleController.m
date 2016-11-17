//
//  CMAlterViewSampleController.m
//  CMKit
//
//  Created by HC on 16/10/31.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMAlterViewSampleController.h"

@interface CMAlterViewSampleController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *alterArray;

@end

@implementation CMAlterViewSampleController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化数据
    [self initData];
    
    //2.创建UI
    [self initUI];
}

#pragma mark - 初始化数据
- (void)initData{
    self.alterArray = @[@"Alert",@"ActionSheet"];
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
    return self.alterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"ToolViewControllerTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.alterArray[indexPath.row];
    
    
    return cell;
    
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [[CMAlertView sharedInstance] showAlertController:self title:@"提示" message:@"这是一个测试消息" cancelTitle:@"取消" actionBlock:^(NSInteger buttonTag) {
                switch (buttonTag) {
                    case 0:
                        //do something
                        break;
                        
                    default:
                        break;
                }
            } otherButtonTitles:@"确定",@"不确定", @"很不确定",nil];
            
            break;
        case 1:
            [[CMAlertView sharedInstance] showActionSheetController:self title:@"提示" message:@"这是一个测试消息" cancelTitle:@"取消" destructive:@"滚犊子" actionBlock:^(NSInteger buttonTag) {
                switch (buttonTag) {
                    case 0:
                        //do something
                        break;
                        
                    default:
                        break;
                }
            } otherButtonTitles:@"确定",@"不怎么确定",@"不确定", nil];
            
            break;
            
        default:
            break;
    }
    
    
}


@end
