//
//  CMThreeLevelCityPickerView.m
//  CMKit
//
//  Created by 黄超 on 2017/4/20.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMThreeLevelCityPickerView.h"

#define DEF_RGB_COLOR(_red, _green, _blue) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:1]

#define buttonW 60
#define toolH 40
#define contentViewH 260

@interface CMThreeLevelCityPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>


/** 城市信息Block */
@property(nonatomic) CityMessage cityMessage;

/** 一个view，工具栏和pickview都是添加到上面，便于管理 */
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIPickerView *pickView;

/** 左边按钮 */
@property (nonatomic, strong) UIButton *leftBtn;

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

/** 右边按钮 */
@property (nonatomic, strong) UIButton *rightBtn;

/** 所有地址数据 */
@property (nonatomic, strong) NSArray *addressArray;

/** 省份数组 */
@property (nonatomic, strong) NSMutableArray *provinceAry;

/** 城市数组 */
@property (nonatomic, strong) NSMutableArray *cityAry;

/** 区、县数组 */
@property (nonatomic, strong) NSMutableArray *districtAry;

/** 记录选中哪个省的索引 */
@property (nonatomic, assign) NSInteger proIndex;

/** 记录选中哪个市的索引 */
@property (nonatomic, assign) NSInteger cityIndex;

/** 记录选中哪个区的索引 */
@property (nonatomic, assign) NSInteger districtIndex;

@end

@implementation CMThreeLevelCityPickerView

#pragma mark - 数据源设置
- (void)setToolBarTitle:(NSString *)toolBarTitle {
    _toolBarTitle = toolBarTitle;
    self.titleLabel.text = toolBarTitle;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configData];
        
        [self configUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configData];
        
        [self configUI];
    }
    return self;
}

#pragma mark - 初始化数据
- (void)configData {
    _proIndex = 0;
    _provinceAry = [[NSMutableArray alloc] init];
    _cityAry = [[NSMutableArray alloc] init];
    _districtAry = [[NSMutableArray alloc] init];
    
    _addressArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CMThreeLevelCityList.bundle/Address" ofType:@"plist"]];
    
    for (NSDictionary *obj in _addressArray) {
        [_provinceAry addObject:[[obj allKeys] firstObject]];
        
    }
    
    if (!_provinceAry.count) {
        NSLog(@"加载Address.plist失败");
    }
    
    [_addressArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj objectForKey:_provinceAry[_proIndex]]) {
            _cityAry = [NSMutableArray arrayWithArray:[[obj objectForKey:_provinceAry[_proIndex]] allKeys]];
            
            NSLog(@"%@",[[obj objectForKey:_provinceAry[_proIndex]] objectForKey:_cityAry[0]]);
            
            _districtAry = [NSMutableArray arrayWithArray:[[obj objectForKey:_provinceAry[_proIndex]] objectForKey:_cityAry[0]]];
            
            *stop = YES;
        }
    }];
    
}

#pragma mark - 初始化UI
- (void)configUI {
    
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    // 装载工具栏和pickview的View
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, contentViewH)];
    [self addSubview:_contentView];
    
    UIView *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, toolH)];
    tool.backgroundColor = DEF_RGB_COLOR(237, 236, 234);
    [_contentView addSubview:tool];
    
    // 取消、确定按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.leftBtn = leftBtn;
    leftBtn.frame = CGRectMake(0, 0, buttonW, toolH);
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tool addSubview:leftBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftBtn.frame.size.width, 0, self.frame.size.width-(leftBtn.frame.size.width*2), toolH)];
    self.titleLabel = titleLabel;
    titleLabel.text = @"选择地区";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [tool addSubview:titleLabel];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.rightBtn = rightBtn;
    rightBtn.frame = CGRectMake(self.frame.size.width-buttonW ,0,buttonW, toolH);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tool addSubview:rightBtn];
    
    
    _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,toolH, self.frame.size.width, self.contentView.frame.size.height-toolH)];
    _pickView.delegate = self;
    _pickView.dataSource = self;
    _pickView.backgroundColor = DEF_RGB_COLOR(237, 237, 237);
    [_contentView addSubview:_pickView];
    
    
}

#pragma mark - 暴露方法
-(void)showCityPickerView:(CityMessage) cityMessage {
    
    if (!self.cityMessage) {
        self.cityMessage = cityMessage;
    }
    
    
    // 设置背景色
    self.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
    
    //
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    __weak typeof(UIView*)blockview = _contentView;
    __block int blockH = self.frame.size.height;
    __block int bjH = contentViewH;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect bjf = blockview.frame;
        bjf.origin.y = blockH-bjH;
        blockview.frame = bjf;
    }];
}

#pragma mark - 按钮事件
// 左边按钮事件
- (void)leftButtonClick:(id)sender {
    __weak typeof(UIView*)blockview = self.contentView;
    __weak typeof(self)blockself = self;
    __block int blockH = self.frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect bjf = blockview.frame;
        bjf.origin.y = blockH;
        blockview.frame = bjf;
        blockself.alpha = 0.1;
    } completion:^(BOOL finished) {
        [blockself removeFromSuperview];
    }];
}

- (void)rightButtonClick:(id)sender {
    
    if (self.cityMessage) {
        self.cityMessage(_provinceAry[_proIndex] , _cityAry[_cityIndex] , _districtAry[_districtIndex]);
    }
    
    __weak typeof(UIView*)blockview = _contentView;
    __weak typeof(self)blockself = self;
    __block int blockH = self.frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect bjf = blockview.frame;
        bjf.origin.y = blockH;
        blockview.frame = bjf;
        blockself.alpha = 0.1;
    } completion:^(BOOL finished) {
        [blockself removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return _provinceAry.count;
    }else if (component == 1){
        return _cityAry.count;
    }else if (component == 2){
        return _districtAry.count;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
  
    UILabel* pickerLabel = [[UILabel alloc] init];
    pickerLabel.numberOfLines = 0;
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    if (component == 0) {
        pickerLabel.text = [_provinceAry objectAtIndex:row];
    }else if (component == 1){
        pickerLabel.text = [_cityAry objectAtIndex:row];
    }else if (component == 2){
        pickerLabel.text = [_districtAry objectAtIndex:row];
    }
    
    return pickerLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        _proIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        
        [_addressArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj objectForKey:_provinceAry[_proIndex]]) {
                _cityAry = [NSMutableArray arrayWithArray:[[obj objectForKey:_provinceAry[_proIndex]] allKeys]];
                
                [_pickView reloadComponent:1];
                [_pickView selectRow:0 inComponent:1 animated:YES];
                
                _districtAry = [NSMutableArray arrayWithArray:[[obj objectForKey:_provinceAry[_proIndex]] objectForKey:_cityAry[0]]];
                [_pickView reloadComponent:2];
                [_pickView selectRow:0 inComponent:2 animated:YES];
                
            }
        }];
        
    }
    
    if (component == 1) {
        _cityIndex = row;
        _districtIndex = 0;
        
        [_addressArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj objectForKey:_provinceAry[_proIndex]]) {
                _districtAry = [[obj objectForKey:_provinceAry[_proIndex]] objectForKey:_cityAry[_cityIndex]];
                [_pickView reloadComponent:2];
                [_pickView selectRow:0 inComponent:2 animated:YES];
                
            }

        }];
        
        
    }
    
    if (component == 2) {
        _districtIndex = row;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(_contentView.frame, point)) {
        [self leftButtonClick:nil];
    }
    
}


@end

