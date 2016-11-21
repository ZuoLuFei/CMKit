//
//  CMNetworkReachablityManager.m
//  CMKit
//
//  Created by HC on 16/11/21.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMNetworkReachablityManager.h"
#import "AFNetworkReachabilityManager.h"

typedef NS_ENUM(NSInteger, CMNetworkReachabilityStatus) {
    CMNetworkReachabilityStatusUnknown          = -1,
    CMNetworkReachabilityStatusNotReachable     = 0,
    CMNetworkReachabilityStatusReachableViaWWAN = 1,
    CMFNetworkReachabilityStatusReachableViaWiFi = 2,
};


@implementation CMNetworkReachablityManager


- (void)test{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}

@end
