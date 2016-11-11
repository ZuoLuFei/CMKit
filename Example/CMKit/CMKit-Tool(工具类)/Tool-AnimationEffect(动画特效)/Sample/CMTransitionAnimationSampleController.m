//
//  CMTransitionAnimationSampleController.m
//  CMKit
//
//  Created by HC on 16/10/31.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMTransitionAnimationSampleController.h"
#import "CMAnimationEffect.h"
#import "CMAnimationCell.h"

static NSString * const ID = @"CMAnimationCell";

@interface CMTransitionAnimationSampleController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UIView *animationView;

@property (nonatomic , strong) UILabel *animationLabel;

@property (nonatomic , assign) NSInteger index;

@property (nonatomic , strong) NSArray *animationTypeArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CMTransitionAnimationSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self initUI];
    
    

}

#pragma mark - 初始化数据
- (void)initData{

    self.animationTypeArray = @[@{@"animationName":@"fade",@"animationMethod":@"fadeAnimation:"},
                                @{@"animationName":@"moveIn",@"animationMethod":@"moveInAnimation:"},
                                @{@"animationName":@"push",@"animationMethod":@"pushAnimation:"},
                                @{@"animationName":@"reveal",@"animationMethod":@"revealAnimation:"},
                                @{@"animationName":@"cube",@"animationMethod":@"cubeAnimation:"},
                                @{@"animationName":@"suck",@"animationMethod":@"suckEffectAnimation:"},
                                @{@"animationName":@"oglFlip",@"animationMethod":@"oglFlipAnimation:"},
                                @{@"animationName":@"ripple",@"animationMethod":@"rippleEffectAnimation:"},
                                @{@"animationName":@"Curl",@"animationMethod":@"pageCurlAnimation:"},
                                @{@"animationName":@"UnCurl",@"animationMethod":@"pageUnCurlAnimation:"},
                                @{@"animationName":@"caOpen",@"animationMethod":@"cameraIrisHollowOpenAnimation:"},
                                @{@"animationName":@"caClose",@"animationMethod":@"cameraIrisHollowCloseAnimation:"}];
}


#pragma mark 初始化UI
- (void)initUI{
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, SCREEN_HEIGHT/2-200,180,260)];
    [self.view addSubview:self.animationView];
    
    self.animationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.animationView.frame)/2-10, CGRectGetHeight(self.animationView.frame)/2-20, 20, 40)];
    self.animationLabel.textAlignment = NSTextAlignmentCenter;
    self.animationLabel.font = [UIFont systemFontOfSize:40];
    [self.animationView addSubview:self.animationLabel];
    self.index = 0;
    [self changeView:YES];
    
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


/**
 *   设置view的值
 */
-(void)changeView : (BOOL)isUp{
    if (self.index>3) {
        self.index = 0;
    }
    if (self.index<0) {
        self.index = 3;
    }
    NSArray *colors = [NSArray arrayWithObjects:[UIColor cyanColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor], nil];
    NSArray *titles = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    self.animationView.backgroundColor = [colors objectAtIndex:self.index];
    self.animationLabel.text = [titles objectAtIndex:_index];
    if (isUp) {
        self.index++;
    }else{
        self.index--;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.animationTypeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMAnimationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMAnimationCell" forIndexPath:indexPath];
    NSDictionary *dict = self.animationTypeArray[indexPath.row];
    
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
    NSDictionary *dict = self.animationTypeArray[indexPath.row];
    [self changeView:YES];

    [[CMAnimationEffect shareAnimationEffect] performSelector:NSSelectorFromString(dict[@"animationMethod"]) withObject:self.animationView];

    
}



@end
