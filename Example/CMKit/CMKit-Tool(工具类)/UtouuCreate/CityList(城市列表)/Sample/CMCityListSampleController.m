//
//  CMCityListSampleController.m
//  CMKit
//
//  Created by HC on 16/11/21.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMCityListSampleController.h"
#import "CityListViewController.h"

@interface CMCityListSampleController ()<CityListViewDelegate>
@property (nonatomic, strong) UIButton *cityBtn;

@end

@implementation CMCityListSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.
    [self initUI];
}

#pragma mark - 初始化UI
- (void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2.
    UIButton *cityBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    _cityBtn = cityBtn;
    cityBtn.center = self.view.center;
    [cityBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor blueColor]];
    [cityBtn addTarget:self action:@selector(cityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cityBtn];
    
}

#pragma mark - selector
- (void)cityBtnClick:(NSString *)cityName
{
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",@"北京",@"天津",@"厦门",@"重庆",@"福州",@"泉州",@"济南",@"深圳",@"长沙",@"无锡", nil];
    //历史选择城市列表
    cityListView.arrayHistoricalCity = [NSMutableArray arrayWithObjects:@"福州",@"厦门",@"泉州", nil];
    //定位城市列表
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:@"福州", nil];
    
    [self presentViewController:cityListView animated:YES completion:nil];
}

#pragma mark - CityListViewDelegate
- (void)didClickedWithCityName:(NSString *)cityName
{
    [_cityBtn setTitle:cityName forState:UIControlStateNormal];
}


@end
