//
//  CMCityListSampleController.m
//  CMKit
//
//  Created by HC on 16/11/21.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMCityListSampleController.h"
#import "CityListViewController.h"
#import "CMThreeLevelCityPickerView.h"

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
    [[CMAlertView sharedInstance] showAlertController:self title:@"提示" message:@"选择城市列表类型" cancelTitle:@"取消" actionBlock:^(NSInteger buttonTag) {
        switch (buttonTag) {
            case 0: // 默认取消按钮
                break;
                
            case 1: // 城市三级列表
                [self threeLevelCityList];
                
                break;
                
            case 2: // 城市首字母列表
                [self firstLetterCityList];
                break;
                
            default:
                break;
        }
    } otherButtonTitles:@"城市三级列表",@"城市首字母列表",nil];
}

// 城市三级列表
- (void)threeLevelCityList {
    CMThreeLevelCityPickerView *threeLevelCityView = [[CMThreeLevelCityPickerView alloc] init];
    threeLevelCityView.toolBarTitle = @"哈哈";
    
    __weak typeof(self)blockself = self;
    [threeLevelCityView showCityPickerView:^(NSString *proviceStr, NSString *cityStr, NSString *distr) {
        [blockself.cityBtn setTitle:[NSString stringWithFormat:@"%@->%@->%@",proviceStr,cityStr,distr] forState:UIControlStateNormal];
        [blockself.cityBtn sizeToFit];
        blockself.cityBtn.center = self.view.center;
        
    }];

}

// 城市首字母列表
- (void)firstLetterCityList {
    
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
    [_cityBtn sizeToFit];
    _cityBtn.center = self.view.center;
}


@end
