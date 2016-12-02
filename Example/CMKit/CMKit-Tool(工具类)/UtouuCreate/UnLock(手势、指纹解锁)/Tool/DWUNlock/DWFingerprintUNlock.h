//
//  DWFingerprintUNlock.h
//  DWUNlock
//
//  Created by dwang_sui on 2016/10/23.
//  Copyright © 2016年 dwang. All rights reserved.
//
/*****************************Github:https://github.com/dwanghello/DWUNlock******************************/
/*************Code Data:http://www.codedata.cn/cdetail/Objective-C/Demo/1478099529339492********/
/*****************************邮箱:dwang.hello@outlook.com***********************************************/
/*****************************QQ:739814184**************************************************************/
/*****************************QQ交流群:577506623*********************************************************/
/*****************************codedata官方群:157937068***************************************************/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/** 指纹解锁 */
#import <LocalAuthentication/LocalAuthentication.h>
/** 设备型号 */
#import "DWiPhoneType.h"

@interface DWFingerprintUNlock : NSObject

/**
 指纹解锁

 @param promptMsg  提示文本
 @param cancelMsg  取消按钮显示内容(此参数只有iOS10以上才能生效)
 @param otherMsg   密码登录按钮显示内容(可传nil/默认*密码登录*)
 @param enabled    默认为NO点击密码使用系统解锁/YES时，自己操作点击密码登录
 @param otherClick 点击密码登录(如果enabled为NO,9.0以上系统直接调系统解锁，不会走此方法/已回主线程)
 @param success    指纹验证成功(已回主线程)
 @param error      指纹验证失败(英文)
 @param errorMsg   指纹验证失败(中文)
 */
+ (void)dw_initWithFingerprintUNlockPromptMsg:(NSString *)promptMsg cancelMsg:(NSString *)cancelMsg otherMsg:(NSString *)otherMsg enabled:(BOOL)enabled otherClick:(void(^)(NSString *otherClick))otherClick  success:(void(^)(BOOL success))success error:(void(^)(NSError *error))error errorMsg:(void(^)(NSString *errorMsg))errorMsg;

@end
