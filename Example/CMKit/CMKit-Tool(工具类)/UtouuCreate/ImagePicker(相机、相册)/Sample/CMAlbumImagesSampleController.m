//
//  CMAlbumImagesSampleController.m
//  CMKit
//
//  Created by HC on 16/11/2.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMAlbumImagesSampleController.h"
#import "UTTestCell.h"
#import "CMImagePickerManager.h"
#import "TZImagePickerController.h"
#import "TZVideoPlayerController.h"
#import "TZAssetModel.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CMAlbumImagesSampleController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TZImagePickerControllerDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    NSInteger      maxImagesCount;
    NSInteger      columnNumber;
    
    UICollectionView *_collectionView;
    
}
@end

@implementation CMAlbumImagesSampleController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建UI
    [self initUI];
}

#pragma mark - Initialize UI
- (void)initUI{
    
    
    //1.
    maxImagesCount = 9;
    columnNumber = 5;
    _selectedAssets = [NSMutableArray array];
    _selectedPhotos = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //2.
    UIButton *picBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 80, 80, 40)];
    [picBtn setTitle:@"选择照片" forState:UIControlStateNormal];
    [picBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [picBtn addTarget:self action:@selector(pushImagePickerController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:picBtn];
    
    
    //3.
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height-100) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
        
        [_collectionView registerClass:[UTTestCell class] forCellWithReuseIdentifier:@"UTTestCell"];
    }
    _collectionView.hidden = NO;
    
}

#pragma mark - 打开多选相册
- (void)pushImagePickerController {
    
    if (maxImagesCount <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImagesCount columnNumber:columnNumber delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVC.isSelectOriginalPhoto = YES;
    
    if (maxImagesCount > 1) {
        imagePickerVC.selectedAssets = _selectedAssets; // selected images
    }
    imagePickerVC.allowTakePicture = YES; // show take photo button
    
    // 2. Set the appearance
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    imagePickerVC.allowPickingVideo = YES;
    imagePickerVC.allowPickingImage = YES;
    imagePickerVC.allowPickingOriginalPhoto = YES;
    
    imagePickerVC.sortAscendingByModificationDate = NO;
    // You can get the photos by block, the same as by delegate.
    [imagePickerVC setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *info) {
        [_selectedAssets removeAllObjects];
        [_selectedPhotos removeAllObjects];
        
        [_selectedPhotos addObjectsFromArray:photos];
        [_selectedAssets addObjectsFromArray:assets];
        [_collectionView reloadData];
    }];
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];

    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UTTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UTTestCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UTTestCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/5, self.view.bounds.size.width/5)];
    }
    
    cell.imageView.image = _selectedPhotos[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width/columnNumber, self.view.bounds.size.width/columnNumber);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id asset = _selectedAssets[indexPath.row];
    BOOL isVideo = NO;
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    } else if ([asset isKindOfClass:[ALAsset class]]) {
        ALAsset *alAsset = asset;
        isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
    }
#pragma clang diagnostic pop

    if (isVideo) { // perview video
        TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
        TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
        vc.model = model;
        [self presentViewController:vc animated:YES completion:nil];
    } else { // preview photos / 预览照片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        imagePickerVc.maxImagesCount = maxImagesCount;
        imagePickerVc.allowPickingOriginalPhoto = YES;
        imagePickerVc.isSelectOriginalPhoto = NO;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            [_collectionView reloadData];
            //_collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}








@end
