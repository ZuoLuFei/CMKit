//
//  UTPhotoPickerController.m
//  UTImagePickerController
//
//  Created by yons on 15/12/24.
//  Copyright © 2015年 yons. All rights reserved.
//

#import "UTPhotoPickerController.h"
#import "UTImagePickerController.h"
#import "UTPhotoPreviewController.h"
#import "UTAssetCell.h"
#import "UTAssetModel.h"
#import "UIView+Layout.h"
#import "UTImageManager.h"
#import "UTVideoPlayerController.h"
#import "UTImagePick.h"


@interface UTPhotoPickerController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate> {
    NSMutableArray *_models;
    
    UIButton *_previewButton;
    UIButton *_okButton;
    UIImageView *_numberImageView;
    UILabel *_numberLable;
    UIButton *_originalPhotoButton;
    UILabel *_originalPhotoLable;
    
    BOOL _shouldScrollToBottom;
    BOOL _showTakePhotoBtn;
}
@property CGRect previousPreheatRect;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
@property (nonatomic, strong) UTCollectionView *collectionView;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@end

static CGSize AssetGridThumbnailSize;

@implementation UTPhotoPickerController

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *UTBarItem, *BarItem;
        if (iOS9Later) {
            UTBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UTImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UTBarItem = [UIBarButtonItem appearanceWhenContainedIn:[UTImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [UTBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    _isSelectOriginalPhoto = UTImagePickerVc.isSelectOriginalPhoto;
    _shouldScrollToBottom = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _model.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSBundle ut_localizedStringForKey:@"Cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    _showTakePhotoBtn = (([[UTImageManager manager] isCameraRollAlbum:_model.name]) && UTImagePickerVc.allowTakePicture);
    if (!UTImagePickerVc.sortAscendingByModificationDate && _isFirstAppear && iOS8Later) {
        [[UTImageManager manager] getCameraRollAlbum:UTImagePickerVc.allowPickingVideo allowPickingImage:UTImagePickerVc.allowPickingImage completion:^(UTAlbumModel *model) {
            _model = model;
            _models = [NSMutableArray arrayWithArray:_model.models];
            [self initSubviews];
        }];
    } else {
        if (_showTakePhotoBtn || !iOS8Later || _isFirstAppear) {
            [[UTImageManager manager] getAssetsFromFetchResult:_model.result allowPickingVideo:UTImagePickerVc.allowPickingVideo allowPickingImage:UTImagePickerVc.allowPickingImage completion:^(NSArray<UTAssetModel *> *models) {
                _models = [NSMutableArray arrayWithArray:models];
                [self initSubviews];
            }];
        } else {
            _models = [NSMutableArray arrayWithArray:_model.models];
            [self initSubviews];
        }
    }
    // [self resetCachedAssets];
}

- (void)initSubviews {
    [self checkSelectedModels];
    [self configCollectionView];
    [self configBottomToolBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    UTImagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    if (self.backButtonClickHandle) {
        self.backButtonClickHandle(_model);
    }
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)configCollectionView {
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 5;
    CGFloat itemWH = (self.view.ut_width - (self.columnNumber + 1) * margin) / self.columnNumber;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    CGFloat top = 44;
    if (iOS7Later) top += 20;
    CGFloat collectionViewHeight = UTImagePickerVc.maxImagesCount > 1 ? self.view.ut_height - 50 - top : self.view.ut_height - top;
    _collectionView = [[UTCollectionView alloc] initWithFrame:CGRectMake(0, top, self.view.ut_width, collectionViewHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceHorizontal = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    if (_showTakePhotoBtn && UTImagePickerVc.allowTakePicture ) {
        _collectionView.contentSize = CGSizeMake(self.view.ut_width, ((_model.count + self.columnNumber) / self.columnNumber) * self.view.ut_width);
    } else {
        _collectionView.contentSize = CGSizeMake(self.view.ut_width, ((_model.count + self.columnNumber - 1) / self.columnNumber) * self.view.ut_width);
    }
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[UTAssetCell class] forCellWithReuseIdentifier:@"UTAssetCell"];
    [_collectionView registerClass:[UTAssetCameraCell class] forCellWithReuseIdentifier:@"UTAssetCameraCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self scrollCollectionViewToBottom];
    // Determine the size of the thumbnails to request from the PHCachingImageManager
    CGFloat scale = 2.0;
    if ([UIScreen mainScreen].bounds.size.width > 600) {
        scale = 1.0;
    }
    CGSize cellSize = ((UICollectionViewFlowLayout *)_collectionView.collectionViewLayout).itemSize;
    AssetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (iOS8Later) {
        // [self updateCachedAssets];
    }
}

- (void)configBottomToolBar {
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    if (UTImagePickerVc.maxImagesCount <= 1) return;
    
    UIView *bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.ut_height - 50, self.view.ut_width, 50)];
    CGFloat rgb = 253 / 255.0;
    bottomToolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    
    NSString *previewText = [NSBundle ut_localizedStringForKey:@"Preview"];
    CGFloat previewWidth = [previewText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width;
    _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewButton.frame = CGRectMake(10, 3, previewWidth + 2, 44);
    _previewButton.ut_width = UTImagePickerVc.maxImagesCount <= 1 ? 0 : previewWidth + 2;
    [_previewButton addTarget:self action:@selector(previewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _previewButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_previewButton setTitle:previewText forState:UIControlStateNormal];
    [_previewButton setTitle:previewText forState:UIControlStateDisabled];
    [_previewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_previewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    _previewButton.enabled = UTImagePickerVc.selectedModels.count;
    
    if (UTImagePickerVc.allowPickingOriginalPhoto) {
        NSString *fullImageText = [NSBundle ut_localizedStringForKey:@"Full image"];
        CGFloat fullImageWidth = [fullImageText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
        _originalPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalPhotoButton.frame = CGRectMake(CGRectGetMaxX(_previewButton.frame), self.view.ut_height - 50, fullImageWidth + 56, 50);
        _originalPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_originalPhotoButton addTarget:self action:@selector(originalPhotoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _originalPhotoButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_originalPhotoButton setTitle:fullImageText forState:UIControlStateNormal];
        [_originalPhotoButton setTitle:fullImageText forState:UIControlStateSelected];
        [_originalPhotoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_originalPhotoButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_originalPhotoButton setImage:[UIImage imageNamedFromMyBundle:UTImagePickerVc.photoOriginDefImageName] forState:UIControlStateNormal];
        [_originalPhotoButton setImage:[UIImage imageNamedFromMyBundle:UTImagePickerVc.photoOriginSelImageName] forState:UIControlStateSelected];
        _originalPhotoButton.selected = _isSelectOriginalPhoto;
        _originalPhotoButton.enabled = UTImagePickerVc.selectedModels.count > 0;
        
        _originalPhotoLable = [[UILabel alloc] init];
        _originalPhotoLable.frame = CGRectMake(fullImageWidth + 46, 0, 80, 50);
        _originalPhotoLable.textAlignment = NSTextAlignmentLeft;
        _originalPhotoLable.font = [UIFont systemFontOfSize:16];
        _originalPhotoLable.textColor = [UIColor blackColor];
        if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
    }
    
    _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _okButton.frame = CGRectMake(self.view.ut_width - 44 - 12, 3, 44, 44);
    _okButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_okButton setTitle:[NSBundle ut_localizedStringForKey:@"Done"] forState:UIControlStateNormal];
    [_okButton setTitle:[NSBundle ut_localizedStringForKey:@"Done"] forState:UIControlStateDisabled];
    [_okButton setTitleColor:UTImagePickerVc.oKButtonTitleColorNormal forState:UIControlStateNormal];
    [_okButton setTitleColor:UTImagePickerVc.oKButtonTitleColorDisabled forState:UIControlStateDisabled];
    _okButton.enabled = UTImagePickerVc.selectedModels.count || UTImagePickerVc.alwaysEnableDoneBtn;
    
    _numberImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamedFromMyBundle:UTImagePickerVc.photoNumberIconImageName]];
    _numberImageView.frame = CGRectMake(self.view.ut_width - 56 - 28, 10, 30, 30);
    _numberImageView.hidden = UTImagePickerVc.selectedModels.count <= 0;
    _numberImageView.backgroundColor = [UIColor clearColor];
    
    _numberLable = [[UILabel alloc] init];
    _numberLable.frame = _numberImageView.frame;
    _numberLable.font = [UIFont systemFontOfSize:15];
    _numberLable.textColor = [UIColor whiteColor];
    _numberLable.textAlignment = NSTextAlignmentCenter;
    _numberLable.text = [NSString stringWithFormat:@"%zd",UTImagePickerVc.selectedModels.count];
    _numberLable.hidden = UTImagePickerVc.selectedModels.count <= 0;
    _numberLable.backgroundColor = [UIColor clearColor];
    
    UIView *divide = [[UIView alloc] init];
    CGFloat rgb2 = 222 / 255.0;
    divide.backgroundColor = [UIColor colorWithRed:rgb2 green:rgb2 blue:rgb2 alpha:1.0];
    divide.frame = CGRectMake(0, 0, self.view.ut_width, 1);

    [bottomToolBar addSubview:divide];
    [bottomToolBar addSubview:_previewButton];
    [bottomToolBar addSubview:_okButton];
    [bottomToolBar addSubview:_numberImageView];
    [bottomToolBar addSubview:_numberLable];
    [self.view addSubview:bottomToolBar];
    [self.view addSubview:_originalPhotoButton];
    [_originalPhotoButton addSubview:_originalPhotoLable];
}

#pragma mark - Click Event

- (void)cancel {
    UTImagePickerController *imagePickerVc = (UTImagePickerController *)self.navigationController;
    if (imagePickerVc.autoDismiss) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(ut_imagePickerControllerDidCancel:)]) {
        [imagePickerVc.pickerDelegate ut_imagePickerControllerDidCancel:imagePickerVc];
    }
    if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [imagePickerVc.pickerDelegate imagePickerControllerDidCancel:imagePickerVc];
    }
    if (imagePickerVc.imagePickerControllerDidCancelHandle) {
        imagePickerVc.imagePickerControllerDidCancelHandle();
    }
}

- (void)previewButtonClick {
    UTPhotoPreviewController *photoPreviewVc = [[UTPhotoPreviewController alloc] init];
    [self pushPhotoPrevireViewController:photoPreviewVc];
}

- (void)originalPhotoButtonClick {
    _originalPhotoButton.selected = !_originalPhotoButton.isSelected;
    _isSelectOriginalPhoto = _originalPhotoButton.isSelected;
    _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
    if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
}

- (void)okButtonClick {
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    // 1.6.8 判断是否满足最小必选张数的限制
    if (UTImagePickerVc.minImagesCount && UTImagePickerVc.selectedModels.count < UTImagePickerVc.minImagesCount) {
        NSString *title = [NSString stringWithFormat:[NSBundle ut_localizedStringForKey:@"Select a minimum of %zd photos"], UTImagePickerVc.minImagesCount];
        [UTImagePickerVc showAlertWithTitle:title];
        return;
    }
    
    [UTImagePickerVc showProgressHUD];
    NSMutableArray *photos = [NSMutableArray array];
    NSMutableArray *assets = [NSMutableArray array];
    NSMutableArray *infoArr = [NSMutableArray array];
    for (NSInteger i = 0; i < UTImagePickerVc.selectedModels.count; i++) { [photos addObject:@1];[assets addObject:@1];[infoArr addObject:@1]; }
    
    [UTImageManager manager].shouldFixOrientation = YES;
    for (NSInteger i = 0; i < UTImagePickerVc.selectedModels.count; i++) {
        UTAssetModel *model = UTImagePickerVc.selectedModels[i];
        [[UTImageManager manager] getPhotoWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
            if (isDegraded) return;
            if (photo) {
                photo = [self scaleImage:photo toSize:CGSizeMake(UTImagePickerVc.photoWidth, (int)(UTImagePickerVc.photoWidth * photo.size.height / photo.size.width))];
                [photos replaceObjectAtIndex:i withObject:photo];
            }
            if (info)  [infoArr replaceObjectAtIndex:i withObject:info];
            [assets replaceObjectAtIndex:i withObject:model.asset];

            for (id item in photos) { if ([item isKindOfClass:[NSNumber class]]) return; }
            
            [self didGetAllPhotos:photos assets:assets infoArr:infoArr];
        }];
    }
    if (UTImagePickerVc.selectedModels.count <= 0) {
        [self didGetAllPhotos:photos assets:assets infoArr:infoArr];
    }
}

- (void)didGetAllPhotos:(NSArray *)photos assets:(NSArray *)assets infoArr:(NSArray *)infoArr{
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    if ([UTImagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:)]) {
        [UTImagePickerVc.pickerDelegate imagePickerController:UTImagePickerVc didFinishPickingPhotos:photos sourceAssets:assets isSelectOriginalPhoto:_isSelectOriginalPhoto];
    }
    if ([UTImagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:infos:)]) {
        [UTImagePickerVc.pickerDelegate imagePickerController:UTImagePickerVc didFinishPickingPhotos:photos sourceAssets:assets isSelectOriginalPhoto:_isSelectOriginalPhoto infos:infoArr];
    }
    if (UTImagePickerVc.didFinishPickingPhotosHandle) {
        UTImagePickerVc.didFinishPickingPhotosHandle(photos,assets,_isSelectOriginalPhoto);
    }
    if (UTImagePickerVc.didFinishPickingPhotosWithInfosHandle) {
        UTImagePickerVc.didFinishPickingPhotosWithInfosHandle(photos,assets,_isSelectOriginalPhoto,infoArr);
    }
    [UTImagePickerVc hideProgressHUD];
    
    if (UTImagePickerVc.autoDismiss) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_showTakePhotoBtn) {
        UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
        if (UTImagePickerVc.allowPickingImage && UTImagePickerVc.allowTakePicture) {
            return _models.count + 1;
        }
    }
    return _models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // the cell lead to take a picture / 去拍照的cell
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    if (((UTImagePickerVc.sortAscendingByModificationDate && indexPath.row >= _models.count) || (!UTImagePickerVc.sortAscendingByModificationDate && indexPath.row == 0)) && _showTakePhotoBtn) {
        UTAssetCameraCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UTAssetCameraCell" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamedFromMyBundle:UTImagePickerVc.takePictureImageName];
        return cell;
    }
    // the cell dipaly photo or video / 展示照片或视频的cell
    UTAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UTAssetCell" forIndexPath:indexPath];
    cell.photoDefImageName = UTImagePickerVc.photoDefImageName;
    cell.photoSelImageName = UTImagePickerVc.photoSelImageName;
    UTAssetModel *model;
    if (UTImagePickerVc.sortAscendingByModificationDate || !_showTakePhotoBtn) {
        model = _models[indexPath.row];
    } else {
        model = _models[indexPath.row - 1];
    }
    cell.model = model;
    cell.maxImagesCount = UTImagePickerVc.maxImagesCount;
    
    __weak typeof(cell) weakCell = cell;
    __weak typeof(self) weakSelf = self;
    __weak typeof(_numberImageView.layer) weakLayer = _numberImageView.layer;
    cell.didSelectPhotoBlock = ^(BOOL isSelected) {
        UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)weakSelf.navigationController;
        // 1. cancel select / 取消选择
        if (isSelected) {
            weakCell.selectPhotoButton.selected = NO;
            model.isSelected = NO;
            NSArray *selectedModels = [NSArray arrayWithArray:UTImagePickerVc.selectedModels];
            for (UTAssetModel *model_item in selectedModels) {
                if ([[[UTImageManager manager] getAssetIdentifier:model.asset] isEqualToString:[[UTImageManager manager] getAssetIdentifier:model_item.asset]]) {
                    [UTImagePickerVc.selectedModels removeObject:model_item];
                    break;
                }
            }
            [weakSelf refreshBottomToolBarStatus];
        } else {
            // 2. select:check if over the maxImagesCount / 选择照片,检查是否超过了最大个数的限制
            if (UTImagePickerVc.selectedModels.count < UTImagePickerVc.maxImagesCount) {
                weakCell.selectPhotoButton.selected = YES;
                model.isSelected = YES;
                [UTImagePickerVc.selectedModels addObject:model];
                [weakSelf refreshBottomToolBarStatus];
            } else {
                NSString *title = [NSString stringWithFormat:[NSBundle ut_localizedStringForKey:@"Select a maximum of %zd photos"], UTImagePickerVc.maxImagesCount];
                [UTImagePickerVc showAlertWithTitle:title];
            }
        }
        [UIView showOscillatoryAnimationWithLayer:weakLayer type:UTOscillatoryAnimationToSmaller];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // take a photo / 去拍照
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    if (((UTImagePickerVc.sortAscendingByModificationDate && indexPath.row >= _models.count) || (!UTImagePickerVc.sortAscendingByModificationDate && indexPath.row == 0)) && _showTakePhotoBtn)  {
        [self takePhoto]; return;
    }
    // preview phote or video / 预览照片或视频
    NSInteger index = indexPath.row;
    if (!UTImagePickerVc.sortAscendingByModificationDate && _showTakePhotoBtn) {
        index = indexPath.row - 1;
    }
    UTAssetModel *model = _models[index];
    if (model.type == UTAssetModelMediaTypeVideo) {
        if (UTImagePickerVc.selectedModels.count > 0) {
            UTImagePickerController *imagePickerVc = (UTImagePickerController *)self.navigationController;
            [imagePickerVc showAlertWithTitle:[NSBundle ut_localizedStringForKey:@"Can not choose both video and photo"]];
        } else {
            UTVideoPlayerController *videoPlayerVc = [[UTVideoPlayerController alloc] init];
            videoPlayerVc.model = model;
            [self.navigationController pushViewController:videoPlayerVc animated:YES];
        }
    } else {
        UTPhotoPreviewController *photoPreviewVc = [[UTPhotoPreviewController alloc] init];
        photoPreviewVc.currentIndex = index;
        photoPreviewVc.models = _models;
        [self pushPhotoPrevireViewController:photoPreviewVc];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (iOS8Later) {
        // [self updateCachedAssets];
    }
}

