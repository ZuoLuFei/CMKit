//
//  CMPictureBrowseSampleController.m
//  CMKit
//
//  Created by HC on 16/11/25.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMPictureBrowseSampleController.h"
#import "CMPictureBrowseSampleCell.h"
#import "MSSBrowseNetworkViewController.h"
#import "MSSBrowseLocalViewController.h"
#import "MSSBrowseModel.h"
#import "SDImageCache.h"

@interface CMPictureBrowseSampleController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIViewControllerTransitioningDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *smallUrlArray;
@property (nonatomic,strong)NSArray *bigUrlArray;

@end

@implementation CMPictureBrowseSampleController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initUI];
    
}

#pragma mark - 初始化数据
- (void)initData {
    _smallUrlArray = @[@"http://www.guimobile.net/blog/uploads/2014/05/141435AZe.jpg",
                       @"http://www.guimobile.net/blog/uploads/2014/05/141435AZe.jpg",
                       @"http://www.guimobile.net/blog/uploads/2014/05/141435AZe.jpg",
                       @"http://www.guimobile.net/blog/uploads/2014/05/141435AZe.jpg",
                       @"http://www.guimobile.net/blog/uploads/2014/05/141435AZe.jpg",
                       @"http://www.guimobile.net/blog/uploads/2014/05/141435AZe.jpg",
                       @"http://www.guimobile.net/blog/uploads/2014/05/141435AZe.jpg",
                       @"http://www.guimobile.net/blog/uploads/2014/05/141435AZe.jpg"];
    
    _bigUrlArray = @[@"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg",
                     @"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg",
                     @"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg",
                     @"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg",
                     @"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg",
                     @"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg",
                     @"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg",
                     @"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg",
                     @"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg",
                     @"http://utouu-web-test.oss-cn-hangzhou.aliyuncs.com/union/1486959780703.jpg"];
    
    
}

#pragma mark - 初始化UI
- (void)initUI {
    //1.背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 70, 100, 50);
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"清空缓存" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    //3.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.minimumLineSpacing = 10;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, btn.bottom, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT- btn.bottom) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    //cell注册
    [_collectionView registerClass:[CMPictureBrowseSampleCell class] forCellWithReuseIdentifier:@"CMPictureBrowseSampleCell"];
    [self.view addSubview:_collectionView];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_smallUrlArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMPictureBrowseSampleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMPictureBrowseSampleCell" forIndexPath:indexPath];
    if (cell)
    {
        cell.imageView.tag = indexPath.row + 100;
        cell.imageUrl = _smallUrlArray[indexPath.row];
    }
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    // 加载网络图片
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    int i = 0;
    for(i = 0;i < [_smallUrlArray count];i++)
    {
//        UIImageView *imageView = [self.view viewWithTag:i + 100];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = _bigUrlArray[i];// 加载网络图片大图地址
//        browseItem.smallImageView = imageView;// 小图
        [browseItemArray addObject:browseItem];
    }
    CMPictureBrowseSampleCell *cell = (CMPictureBrowseSampleCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
    //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController];
    
    //    // 加载本地图片
    //    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    //    int i = 0;
    //    for(i = 0;i < [_smallUrlArray count];i++)
    //    {
    //        UIImageView *imageView = [self.view viewWithTag:i + 100];
    //        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
    ////        browseItem.bigImageLocalPath 建议传本地图片的路径来减少内存使用
    //        browseItem.bigImage = imageView.image;// 大图赋值
    //        browseItem.smallImageView = imageView;// 小图
    //        [browseItemArray addObject:browseItem];
    //    }
    //    MSSCollectionViewCell *cell = (MSSCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    //    MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
    //    [bvc showBrowseViewController];
}


- (void)btnClick
{
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
        [_collectionView reloadData];
    }];
}



@end
