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
        [MBProgressHUD hideHUD];
        
        NSLog(@"网络请求JSON-->%@",JSON);
        
        if (block) {
            block(JSON , nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        
        [MBProgressHUD hideHUD];
        NSLog(@"网络请求error-->%@",error);
        if (block) {
            [self monitorNetworkReachabilityithBlock:block error:error];
        }
    }];
}

+ (NSURLSessionDataTask * _Nonnull)POST:(nullable NSString *)URLString parameters:(nullable id)parameters withBlock:(HttpClientBlock)block{
    
    return [CMHttpClientTool POST:URLString parameters:parameters progress:nil withBlock:block];
}


+ (NSURLSessionDataTask * _Nonnull)POST:(nullable NSString *)URLString parameters:(nullable id)parameters progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress withBlock:(HttpClientBlock)block{

    return [[CMHttpClientTool sharedClient] GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * __unused task, id JSON) {
        [MBProgressHUD hideHUD];
        
        NSLog(@"网络请求JSON-->%@",JSON);
        
        if (block) {
            block(JSON , nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        
        [MBProgressHUD hideHUD];
        NSLog(@"网络请求error-->%@",error);
        
        if (block) {
            
            //检测是否网络异常
            [self monitorNetworkReachabilityithBlock:block error:error];
            block(nil, error);
        }
    }];
}


#pragma mark - 网络监测
// 网络监测
+ (void)monitorNetworkReachabilityithBlock:(HttpClientBlock)block error:(NSError *)error{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            
            //此处提示界面，使用时请根据项目自定义修改
            [MBProgressHUD showError:@"网络异常,请稍后再试"];
        }
        
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}


@end
