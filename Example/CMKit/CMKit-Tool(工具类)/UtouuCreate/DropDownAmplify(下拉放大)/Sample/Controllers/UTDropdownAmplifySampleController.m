//
//  UTDropdownAmplifySampleController.m
//  CMKit
//
//  Created by HC on 17/1/10.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "UTDropdownAmplifySampleController.h"
#import "CMDropdownAmplifyView.h"

@interface UTDropdownAmplifySampleController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UTDropdownAmplifySampleController

#pragma mark - 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configUI];
    
    
    
}

#pragma mark - 初始化UI
- (void)configUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //拉伸View
    UIImageView *stretchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9.jpg"]];
    CGFloat stretchViewX = 0;
    CGFloat stretchViewY = 0;
    CGFloat stretchViewW = self.view.frame.size.width;
    CGFloat stretchViewH = 200;
    stretchView.frame = CGRectMake(stretchViewX, stretchViewY, stretchViewW, stretchViewH);
    
    //内容View
    UIImageView *contentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6.jpeg"]];
    CGFloat contentViewY = 50;
    CGFloat contentViewX = 50;
    CGFloat contentViewH = 100;
    CGFloat contentViewW = stretchViewW - contentViewX * 2;
    contentView.frame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
    
    //初始化方法一
    CMDropdownAmplifyView *transparentView = [CMDropdownAmplifyView dropHeaderViewWithFrame:stretchView.frame contentView:contentView stretchView:stretchView];
    /**
     //初始化方法二
     CMDropdownAmplifyView *transparentView = [CMDropdownAmplifyView dropHeaderViewWithFrame:stretchView.frame];
     transparentView.stretchView = stretchView;
     transparentView.contentView = contentView;
     */
    
    self.tableView.tableHeaderView = transparentView;
    
    [self.view addSubview:self.tableView];

}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"UTDropdownAmplifySampleController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试测试测试测试 %ld",indexPath.row];
    return cell;
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
