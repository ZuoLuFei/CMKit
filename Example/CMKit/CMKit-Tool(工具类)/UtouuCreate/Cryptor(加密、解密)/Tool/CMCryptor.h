//
//  CMCryptor.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/28.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *  此类增加了一些关于数据加密/解密的有用方法
 *  所有的方法都是私有
 */
@interface CMCryptor : NSObject

/**
 *  创建一个MD5字符串
 *
 *  @param string 被转换的字符串
 *
 *  @return 返回MD5字符串
 */
+ (NSString * _Nullable)MD5:(NSString * _Nonnull)string;

/**
 *  创建一个SHA1字符串
 *
 *  @param string 被转换的字符串
 *
 *  @return 返回SHA1字符串
 */
+ (NSString * _Nullable)SHA1:(NSString * _Nonnull)string;

/**
 *  创建一个SHA256字符串
 *
 *  @param string 被转换的字符串
 *
 *  @return 返回SHA256字符串
 */
+ (NSString * _Nullable)SHA256:(NSString * _Nonnull)string;


/**
 *  创建一个SHA512字符串
 *
 *  @param string 被转换的字符串
 *
 *  @return 返回SHA512字符串
 */
+ (NSString * _Nullable)SHA512:(NSString * _Nonnull)string;

/**
 *  用指定的key通过AES128方法加密data数据
 *
 *  @param data 被加密的data数据
 *  @param key  加密使用的key
 *
 *  @return 返回被加密后的data数据
 */
+ (NSData * _Nullable)AES128EncryptData:(NSData * _Nonnull)data
                                withKey:(NSString * _Nonnull)key;

/**
 *  用指定的key通过AES128方法解密data数据
 *
 *  @param data 被解密的data数据
 *  @param key  解密使用的key
 *
 *  @return 返回被解密后的data数据
 */
+ (NSData * _Nullable)AES128DecryptData:(NSData * _Nonnull)data
                                withKey:(NSString * _Nonnull)key;


/**
 *  用指定的key通过AES256方法加密data数据
 *
 *  @param data 被加密的data数据
 *  @param key  加密使用的key
 *
 *  @return 返回被加密后的data数据
 */
+ (NSData * _Nullable)AES256EncryptData:(NSData * _Nonnull)data
                                withKey:(NSString * _Nonnull)key;

/**
 *  用指定的key通过AES256方法解密data数据
 *
 *  @param data 被解密的data数据
 *  @param key  解密使用的key
 *
 *  @return 返回被解密后的data数据
 */
+ (NSData * _Nullable)AES256DecryptData:(NSData * _Nonnull)data
                                withKey:(NSString * _Nonnull)key;


/**
 *  用指定的key通过AES128方法加密string数据
 *
 *  @param string 被加密的data数据
 *  @param key  加密使用的key
 *
 *  @return 返回被加密后的data数据
 */
+ (NSData * _Nullable)AES128EncryptString:(NSString * _Nonnull)string
                                  withKey:(NSString * _Nonnull)key;

/**
 *  用指定的key通过AES128方法解密string数据
 *
 *  @param string 被加密的data数据
 *  @param key  加密使用的key
 *
 *  @return 返回被加密后的data数据
 */
+ (NSData * _Nullable)AES128DecryptString:(NSString * _Nonnull)string
                                  withKey:(NSString * _Nonnull)key;


/**
 *  用指定的key通过AES256方法加密string数据
 *
 *  @param string 被加密的data数据
 *  @param key  加密使用的key
 *
 *  @return 返回被加密后的data数据
 */
+ (NSData * _Nullable)AES256EncryptString:(NSString * _Nonnull)string
                                  withKey:(NSString * _Nonnull)key;


/**
 *  用指定的key通过AES256方法解密string数据
 *
 *  @param string 被加密的data数据
 *  @param key  加密使用的key
 *
 *  @return 返回被加密后的data数据
 */
+ (NSData * _Nullable)AES256DecryptString:(NSString * _Nonnull)string
                                  withKey:(NSString * _Nonnull)key;


@end
