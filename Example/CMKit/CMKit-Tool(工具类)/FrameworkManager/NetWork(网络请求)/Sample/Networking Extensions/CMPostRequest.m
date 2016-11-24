//
//  CMPostRequest.m
//  CMKit
//
//  Created by HC on 16/11/3.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMPostRequest.h"


@implementation CMPostRequest

+ (NSURLSessionDataTask * _Nonnull)globalTimelinePostsWithBlock:(void (^ _Nonnull)(NSArray * _Nullable postsArray))postsBlock{
    
    return [CMHttpClientTool GET:@"stream/0/posts/stream/global" withBlock:^(id  _Nullable JSON, NSError * _Nullable error) {
        
        //数据解析
        if (JSON) {
            NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
            NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
            for (NSDictionary *attributes in postsFromResponse) {
                Post *post = [[Post alloc] initWithAttributes:attributes];
                [mutablePosts addObject:post];
            }
            
            if (postsBlock) {
                postsBlock(mutablePosts);
            }
        }
    }];
}



@end
