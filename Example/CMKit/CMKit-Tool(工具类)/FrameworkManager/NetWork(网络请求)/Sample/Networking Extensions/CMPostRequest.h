//
//  CMPostRequest.h
//  CMKit
//
//  Created by HC on 16/11/3.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMHttpClientTool.h"
#import "Post.h"

/**
 业务封装工具类
 */
@interface CMPostRequest : NSObject

/**
 获取全球新闻帖子请求工具

 @param postsBlock 资源数据返回

 @return 返回此次任务，便于暂停、取消等
 */
+ (NSURLSessionDataTask * _Nonnull)globalTimelinePostsWithBlock:(void (^ _Nonnull)(NSArray * _Nullable postsArray))postsBlock;


@end