#pragma mark - Private Method

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) && iOS7Later) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // 无权限 做一个友好的提示
        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
        NSString *message = [NSString stringWithFormat:[NSBundle ut_localizedStringForKey:@"Please allow %@ to access your camera in \"Settings -> Privacy -> Camera\""],appName];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[NSBundle ut_localizedStringForKey:@"Can not use camera"] message:message delegate:self cancelButtonTitle:[NSBundle ut_localizedStringForKey:@"Cancel"] otherButtonTitles:[NSBundle ut_localizedStringForKey:@"Setting"], nil];
        [alert show];
#pragma clang diagnostic pop
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)refreshBottomToolBarStatus {
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    
    _previewButton.enabled = UTImagePickerVc.selectedModels.count > 0;
    _okButton.enabled = UTImagePickerVc.selectedModels.count > 0 || UTImagePickerVc.alwaysEnableDoneBtn;
    
    _numberImageView.hidden = UTImagePickerVc.selectedModels.count <= 0;
    _numberLable.hidden = UTImagePickerVc.selectedModels.count <= 0;
    _numberLable.text = [NSString stringWithFormat:@"%zd",UTImagePickerVc.selectedModels.count];
    
    _originalPhotoButton.enabled = UTImagePickerVc.selectedModels.count > 0;
    _originalPhotoButton.selected = (_isSelectOriginalPhoto && _originalPhotoButton.enabled);
    _originalPhotoLable.hidden = (!_originalPhotoButton.isSelected);
    if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
}

