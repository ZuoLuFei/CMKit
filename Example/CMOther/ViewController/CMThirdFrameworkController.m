//
//  CMThirdFrameworkController.m
//  CMKit
//
//  Created by HC on 16/11/17.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMThirdFrameworkController.h"
#import "CMCyclePictureSampleController.h"
#import "MJExampleViewController.h"
#import "MasterViewController.h"
#import "GlobalTimelineViewController.h"
#import "CMAlbumImagesSampleController.h"
#import "CMWaterfallLayoutController.h"
#import "CMRevealSampleController.h"
#import "CMCropPictureSampleController.h"
#import "CMQRCodeSampleController.h"

#import "CMHeadView.h"


#define SourceCode @"SourceCode"

@interface CMThirdFrameworkController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *toolArray;

@end

@implementation CMThirdFrameworkController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化数据
    [self initData];
    
    
    //2.创建UI
    [self initUI];
}

#pragma mark - 初始化数据
- (void)initData{
    self.toolArray = @[
                       @{@"name":@"NetWork(网络请求)",@"classType":[GlobalTimelineViewController class]},
                       @{@"name":@"ImageCache(图片缓存)",@"classType":[MasterViewController class]},
                       
                       @{@"name":@"ImageMultipleChoice(图片多选器)",@"classType":[CMAlbumImagesSampleController class]},
                       @{@"name":@"QRCode(二维码/条形码)",@"classType":[CMQRCodeSampleController class]},
                       @{@"name":@"Refresh(上拉/下拉刷新)",@"classType":[MJExampleViewController class]},
                       @{@"name":@"CyclePicture(无限轮播)",@"classType":[CMCyclePictureSampleController class]},
                       @{@"name":@"VerticalWaterFlow(垂直瀑布流)",@"classType":[CMWaterfallLayoutController class]},
                       @{@"name":@"RevealContorller(侧滑菜单控制器)",@"classType":[CMRevealSampleController class]},
                       @{@"name":@"CropPicture(裁剪图片)",@"classType":[CMCropPictureSampleController class]}
                   ];
    
}

#pragma mark - 初始化UI
//创建UI
- (void)initUI{
    
    //1.创建TableView
    UITableView *tableView = [UITableView initWithFrame:self.view.bounds style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];
    
    [tableView registerClass:[CMHeadView class] forHeaderFooterViewReuseIdentifier:@"CMHeadView"];
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.toolArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMThirdFrameworkController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.toolArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    CMHeadView *headView = [[CMHeadView alloc] initWithReuseIdentifier:@"CMHeadView"];
    headView.titleStr = @"常用第三方框架选型";
    
    return headView;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.toolArray[indexPath.row];
    if (dict) {
        
        if ([dict[@"classType"] isEqual:[MBProgressHUD class]]) {
            [MBProgressHUD showSuccess:@"this is a test"];
            
        }else if([dict[@"classType"] isEqual:@""]){
            [MBProgressHUD showError:@"功能暂未完善"];
            
        }else if([dict[@"classType"] isEqual:SourceCode]){
            [MBProgressHUD showSuccess:@"请移步源码对应的类"];
            
        }else if ([dict[@"classType"] isEqual:[CMRevealSampleController class]]){
            CMRevealSampleController *Vc = [[CMRevealSampleController alloc] init];
            [self presentViewController:Vc animated:YES completion:nil];
        }else{
            UIViewController *Vc = [[dict[@"classType"] alloc] init];
            Vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Vc animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}


@end
