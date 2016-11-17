//
//  CMHttpClientTool.m
//  CMKit
//
//  Created by HC on 16/11/3.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMHttpClientTool.h"

static NSString * const CMHttpClientToolBaseURLString = @"https://api.app.net/";

@implementation CMHttpClientTool


+ (instancetype)sharedClient {
    static CMHttpClientTool *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CMHttpClientTool alloc] initWithBaseURL:[NSURL URLWithString:CMHttpClientToolBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        [_sharedClient setResponseSerializer:[AFJSONResponseSerializer serializer]];
        
        //        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        //        [requestSerializer setValue:@"application/json" forKey:@"Content-Type"];
        //        [_sharedClient setRequestSerializer:requestSerializer];
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        requestSerializer.timeoutInterval = 20;
        [_sharedClient setRequestSerializer:requestSerializer];
    
    });
    
    return _sharedClient;
}



+ (NSURLSessionDataTask * _Nonnull)GET:(nullable NSString *)URLString withBlock:(HttpClientBlock)block{
    
    return [CMHttpClientTool GET:URLString parameters:nil progress:nil withBlock:block];
}

+ (NSURLSessionDataTask * _Nonnull)GET:(nullable NSString *)URLString parameters:(nullable id)parameters progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress withBlock:(HttpClientBlock)block;{
    return [[CMHttpClientTool sharedClient] GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * __unused task, id JSON) {
        if (block) {
            block(JSON , nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

+ (NSURLSessionDataTask * _Nonnull)POST:(nullable NSString *)URLString parameters:(nullable id)parameters withBlock:(HttpClientBlock)block{
    
    return [CMHttpClientTool POST:URLString parameters:parameters progress:nil withBlock:block];
}


+ (NSURLSessionDataTask * _Nonnull)POST:(nullable NSString *)URLString parameters:(nullable id)parameters progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress withBlock:(HttpClientBlock)block{

    return [[CMHttpClientTool sharedClient] GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * __unused task, id JSON) {
        if (block) {
            block(JSON , nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}


//+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
//    return [[AFAppDotNetAPIClient sharedClient] GET:@"stream/0/posts/stream/global" parameters:nil progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
//        NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
//        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
//        for (NSDictionary *attributes in postsFromResponse) {
//            Post *post = [[Post alloc] initWithAttributes:attributes];
//            [mutablePosts addObject:post];
//        }
//        
//        if (block) {
//            block([NSArray arrayWithArray:mutablePosts], nil);
//        }
//    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
//        if (block) {
//            block([NSArray array], error);
//        }
//    }];
//}

@end
