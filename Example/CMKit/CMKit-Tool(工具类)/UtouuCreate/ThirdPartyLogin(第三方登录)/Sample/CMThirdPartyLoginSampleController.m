//
//  CMThirdPartyLoginSampleController.m
//  CMKit
//
//  Created by HC on 16/11/2.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMThirdPartyLoginSampleController.h"
#import "CMSinaLoginController.h"

@interface CMThirdPartyLoginSampleController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *thirdPartyLoginArray;

@end

@implementation CMThirdPartyLoginSampleController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化数据
    [self initData];
    
    //1.创建UI
    [self initUI];
}

#pragma mark - 初始化数据
- (void)initData{
    self.thirdPartyLoginArray = @[@{@"name":@"微博登录",@"classType":[CMSinaLoginController class]},
                                  @{@"name":@"QQ登录",@"classType":@""},
                                  @{@"name":@"微信登录",@"classType":@""}];
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
    return self.thirdPartyLoginArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMThirdPartyLoginSampleController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.thirdPartyLoginArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    
    return cell;
    
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.thirdPartyLoginArray[indexPath.row];
    if (dict) {
        
        if([dict[@"classType"] isEqual:@""]){
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
