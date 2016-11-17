//
//  CMBaseAnimationSampleController.m
//  CMKit
//
//  Created by HC on 16/10/31.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMBaseAnimationSampleController.h"
#import "CMAnimationEffect.h"
#import "CMAnimationCell.h"

@interface CMBaseAnimationSampleController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *animationArray;
@property (nonatomic, strong) UIView *animationView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CMBaseAnimationSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initUI];

}

#pragma mark - 初始化数据
- (void)initData{
    self.animationArray = @[@{@"animationName":@"位移",@"animationMethod":@"positionAnimation:"},
                            @{@"animationName":@"透明度",@"animationMethod":@"opacityAniamtion:"},
                            @{@"animationName":@"缩放",@"animationMethod":@"scaleAnimation:"},
                            @{@"animationName":@"旋转",@"animationMethod":@"rotateAnimation:"},
                            @{@"animationName":@"背景色",@"animationMethod":@"backgroundAnimation:"},
                            @{@"animationName":@"关键帧",@"animationMethod":@"keyFrameAnimation:"},
                            @{@"animationName":@"路径",@"animationMethod":@"pathAnimation:"},
                            @{@"animationName":@"抖动",@"animationMethod":@"shakeAnimation:"},
                            @{@"animationName":@"同时",@"animationMethod":@"groupAnimation:"},
                            @{@"animationName":@"连续",@"animationMethod":@"plainAnimation:"},
                            @{@"animationName":@"摇一摇",@"animationMethod":@"shakeItOffAnimation:"},
                            @{@"animationName":@"弹跳",@"animationMethod":@"springingAnimation:"},
                            @{@"animationName":@"冲击",@"animationMethod":@"praiseAnimation:"}
                            ];
}

#pragma mark - 初始化UI
- (void) initUI{

    self.view.backgroundColor = [UIColor whiteColor];

    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-50, SCREEN_HEIGHT/2.0-50, 100, 100)];
    [self.view addSubview:self.animationView];
    self.animationView.backgroundColor = [UIColor redColor];
    
    [self configCollectionView];

}

- (void)configCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置其布局方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //其布局很有意思，当你的cell设置大小后，一行多少个cell，由cell的宽度决定
    //设置其边界
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-180, self.view.frame.size.width-5*2, 180) collectionViewLayout:flowLayout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[CMAnimationCell class] forCellWithReuseIdentifier:@"CMAnimationCell"];
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.animationArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMAnimationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMAnimationCell" forIndexPath:indexPath];
    NSDictionary *dict = self.animationArray[indexPath.row];
    
    cell.cellStr = dict[@"animationName"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((collectionView.bounds.size.width- 10*3)/4, 40);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.animationArray[indexPath.row];
    
    [[CMAnimationEffect shareAnimationEffect] performSelector:NSSelectorFromString(dict[@"animationMethod"]) withObject:self.animationView];
    
    
}


@end
