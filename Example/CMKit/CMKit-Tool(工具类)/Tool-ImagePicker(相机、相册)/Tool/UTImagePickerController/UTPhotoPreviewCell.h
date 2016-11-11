//
//  UTPhotoPreviewCell.h
//  UTImagePickerController
//
//  Created by yons on 15/12/24.
//  Copyright © 2015年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UTAssetModel;
@interface UTPhotoPreviewCell : UICollectionViewCell

@property (nonatomic, strong) UTAssetModel *model;
@property (nonatomic, copy) void (^singleTapGestureBlock)();

- (void)recoverSubviews;

@end
