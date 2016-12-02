//
//  DWiPhoneType.h
//  DWUNlock
//
//  Created by dwang_sui on 2016/10/23.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 获取设备型号 */
#import <sys/utsname.h>

@interface DWiPhoneType : NSObject

/** 获取设备型号 */
+ (NSString *)dw_iPhoneType;

@end
