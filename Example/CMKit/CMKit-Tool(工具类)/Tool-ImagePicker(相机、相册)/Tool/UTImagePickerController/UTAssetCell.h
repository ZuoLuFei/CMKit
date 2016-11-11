//
//  UTAssetCell.h
//  UTImagePickerController
//
//  Created by yons on 15/12/24.
//  Copyright © 2015年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef enum : NSUInteger {
    UTAssetCellTypePhoto = 0,
    UTAssetCellTypeLivePhoto,
    UTAssetCellTypeVideo,
    UTAssetCellTypeAudio,
} UTAssetCellType;

@class UTAssetModel;
@interface UTAssetCell : UICollectionViewCell
@property (nonatomic, assign) NSInteger maxImagesCount;
@property (nonatomic, assign) UTAssetCellType type;
@property (nonatomic, assign) PHImageRequestID imageRequestID;

@property (weak, nonatomic) UIButton *selectPhotoButton;
@property (nonatomic, strong) UTAssetModel *model;

@property (nonatomic, copy) NSString *photoSelImageName;
@property (nonatomic, copy) NSString *photoDefImageName;
@property (nonatomic, copy) NSString *representedAssetIdentifier;

@property (nonatomic, copy) void (^didSelectPhotoBlock)(BOOL);
@end


@class UTAlbumModel;

@interface UTAlbumCell : UITableViewCell

@property (nonatomic, strong) UTAlbumModel *model;
@property (weak, nonatomic) UIButton *selectedCountButton;

@end


@interface UTAssetCameraCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end
