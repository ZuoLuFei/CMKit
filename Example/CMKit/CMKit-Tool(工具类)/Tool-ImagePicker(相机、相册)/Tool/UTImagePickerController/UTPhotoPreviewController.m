//
//  UTPhotoPreviewController.m
//  UTImagePickerController
//
//  Created by yons on 15/12/24.
//  Copyright © 2015年 yons. All rights reserved.
//

#import "UTPhotoPreviewController.h"
#import "UTPhotoPreviewCell.h"
#import "UTAssetModel.h"
#import "UIView+Layout.h"
#import "UTImagePickerController.h"
#import "UTImageManager.h"

@interface UTPhotoPreviewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate> {
    UICollectionView *_collectionView;
    BOOL _isHideNaviBar;
    NSArray *_photosTemp;
    NSArray *_assetsTemp;
    
    UIView *_naviBar;
    UIButton *_backButton;
    UIButton *_selectButton;
    
    UIView *_toolBar;
    UIButton *_okButton;
    UIImageView *_numberImageView;
    UILabel *_numberLable;
    UIButton *_originalPhotoButton;
    UILabel *_originalPhotoLable;
}
@end

@implementation UTPhotoPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    UTImagePickerController *_UTImagePickerVc = (UTImagePickerController *)weakSelf.navigationController;
    if (!self.models.count) {
        self.models = [NSMutableArray arrayWithArray:_UTImagePickerVc.selectedModels];
        _assetsTemp = [NSMutableArray arrayWithArray:_UTImagePickerVc.selectedAssets];
        self.isSelectOriginalPhoto = _UTImagePickerVc.isSelectOriginalPhoto;
    }
    [self configCollectionView];
    [self configCustomNaviBar];
    [self configBottomToolBar];
    self.view.clipsToBounds = YES;
}

- (void)setPhotos:(NSMutableArray *)photos {
    _photos = photos;
    _photosTemp = [NSArray arrayWithArray:photos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = YES;
    if (_currentIndex) [_collectionView setContentOffset:CGPointMake((self.view.ut_width + 20) * _currentIndex, 0) animated:NO];
    [self refreshNaviBarAndBottomBarState];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)configCustomNaviBar {
    UTImagePickerController *UTImagePickerVc = (UTImagePickerController *)self.navigationController;

    _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.ut_width, 64)];
    _naviBar.backgroundColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
    _naviBar.alpha = 0.7;
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
    [_backButton setImage:[UIImage imageNamedFromMyBundle:@"navi_back.png"] forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.ut_width - 54, 10, 42, 42)];
    [_selectButton setImage:[UIImage imageNamedFromMyBundle:UTImagePickerVc.photoDefImageName] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamedFromMyBundle:UTImagePickerVc.photoSelImageName] forState:UIControlStateSelected];
    [_selectButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    _selectButton.hidden = UTImagePickerVc.maxImagesCount == 1;
    
    [_naviBar addSubview:_selectButton];
    [_naviBar addSubview:_backButton];
    [self.view addSubview:_naviBar];
}

- (void)configBottomToolBar {
    _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.ut_height - 44, self.view.ut_width, 44)];
    CGFloat rgb = 34 / 255.0;
    _toolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _toolBar.alpha = 0.7;
    
    UTImagePickerController *_UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    if (_UTImagePickerVc.allowPickingOriginalPhoto) {
        NSString *fullImageText = [NSBundle ut_localizedStringForKey:@"Full image"];
        CGFloat fullImageWidth = [fullImageText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
        _originalPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalPhotoButton.frame = CGRectMake(0, 0, fullImageWidth + 56, 44);
        _originalPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _originalPhotoButton.backgroundColor = [UIColor clearColor];
        [_originalPhotoButton addTarget:self action:@selector(originalPhotoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _originalPhotoButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_originalPhotoButton setTitle:fullImageText forState:UIControlStateNormal];
        [_originalPhotoButton setTitle:fullImageText forState:UIControlStateSelected];
        [_originalPhotoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_originalPhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_originalPhotoButton setImage:[UIImage imageNamedFromMyBundle:_UTImagePickerVc.photoPreviewOriginDefImageName] forState:UIControlStateNormal];
        [_originalPhotoButton setImage:[UIImage imageNamedFromMyBundle:_UTImagePickerVc.photoOriginSelImageName] forState:UIControlStateSelected];
        
        _originalPhotoLable = [[UILabel alloc] init];
        _originalPhotoLable.frame = CGRectMake(fullImageWidth + 42, 0, 80, 44);
        _originalPhotoLable.textAlignment = NSTextAlignmentLeft;
        _originalPhotoLable.font = [UIFont systemFontOfSize:13];
        _originalPhotoLable.textColor = [UIColor whiteColor];
        _originalPhotoLable.backgroundColor = [UIColor clearColor];
        if (_isSelectOriginalPhoto) [self showPhotoBytes];
    }
    
    _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _okButton.frame = CGRectMake(self.view.ut_width - 44 - 12, 0, 44, 44);
    _okButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_okButton setTitle:[NSBundle ut_localizedStringForKey:@"Done"] forState:UIControlStateNormal];
    [_okButton setTitleColor:_UTImagePickerVc.oKButtonTitleColorNormal forState:UIControlStateNormal];
    
    _numberImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamedFromMyBundle:_UTImagePickerVc.photoNumberIconImageName]];
    _numberImageView.backgroundColor = [UIColor clearColor];
    _numberImageView.frame = CGRectMake(self.view.ut_width - 56 - 28, 7, 30, 30);
    _numberImageView.hidden = _UTImagePickerVc.selectedModels.count <= 0;
    
    _numberLable = [[UILabel alloc] init];
    _numberLable.frame = _numberImageView.frame;
    _numberLable.font = [UIFont systemFontOfSize:15];
    _numberLable.textColor = [UIColor whiteColor];
    _numberLable.textAlignment = NSTextAlignmentCenter;
    _numberLable.text = [NSString stringWithFormat:@"%zd",_UTImagePickerVc.selectedModels.count];
    _numberLable.hidden = _UTImagePickerVc.selectedModels.count <= 0;
    _numberLable.backgroundColor = [UIColor clearColor];

    [_originalPhotoButton addSubview:_originalPhotoLable];
    [_toolBar addSubview:_okButton];
    [_toolBar addSubview:_originalPhotoButton];
    [_toolBar addSubview:_numberImageView];
    [_toolBar addSubview:_numberLable];
    [self.view addSubview:_toolBar];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.ut_width + 20, self.view.ut_height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, self.view.ut_width + 20, self.view.ut_height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentOffset = CGPointMake(0, 0);
    _collectionView.contentSize = CGSizeMake(self.models.count * (self.view.ut_width + 20), 0);
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[UTPhotoPreviewCell class] forCellWithReuseIdentifier:@"UTPhotoPreviewCell"];
}

