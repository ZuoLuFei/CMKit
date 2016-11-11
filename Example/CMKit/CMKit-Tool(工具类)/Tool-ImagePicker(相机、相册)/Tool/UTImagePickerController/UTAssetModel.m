//
//  UTAssetModel.m
//  UTImagePickerController
//
//  Created by yons on 15/12/24.
//  Copyright © 2015年 yons. All rights reserved.
//

#import "UTAssetModel.h"
#import "UTImageManager.h"

@implementation UTAssetModel

+ (instancetype)modelWithAsset:(id)asset type:(UTAssetModelMediaType)type{
    UTAssetModel *model = [[UTAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}

+ (instancetype)modelWithAsset:(id)asset type:(UTAssetModelMediaType)type timeLength:(NSString *)timeLength {
    UTAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}

@end



@implementation UTAlbumModel

- (void)setResult:(id)result {
    _result = result;
    BOOL allowPickingImage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ut_allowPickingImage"] isEqualToString:@"1"];
    BOOL allowPickingVideo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ut_allowPickingVideo"] isEqualToString:@"1"];
    [[UTImageManager manager] getAssetsFromFetchResult:result allowPickingVideo:allowPickingVideo allowPickingImage:allowPickingImage completion:^(NSArray<UTAssetModel *> *models) {
        _models = models;
        if (_selectedModels) {
            [self checkSelectedModels];
        }
    }];
}

- (void)setSelectedModels:(NSArray *)selectedModels {
    _selectedModels = selectedModels;
    if (_models) {
        [self checkSelectedModels];
    }
}

- (void)checkSelectedModels {
    self.selectedCount = 0;
    NSMutableArray *selectedAssets = [NSMutableArray array];
    for (UTAssetModel *model in _selectedModels) {
        [selectedAssets addObject:model.asset];
    }
    for (UTAssetModel *model in _models) {
        if ([[UTImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
            self.selectedCount ++;
        }
    }
}

@end
