//
//  DWGesturesLock.h
//  DWUNlock
//
//  Created by dwang_sui on 2016/10/28.
//  Copyright © 2016年 dwang. All rights reserved.
//
/*****************************Github:https://github.com/dwanghello/DWUNlock******************************/
/*************Code Data:http://www.codedata.cn/cdetail/Objective-C/Demo/1478099529339492********/
/*****************************邮箱:dwang.hello@outlook.com***********************************************/
/*****************************QQ:739814184**************************************************************/
/*****************************QQ交流群:577506623*********************************************************/
/*****************************codedata官方群:157937068***************************************************/

#import <UIKit/UIKit.h>

@interface DWGesturesLock : UIView
/**************************Block************************/

/**
 操作后的回调

 @param success 验证结果
 @param password 当前选中的手势密码
 @param userPassword 设置的手势密码
 */
typedef void(^Password)(BOOL success, NSString *password, NSString *userPassword);
/** 密码Block */
@property(nonatomic) Password password;
/*********************************************************************************/

/***********************************视图背景接口************************************/

/** 手势解锁背景(默认显示类似支付宝背景) */
@property (strong, nonatomic) UIImage           *bgImage;
/*********************************************************************************/

/************************************视图连接点接口*********************************/

/** 连接点默认图片 */
@property(strong, nonatomic) UIImage            *gesturesNormal;

/** 连接点被选中时的图片 */
@property(strong, nonatomic) UIImage            *gesturesSelected;

/** 密码正确时的图片 */
@property(strong, nonatomic) UIImage            *gesturesSuccess;

/** 密码错误时的图片 */
@property(strong, nonatomic) UIImage            *gesturesError;
/*********************************************************************************/

/************************************视图连接线接口*********************************/

/** 连接线颜色(默认白色) */
@property (strong, nonatomic) UIColor           *lineColor;

/** 连接线宽度(默认10/不建议修改) */
@property (assign, nonatomic) CGFloat            lineWidth;

/** 手势连接点尺寸(默认74/不建议修改) */
@property(assign, nonatomic) CGFloat             sizeW_H;

/** 连接线停留时间(默认2.0秒) */
@property(assign, nonatomic) double              lineTimer;
/*********************************************************************************/



/************************************操作数据接口**********************************/

/** 密码最小长度(默认3) */
@property(assign, nonatomic) NSUInteger          passwordLength;

/** 连续输入密码的次数 */
@property(assign, nonatomic) NSInteger           inputCount;


/** 画线完成后的截图 */
@property(strong, nonatomic) UIImage            *passwordImage;

/** 连接完成后的回调 */
- (void)dw_passwordSuccess:(Password)password;

/** 删除手势密码 */
+ (void)dw_removePassword;
/*********************************************************************************/



/************************************存储在沙盒中的原始密码**********************************/

/**  获取存储在沙盒中的原始密码 */
+ (NSString *)obtainUserPassword;

/*********************************************************************************/


@end
