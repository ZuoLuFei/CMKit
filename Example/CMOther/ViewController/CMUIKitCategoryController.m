//
//  CMUIKitCategoryController.m
//  CMKit
//
//  Created by HC on 16/11/1.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMUIKitCategoryController.h"
#import "CMDetailedFunctionController.h"
#import "CMHeadView.h"

@interface CMUIKitCategoryController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *uiKitArray;

@end

@implementation CMUIKitCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化数据
    [self initData];
    
    //2.创建UI
    [self initUI];
}

#pragma mark - 初始化数据
- (void)initData{
    self.uiKitArray = @[@{@"name":@"UIButton+CMKit",@"classFunction":@[@"创建一个指定frame的UIButton",
                                                                       @"创建一个指定frame且有title的UIButton",
                                                                       @"创建一个指定frame且有title、常规背景图片的UIButton",
                                                                       @"创建一个指定frame且有title、常规背景图片、高亮背景图片的UIButton",
                                                                       @"创建一个指定frame且有title、常规背景色的UIButton",
                                                                       @"创建一个指定frame且有title、常规背景色、高亮背景色的UIButton",
                                                                       @"创建一个指定frame且有常规背景色的UIButton",
                                                                       @"创建一个指定frame且有常规色、高亮背景色的UIButton",
                                                                       @"创建一个指定frame且有常规图片的UIBUtton",
                                                                       @"创建一个指定frame且有常规图片、高亮图片的UIBUtton",
                                                                       @"设置Button的title的常规颜色",
                                                                       @"设置Button的title的常规颜色和高亮颜色"]},
                        @{@"name":@"UIColor+CMKit",@"classFunction":@[@"根据指定的HEX字符串创建一种颜色",
                                                                      @"根据指定的HEX创建一个颜色",
                                                                      @"根据指定HEX和alpha值创建一种颜色",
                                                                      @"根据指定的String创建一种颜色(如'blue'或'ff00ff')",
                                                                      @"随机创建一种颜色",
                                                                      @"创建并且返回一种具有与给出颜色相同space和component值，但是具有特殊alpha值的颜色"]},
                        @{@"name":@"UIDevice+CMKit",@"classFunction":@[@"返回设备平台字符串 如:iPhone7,2 ",
                                                                       @"返回可读的设备平台字符串 如:iPad Air (Cellular)",
                                                                       @"检查当前设备是否是iPad",
                                                                       @"检查当前设备是否是iPhone",
                                                                       @"检查当前设备是否是iPod",
                                                                       @"检查当前设备是否是Apple TV",
                                                                       @"检查当前设备是否是Apple Watch",
                                                                       @"检查当前设备是否是模拟器",
                                                                       @"返回当前iOS版本号(不包含子版本号) 如:7",
                                                                       @"返回当前设备CPU频率",
                                                                       @"返回当前设备BUS频率",
                                                                       @"返回当前设备RAM大小",
                                                                       @"返回当前设备CPU数量",
                                                                       @"返回当前设备总内存",
                                                                       @"返回当前设备内核内存",
                                                                       @"返回当前设备总沙盒空间",
                                                                       @"返回当前设备可用沙盒空间"]},
                        @{@"name":@"UIImage+CMKit",@"classFunction":@[@"画带边框圆图",
                                                                      @"给图片增加圆角",
                                                                      @"给图片增加圆角及边框",
                                                                      @"根据image本身创建指定rect的image",
                                                                      @"创建指定color的image",
                                                                      @"将图片剪裁至目标尺寸(将图片直接重绘入目标尺寸画布，原长/宽比例为目标尺寸长/宽比例)",
                                                                      @"将图片剪裁至目标尺寸(将图片按比例压缩后重绘入目标尺寸画布，并裁剪掉多余部分，原长/宽比例不变)",
                                                                      @"内切处理图片",
                                                                      @"按比例拉伸/缩放图片",
                                                                      @"按目标尺寸以最大边缩小图片",
                                                                      @"根据指定radians旋转image",
                                                                      @"根据指定degrees旋转image",
                                                                      @"设置图片alpha",
                                                                      @"检查image是否有alpha属性",
                                                                      @"移除image的alpha属性",
                                                                      @"使用白色填充alpha属性",
                                                                      @"使用指定color填充alpha属性",
                                                                      @"纯色图重绘颜色",
                                                                      @"渐变色图重绘颜色",
                                                                      @"水平翻转image",
                                                                      @"垂直翻转image",
                                                                      @"垂直并水平翻转image",
                                                                      @"图片light效果",
                                                                      @"图片light+效果",
                                                                      @"图片dark效果",
                                                                      @"图片模糊效果"]},
                        @{@"name":@"UIImageView+CMKit",@"classFunction":@[@"根据指定image和frame创建一个UIImageView",
                                                                          @"根据指定image、frame、center创建一个UIImageView",
                                                                          @"根据指定image、center创建一个UIImageView",
                                                                          @"根据指定tintColor、image创建一个模板UIImageView",
                                                                          @"创建一个有阴影效果",
                                                                          @"减掉超出UIImage Bounds范围的部分"]},
                        @{@"name":@"UILabel+CMKit",@"classFunction":@[@"基于Label的text、width、font计算其height",
                                                                      @"在指定的索引范围内设置一个自定义的字体font"]},
                        @{@"name":@"UINavigationBar+CMKit",@"classFunction":@[@"设置UINavigationBar是否透明",
                                                                              @"设置UINavigationBar是否透明、半透明"]},
                        @{@"name":@"UIScreen+CMKit",@"classFunction":@[@"检查当前设备是否是视网膜显示屏",
                                                                       @"检查当前设备是否是视网膜高清显示屏",
                                                                       @"获取当前设备的亮度",
                                                                       @"设置当前设备的亮度"]},
                        @{@"name":@"UIScrollView+CMKit",@"classFunction":@[@"快速创建一个UIScrollView并且设置一些属性"]},
                        @{@"name":@"UITableView+CMKit",@"classFunction":@[@"快速创建一个UITableView并且设置一些属性",
                                                                          @"获取指定组的所有索引路径",
                                                                          @"在指定组中获取指定行的下一个索引路径",
                                                                          @"在指定组中获取指定行的上一个索引路径"]},
                        @{@"name":@"UITextField+CMKit",@"classFunction":@[@"设置UITextField左边距",
                                                                        @"设置UITextField 右侧清除按钮图片",
                                                                        @"设置UITextField Placeholder颜色",
                                                                        @"设置全局共用UITextField对象的指定格式"]},
                        @{@"name":@"UIToolBar+CMKit",@"classFunction":@[@"设置UIToolbar是否透明"]},
                        @{@"name":@"UIView+CMKit",@"classFunction":@[@"创建一个指定frame和背景色的UIView",
                                                                     @"设置当前view的边界周边",
                                                                     @"移除当前view的边界周边",
                                                                     @"设置当前view的阴影",
                                                                     @"设置当前view的拐角阴影",
                                                                     @"移除当前view的阴影",
                                                                     @"设置当前view的拐角半径",
                                                                     @"为当前view创建震动动画效果",
                                                                     @"为当前view创建脉冲动画效果",
                                                                     @"为当前view创建心跳动画效果",
                                                                     @"为当前view增加运行效果",
                                                                     @"获取当前view的屏幕截图",
                                                                     @"获取当前view的屏幕截图并保存到照片专辑中",
                                                                     @"从当前view移除所有的子视图"]},
                        @{@"name":@"UIView+Layout",@"classFunction":@[@"获取视图的绝对坐标，如x,y,width,height,top,bottom,left,right等",@"获取视图的相对坐标，如middleX,middleY,middlePoint等"]},
                        @{@"name":@"UIViewController+CMKit",@"classFunction":@[@"使用方法调配替换系统的viewDidLoad方法，在viewDidLoad中打印当前控制器"]},
                        @{@"name":@"UIWebView+CMKit",@"classFunction":@[@"移除当前UIWebView的背景阴影",
                                                                        @"加载网址"]},
                        @{@"name":@"UIWindow+CMKit",@"classFunction":@[@"获取当前window的屏幕截图，不保存至照片专辑中",
                                                                       @"获取当前window的屏幕截图，并选择是否保存至照片专辑中",
                                                                       @"获取当前window的屏幕截图，并选择是否保存至照片专辑中且延时多久保存"]}];
    
}

#pragma mark - 初始化UI
//创建UI
- (void)initUI{
    
    //1.创建TableView
    UITableView *tableView = [UITableView initWithFrame:self.view.bounds style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];
    
//    [tableView registerClass:[CMHeadView class] forHeaderFooterViewReuseIdentifier:@"CMHeadView"];
    
    tableView.tableHeaderView = [CMHeadView headView];
    
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.uiKitArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMUIKitCategoryController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.uiKitArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    CMHeadView *headView = [[CMHeadView alloc] initWithReuseIdentifier:@"CMHeadView"];
    headView.titleStr = @"UIKit 框架分类";
    
    return headView;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.uiKitArray[indexPath.row];
    if (dict) {
        
        CMDetailedFunctionController *Vc = [[CMDetailedFunctionController alloc] init];
        Vc.functionArray = dict[@"classFunction"];
        Vc.vcTitle = dict[@"name"];
        Vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Vc animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}


@end
