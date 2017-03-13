//
//  
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//


/*
 作用--> 全局宏使用
 使用场景--> 对象宏定义
 */


/**
 *  对象宏定义
 */
#ifndef CMObjectMacroDefinition_h
#define CMObjectMacroDefinition_h

/*-----------------------------分割线-------------------------------*/
#pragma mark - 各环境IP/POST控制
//登陆账号:dyf12345  123456
///** 服务器地址（测试sit环境） */
#define kTSP_IP @"163.177.14.40"
#define kTSP_POST @"8081"
/** 下载头像POST */
#define kTSP_AVATAR_POST @"8088"

/*-----------------------------分割线-------------------------------*/

#pragma mark - 各种常量类宏定义（如以下例子）
/** 支付宝partner */
#define kALiPayPartner @"2088901053266358" 

/*-----------------------------分割线-------------------------------*/
#pragma mark - 通知Key
/** 购物车pop通知 */
#define kShopCartPopNotification @"shopCartPopNotification"

/*-----------------------------分割线-------------------------------*/
#pragma mark - 正则判断

/** 密码规则字符串 */
#define kPassWordRulesString @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ·-=[]\\;\'/.,~!@#%^$&()+"


#endif
