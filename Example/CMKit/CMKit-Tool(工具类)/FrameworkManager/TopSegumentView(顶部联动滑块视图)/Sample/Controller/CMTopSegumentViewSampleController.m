//
//  CMTopSegumentViewSampleController.m
//  CMKit
//
//  Created by HC on 17/3/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMTopSegumentViewSampleController.h"
#import "ZJVc1Controller.h"
#import "ZJVc2Controller.h"
#import "ZJVc3Controller.h"
#import "ZJVc4Controller.h"
#import "ZJVc5Controller.h"
#import "ZJVc6Controller.h"
#import "ZJVc7Controller.h"
#import "ZJVc8Controller.h"
#import "ZJVc9Controller.h"
#import "ZJVc10Controller.h"

@interface CMTopSegumentViewSampleController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *segumentArray;

@end

@implementation CMTopSegumentViewSampleController


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initUI];
    
    
}

#pragma mark - 初始化数据
- (void)initData {
    self.segumentArray = @[
                       @{@"name":@"缩放+颜色渐变 效果",@"classType":[ZJVc1Controller class]},
                       @{@"name":@"遮盖+颜色渐变 效果",@"classType":[ZJVc2Controller class]},
                       @{@"name":@"滚动条+颜色渐变 效果",@"classType":[ZJVc3Controller class]},
                       @{@"name":@"遮盖+缩放+没有颜色渐变 效果",@"classType":[ZJVc4Controller class]},
                       @{@"name":@"标题不滚动+遮盖+颜色渐变 效果",@"classType":[ZJVc5Controller class]},
                       @{@"name":@"自定义segmentView和contentView位置的效果)",@"classType":[ZJVc6Controller class]},
                       @{@"name":@"动态更改显示内容和标题 效果",@"classType":[ZJVc7Controller class]},
                       @{@"name":@"更改选中的下标的效果",@"classType":[ZJVc8Controller class]},
                       @{@"name":@"微博&简书个人主页效果",@"classType":[ZJVc9Controller class]},
                       @{@"name":@"显示图片的效果",@"classType":[ZJVc10Controller class]},
                       
                       ];

}

#pragma mark - 初始化UI
- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 说明Label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    label.text = @"标题不滚动的时候不要使用(缩放+遮盖)或(缩放+滚动条),其他效果之间可以组合!!,您可以大胆的去组合一下试试";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:17.0f];
    CGFloat labelX = 10;
    CGFloat labelY = 10 + 64;
    CGFloat labelW = DEF_SCREEN_WIDTH - labelX*2;
    CGFloat labelH = [label.text heightForWidth:labelW andFont:label.font];
    label.frame = CGRectMake(labelX, labelY , labelW, labelH);
    [self.view addSubview:label];
    
    // TableView
    CGFloat tableViewX = 0;
    CGFloat tableViewY = CGRectGetMaxY(label.frame)+10;
    CGFloat tableViewW = DEF_SCREEN_WIDTH;
    CGFloat tableViewH = DEF_SCREEN_HEIGHT - tableViewY;
    UITableView *tableView = [UITableView initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];

    [self.view addSubview:tableView];
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.segumentArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMThirdFrameworkController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.segumentArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.segumentArray[indexPath.row];
    if (dict) {
        
        if ([dict[@"classType"] isEqual:[MBProgressHUD class]]) {
            [MBProgressHUD showSuccess:@"this is a test"];
            
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