#pragma mark - Click Event

- (void)select:(UIButton *)selectButton {
    UTImagePickerController *_UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    UTAssetModel *model = _models[_currentIndex];
    if (!selectButton.isSelected) {
        // 1. select:check if over the maxImagesCount / 选择照片,检查是否超过了最大个数的限制
        if (_UTImagePickerVc.selectedModels.count >= _UTImagePickerVc.maxImagesCount) {
            NSString *title = [NSString stringWithFormat:[NSBundle ut_localizedStringForKey:@"Select a maximum of %zd photos"], _UTImagePickerVc.maxImagesCount];
            [_UTImagePickerVc showAlertWithTitle:title];
            return;
        // 2. if not over the maxImagesCount / 如果没有超过最大个数限制
        } else {
            [_UTImagePickerVc.selectedModels addObject:model];
            if (self.photos) {
                [_UTImagePickerVc.selectedAssets addObject:_assetsTemp[_currentIndex]];
                [self.photos addObject:_photosTemp[_currentIndex]];
            }
            if (model.type == UTAssetModelMediaTypeVideo) {
                [_UTImagePickerVc showAlertWithTitle:[NSBundle ut_localizedStringForKey:@"Select the video when in multi state, we will handle the video as a photo"]];
            }
        }
    } else {
        NSArray *selectedModels = [NSArray arrayWithArray:_UTImagePickerVc.selectedModels];
        for (UTAssetModel *model_item in selectedModels) {
            if ([[[UTImageManager manager] getAssetIdentifier:model.asset] isEqualToString:[[UTImageManager manager] getAssetIdentifier:model_item.asset]]) {
                // 1.6.7版本更新:防止有多个一样的model,一次性被移除了
                NSArray *selectedModelsTmp = [NSArray arrayWithArray:_UTImagePickerVc.selectedModels];
                for (NSInteger i = 0; i < selectedModelsTmp.count; i++) {
                    UTAssetModel *model = selectedModelsTmp[i];
                    if ([model isEqual:model_item]) {
                        [_UTImagePickerVc.selectedModels removeObjectAtIndex:i];
                        break;
                    }
                }
                // [_UTImagePickerVc.selectedModels removeObject:model_item];
                if (self.photos) {
                    // 1.6.7版本更新:防止有多个一样的asset,一次性被移除了
                    NSArray *selectedAssetsTmp = [NSArray arrayWithArray:_UTImagePickerVc.selectedAssets];
                    for (NSInteger i = 0; i < selectedAssetsTmp.count; i++) {
                        id asset = selectedAssetsTmp[i];
                        if ([asset isEqual:_assetsTemp[_currentIndex]]) {
                            [_UTImagePickerVc.selectedAssets removeObjectAtIndex:i];
                            break;
                        }
                    }
                    // [_UTImagePickerVc.selectedAssets removeObject:_assetsTemp[_currentIndex]];
                    [self.photos removeObject:_photosTemp[_currentIndex]];
                }
                break;
            }
        }
    }
    model.isSelected = !selectButton.isSelected;
    [self refreshNaviBarAndBottomBarState];
    if (model.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:selectButton.imageView.layer type:UTOscillatoryAnimationToBigger];
    }
    [UIView showOscillatoryAnimationWithLayer:_numberImageView.layer type:UTOscillatoryAnimationToSmaller];
}

