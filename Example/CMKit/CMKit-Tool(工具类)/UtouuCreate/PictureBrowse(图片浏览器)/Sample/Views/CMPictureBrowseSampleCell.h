//
//  CMPictureBrowseSampleCell.h
//  CMKit
//
//  Created by HC on 16/11/25.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMPictureBrowseSampleCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageUrl;

/** 将imageView暴露出来为了获取其在Window中的frame，便于做动画，平时不推荐暴露出私有控件的 */
@property (nonatomic,strong,readonly)UIImageView *imageView;

@end
