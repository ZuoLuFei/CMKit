//
//  CMVideoModel.h
//  CMKit
//
//  Created by HC on 17/2/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMVideoResolution.h"

@interface CMVideoModel : NSObject

/** 标题 */
@property (nonatomic, copy  ) NSString *title;
/** 描述 */
@property (nonatomic, copy  ) NSString *video_description;
/** 视频地址 */
@property (nonatomic, copy  ) NSString *playUrl;
/** 封面图 */
@property (nonatomic, copy  ) NSString *coverForFeed;
/** 视频分辨率的数组 */
@property (nonatomic, strong) NSMutableArray *playInfo;

@end
