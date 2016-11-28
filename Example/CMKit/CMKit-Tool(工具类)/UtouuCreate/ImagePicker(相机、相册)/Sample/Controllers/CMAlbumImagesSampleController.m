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

@interface CMAlbumImagesSampleController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TZImagePickerControllerDelegate,UIViewControllerPreviewingDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    NSInteger      maxImagesCount;
    NSInteger      columnNumber;
    
    UICollectionView *_collectionView;
    
}

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

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


//#pragma mark - 3DTouch
//- (void)check3DTouch {
//    
//    //检查3D Touch是否可用
//    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//        
//        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
//        NSLog(@"3D Touch可用");
//        
//        // 不需要替代方案
//        self.longPress.enabled = NO;
//        
//    } else {
//        if (DEF_iOS9_LATER) {
//            
//            [[CMAlertView alloc] showAlertController:self title:@"3D Touch未开启" message:@"请在iPhone的\"设置>通用>辅助功能>3D Touch\"选项中,开启3D Touch功能." cancelTitle:@"确定" actionBlock:^(NSInteger buttonTag) {
//                
//            } otherButtonTitles:nil];
//            
//        }else{
//            NSLog(@"3D Touch不可用");
//            // 模拟3D Touch方案
//            self.longPress.enabled = YES;
//            
//        }
//        
//    }
//}
//
//#pragma mark - 3D Touch代理
//- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
//    
//    //检测是否已经展示了预览界面
//    if ([self.presentedViewController isKindOfClass:[CM3DTouchPreviewSampleController class]]) {
//        return nil;
//    }
//    
//    // 内容预览控制器(peek)
//    CM3DTouchPreviewSampleController *previewVc = [[CM3DTouchPreviewSampleController alloc] init];
//    return previewVc;
//}
//
//- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
//    
//    //继续深度按压：显示详情界面（pop）
//    CM3DTouchCommitSampleController *commitVc = [[CM3DTouchCommitSampleController alloc] init];
//    [self showViewController:commitVc sender:self];
//}
//
//#pragma mark - 3D Touch Alternative
//- (void)showPeek {
//    
//    self.longPress.enabled = NO;
//    
//    // 展现内容预览控制器(peek)
//    CM3DTouchPreviewSampleController *previewVc = [[CM3DTouchPreviewSampleController alloc] init];
//    
//    UIViewController *presenter = [self grabTopViewController];
//    [presenter showViewController:previewVc sender:self];
//    
//}
//
//- (UIViewController *)grabTopViewController {
//    
//    // helper method to always give the top most view controller
//    // avoids "view is not in the window hierarchy" error
//    // http://stackoverflow.com/questions/26022756/warning-attempt-to-present-on-whose-view-is-not-in-the-window-hierarchy-sw
//    
//    UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;
//    while (top.presentedViewController) {
//        top = top.presentedViewController;
//    }
//    
//    return top;
//}
//
//
//
//#pragma mark - 设置环境改变回调
//- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
//    
//    
//    //当设置环境改变时回调，不管3D Touch开启与否，都再检查设置一次
//    [self check3DTouch];
//}
//
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