- (void)back {
    if (self.navigationController.childViewControllers.count < 2) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    if (self.backButtonClickBlock) {
        self.backButtonClickBlock(_isSelectOriginalPhoto);
    }
}

- (void)okButtonClick {
    UTImagePickerController *_UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    // 如果没有选中过照片 点击确定时选中当前预览的照片
    if (_UTImagePickerVc.selectedModels.count == 0 && _UTImagePickerVc.minImagesCount <= 0) {
        UTAssetModel *model = _models[_currentIndex];
        [_UTImagePickerVc.selectedModels addObject:model];
    }
    if (self.okButtonClickBlock) {
        self.okButtonClickBlock(_isSelectOriginalPhoto);
    }
    if (self.okButtonClickBlockWithPreviewType) {
        self.okButtonClickBlockWithPreviewType(self.photos,_UTImagePickerVc.selectedAssets,self.isSelectOriginalPhoto);
    }
}

- (void)originalPhotoButtonClick {
    _originalPhotoButton.selected = !_originalPhotoButton.isSelected;
    _isSelectOriginalPhoto = _originalPhotoButton.isSelected;
    _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
    if (_isSelectOriginalPhoto) {
        [self showPhotoBytes];
        if (!_selectButton.isSelected) {
            // 如果当前已选择照片张数 < 最大可选张数 && 最大可选张数大于1，就选中该张图
            UTImagePickerController *_UTImagePickerVc = (UTImagePickerController *)self.navigationController;
            if (_UTImagePickerVc.selectedModels.count < _UTImagePickerVc.maxImagesCount && _UTImagePickerVc.maxImagesCount > 1) {
                [self select:_selectButton];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetWidth = scrollView.contentOffset.x;
    offSetWidth = offSetWidth +  ((self.view.ut_width + 20) * 0.5);
    
    NSInteger currentIndex = offSetWidth / (self.view.ut_width + 20);
    
    if (_currentIndex != currentIndex) {
        _currentIndex = currentIndex;
        [self refreshNaviBarAndBottomBarState];
    }
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UTPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UTPhotoPreviewCell" forIndexPath:indexPath];
    cell.model = _models[indexPath.row];
    
    if (!cell.singleTapGestureBlock) {
        __block BOOL _weakIsHideNaviBar = _isHideNaviBar;
        __weak typeof(_naviBar) weakNaviBar = _naviBar;
        __weak typeof(_toolBar) weakToolBar = _toolBar;
        cell.singleTapGestureBlock = ^(){
            // show or hide naviBar / 显示或隐藏导航栏
            _weakIsHideNaviBar = !_weakIsHideNaviBar;
            weakNaviBar.hidden = _weakIsHideNaviBar;
            weakToolBar.hidden = _weakIsHideNaviBar;
        };
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[UTPhotoPreviewCell class]]) {
        [(UTPhotoPreviewCell *)cell recoverSubviews];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[UTPhotoPreviewCell class]]) {
        [(UTPhotoPreviewCell *)cell recoverSubviews];
    }
}

#pragma mark - Private Method

- (void)dealloc {
    // NSLog(@"dealloc");
}

- (void)refreshNaviBarAndBottomBarState {
    UTImagePickerController *_UTImagePickerVc = (UTImagePickerController *)self.navigationController;
    UTAssetModel *model = _models[_currentIndex];
    _selectButton.selected = model.isSelected;
    _numberLable.text = [NSString stringWithFormat:@"%zd",_UTImagePickerVc.selectedModels.count];
    _numberImageView.hidden = (_UTImagePickerVc.selectedModels.count <= 0 || _isHideNaviBar);
    _numberLable.hidden = (_UTImagePickerVc.selectedModels.count <= 0 || _isHideNaviBar);
    
    _originalPhotoButton.selected = _isSelectOriginalPhoto;
    _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
    if (_isSelectOriginalPhoto) [self showPhotoBytes];
    
    // If is previewing video, hide original photo button
    // 如果正在预览的是视频，隐藏原图按钮
    if (!_isHideNaviBar) {
        if (model.type == UTAssetModelMediaTypeVideo) {
            _originalPhotoButton.hidden = YES;
            _originalPhotoLable.hidden = YES;
        } else {
            _originalPhotoButton.hidden = NO;
            if (_isSelectOriginalPhoto)  _originalPhotoLable.hidden = NO;
        }
    }
    
    // 让宽度/高度小于 最小可选照片尺寸 的图片不能选中
    _okButton.hidden = NO;
    _selectButton.hidden = _UTImagePickerVc.maxImagesCount == 1;
    if (![[UTImageManager manager] isPhotoSelectableWithAsset:model.asset]) {
        _numberLable.hidden = YES;
        _numberImageView.hidden = YES;
        _selectButton.hidden = YES;
        _originalPhotoButton.hidden = YES;
        _originalPhotoLable.hidden = YES;
        _okButton.hidden = YES;
    }
}

- (void)showPhotoBytes {
    [[UTImageManager manager] getPhotosBytesWithArray:@[_models[_currentIndex]] completion:^(NSString *totalBytes) {
        _originalPhotoLable.text = [NSString stringWithFormat:@"(%@)",totalBytes];
    }];
}

@end