- (void)pushPhotoPrevireViewController:(UTPhotoPreviewController *)photoPreviewVc {
    __weak typeof(self) weakSelf = self;
    photoPreviewVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    photoPreviewVc.backButtonClickBlock = ^(BOOL isSelectOriginalPhoto) {
        weakSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
        [weakSelf.collectionView reloadData];
        [weakSelf refreshBottomToolBarStatus];
    };
    photoPreviewVc.okButtonClickBlock = ^(BOOL isSelectOriginalPhoto){
        weakSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
        [weakSelf okButtonClick];
    };
    [self.navigationController pushViewController:photoPreviewVc animated:YES];
}

- (void)getSelectedPhotoBytes {
    UTImagePickerController *imagePickerVc = (UTImagePickerController *)self.navigationController;
    [[UTImageManager manager] getPhotosBytesWithArray:imagePickerVc.selectedModels completion:^(NSString *totalBytes) {
        _originalPhotoLable.text = [NSString stringWithFormat:@"(%@)",totalBytes];
    }];
}

/// Scale image
#pragma mark 缩放图片
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width < size.width) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)scrollCollectionViewToBottom {
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    if (_shouldScrollToBottom && _models.count > 0 && UTImagePickerVc.sortAscendingByModificationDate) {
        NSInteger item = _models.count - 1;
        if (_showTakePhotoBtn) {
            UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
            if (UTImagePickerVc.allowPickingImage && UTImagePickerVc.allowTakePicture) {
                item += 1;
            }
        }
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        _shouldScrollToBottom = NO;
    }
}

