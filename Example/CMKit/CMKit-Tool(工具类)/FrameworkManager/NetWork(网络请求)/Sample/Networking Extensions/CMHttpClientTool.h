//
//  CMHttpClientTool.h
//  CMKit
//
//  Created by HC on 16/11/3.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


//typedef NS_ENUM(NSInteger,CMHttpClientReachabilityStatus) {
//    CMHttpClientReachabilityStatusAvailable  = 0, //网络正常(WWAN或wifi网络)
//    CMHttpClientReachabilityStatusUnavailable = 1  //网络异常(未知网络或没有接受到网络状态)
//};

//typedef void(^ _Nonnull HttpClientBlock)(id _Nullable JSON, NSError * _Nullable error,CMHttpClientReachabilityStatus status);


typedef void(^ _Nonnull HttpClientBlock)(id _Nullable JSON, NSError * _Nullable error);


/**
 网络请求基础工具类
 */
@interface CMHttpClientTool : AFHTTPSessionManager


/**
 GET请求

 @param URLString 请求URL
 @param block     回调

 @return 返回此次任务，便于暂停、取消等
 */
+ (NSURLSessionDataTask * _Nonnull)GET:(nullable NSString *)URLString withBlock:(HttpClientBlock)block;


/**
 GET请求

 @param URLString        请求URL
 @param parameters       请求参数
 @param downloadProgress 下载进度
 @param block            回调
 
 @return 返回此次任务，便于暂停、取消等
 */
+ (NSURLSessionDataTask * _Nonnull)GET:(nullable NSString *)URLString parameters:(nullable id)parameters progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress withBlock:(HttpClientBlock)block;

/**
 POST请求
 
 @param URLString        请求URL
 @param parameters       请求参数
 @param block            回调
 
 @return 返回此次任务，便于暂停、取消等
 */
+ (NSURLSessionDataTask * _Nonnull)POST:(nullable NSString *)URLString parameters:(nullable id)parameters withBlock:(HttpClientBlock)block;

/**
 POST请求
 
 @param URLString        请求URL
 @param parameters       请求参数
 @param downloadProgress 下载进度
 @param block            回调
 
 @return 返回此次任务，便于暂停、取消等
 */
+ (NSURLSessionDataTask * _Nonnull)POST:(nullable NSString *)URLString parameters:(nullable id)parameters progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress withBlock:(HttpClientBlock)block;



@end
