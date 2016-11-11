//
//  UTPhotoPickerController.h
//  UTImagePickerController
//
//  Created by yons on 15/12/24.
//  Copyright © 2015年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UTAlbumModel;
@interface UTPhotoPickerController : UIViewController

@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, assign) NSInteger columnNumber;
@property (nonatomic, strong) UTAlbumModel *model;

@property (nonatomic, copy) void (^backButtonClickHandle)(UTAlbumModel *model);

@end


@interface UTCollectionView : UICollectionView

@end