- (void)checkSelectedModels {
    for (UTAssetModel *model in _models) {
        model.isSelected = NO;
        NSMutableArray *selectedAssets = [NSMutableArray array];
        UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
        for (UTAssetModel *model in UTImagePickerVc.selectedModels) {
            [selectedAssets addObject:model.asset];
        }
        if ([[UTImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
            model.isSelected = YES;
        }
    }
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS10Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }else if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                NSString *message = [NSBundle ut_localizedStringForKey:@"Can not jump to the privacy settings page, please go to the settings page by self, thank you"];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[NSBundle ut_localizedStringForKey:@"Sorry"] message:message delegate:nil cancelButtonTitle:[NSBundle ut_localizedStringForKey:@"OK"] otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UTImagePickerController *imagePickerVc = (UTImagePickerController *)self.navigationController;
        [imagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[UTImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (!error) {
                [self reloadPhotoArray];
            }
        }];
    }
}

- (void)reloadPhotoArray {
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    [[UTImageManager manager] getCameraRollAlbum:UTImagePickerVc.allowPickingVideo allowPickingImage:UTImagePickerVc.allowPickingImage completion:^(UTAlbumModel *model) {
        _model = model;
        [[UTImageManager manager] getAssetsFromFetchResult:_model.result allowPickingVideo:UTImagePickerVc.allowPickingVideo allowPickingImage:UTImagePickerVc.allowPickingImage completion:^(NSArray<UTAssetModel *> *models) {
            [UTImagePickerVc hideProgressHUD];
            
            UTAssetModel *assetModel;
            if (UTImagePickerVc.sortAscendingByModificationDate) {
                assetModel = [models lastObject];
                [_models addObject:assetModel];
            } else {
                assetModel = [models firstObject];
                [_models insertObject:assetModel atIndex:0];
            }
            
            if (UTImagePickerVc.maxImagesCount <= 1) {
                [UTImagePickerVc.selectedModels addObject:assetModel];
                [self okButtonClick]; return;
            }
            
            if (UTImagePickerVc.selectedModels.count < UTImagePickerVc.maxImagesCount) {
                assetModel.isSelected = YES;
                [UTImagePickerVc.selectedModels addObject:assetModel];
                [self refreshBottomToolBarStatus];
            }
            [_collectionView reloadData];
            
            _shouldScrollToBottom = YES;
            [self scrollCollectionViewToBottom];
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Asset Caching

- (void)resetCachedAssets {
    [[UTImageManager manager].cachingImageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets {
    BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
    if (!isViewVisible) { return; }
    
    // The preheat window is twice the height of the visible rect.
    CGRect preheatRect = _collectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
    
    /*
     Check if the collection view is showing an area that is significantly
     different to the last preheated area.
     */
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    if (delta > CGRectGetHeight(_collectionView.bounds) / 3.0f) {
        
        // Compute the assets to start caching and to stop caching.
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            NSArray *indexPaths = [self aapl_indexPathsForElementsInRect:removedRect];
            [removedIndexPaths addObjectsFromArray:indexPaths];
        } addedHandler:^(CGRect addedRect) {
            NSArray *indexPaths = [self aapl_indexPathsForElementsInRect:addedRect];
            [addedIndexPaths addObjectsFromArray:indexPaths];
        }];
        
        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
        
        // Update the assets the PHCachingImageManager is caching.
        [[UTImageManager manager].cachingImageManager startCachingImagesForAssets:assetsToStartCaching
                                            targetSize:AssetGridThumbnailSize
                                           contentMode:PHImageContentModeAspectFill
                                               options:nil];
        [[UTImageManager manager].cachingImageManager stopCachingImagesForAssets:assetsToStopCaching
                                           targetSize:AssetGridThumbnailSize
                                          contentMode:PHImageContentModeAspectFill
                                              options:nil];
        
        // Store the preheat rect to compare against in the future.
        self.previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler {
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    } else {
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths {
    if (indexPaths.count == 0) { return nil; }
    
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        if (indexPath.item < _models.count) {
            UTAssetModel *model = _models[indexPath.item];
            [assets addObject:model.asset];
        }
    }
    
    return assets;
}

- (NSArray *)aapl_indexPathsForElementsInRect:(CGRect)rect {
    NSArray *allLayoutAttributes = [_collectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
    if (allLayoutAttributes.count == 0) { return nil; }
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:allLayoutAttributes.count];
    for (UICollectionViewLayoutAttributes *layoutAttributes in allLayoutAttributes) {
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

@end



@implementation UTCollectionView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
