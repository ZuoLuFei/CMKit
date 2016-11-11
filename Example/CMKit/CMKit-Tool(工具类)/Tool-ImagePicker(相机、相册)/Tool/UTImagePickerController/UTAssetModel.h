//
//  UTAssetModel.h
//  UTImagePickerController
//
//  Created by yons on 15/12/24.
//  Copyright © 2015年 yons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UTAssetModelMediaTypePhoto = 0,
    UTAssetModelMediaTypeLivePhoto,
    UTAssetModelMediaTypeVideo,
    UTAssetModelMediaTypeAudio
} UTAssetModelMediaType;

@class PHAsset;
@interface UTAssetModel : NSObject

@property (nonatomic, strong) id asset;             /*maybe PHAsset or ALAsset*/
@property (nonatomic, assign) BOOL isSelected;      /*The select status of a photo, default is No*/
@property (nonatomic, assign) UTAssetModelMediaType type;
@property (nonatomic, copy) NSString *timeLength;

/*Init a photo dataModel With a asset 
 用一个PHAsset/ALAsset实例，初始化一个照片模型
 */
+ (instancetype)modelWithAsset:(id)asset type:(UTAssetModelMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(UTAssetModelMediaType)type timeLength:(NSString *)timeLength;

@end


@class PHFetchResult;
@interface UTAlbumModel : NSObject

@property (nonatomic, strong) NSString *name;        /*The album name*/
@property (nonatomic, assign) NSInteger count;       /*Count of photos the album contain*/
@property (nonatomic, strong) id result;
/*result maybe PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>*/

@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSArray *selectedModels;
@property (nonatomic, assign) NSUInteger selectedCount;
@end
