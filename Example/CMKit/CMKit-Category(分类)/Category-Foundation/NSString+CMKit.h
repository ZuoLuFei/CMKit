//
//  NSString+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/25.
//  Copyright © 2016年 HC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//@import UIKit;

/**
 *  此分类增加了一些关于NSString的有用方法
 */
@interface NSString (CMKit)

#pragma mark - 判断字符串非空
/**
 判断字符串是否为空
 
 @return YES非空，NO空
 */
- (BOOL)isNotBlank;

/**
 判断字符串是否为空
 
 @param string 判断的字符串
 
 @return YES非空，NO空
 */
+ (BOOL)isNotBlankString:(NSString * _Nullable)string;

/**
 判断字符串是否为空
 
 @return YES空，NO非空
 */
- (BOOL)isBlank;

/**
 判断字符串是否为空
 
 @param string 判断的字符串
 
 @return YES空，NO非空
 */
+ (BOOL)isBlankString:(NSString * _Nullable)string;



#pragma mark - 判断字符串宽高
/**
 *  根据提供的最大width和font计算文本占用的高
 *
 *  @param width 文本的最大宽
 *  @param font  文本字体大小
 *
 *  @return 返回计算出的文本占用高
 */
- (CGFloat)heightForWidth:(float)width
                  andFont:(UIFont * _Nonnull)font;

/**
 *  计算文本占用的尺寸
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的尺寸
 */
- (CGSize)sizeWithFont:(UIFont * _Nonnull)font maxSize:(CGSize)maxSize;


#pragma mark - 字符串各种正则校验
/**
 * 正则有效的电话号码
 */
- (BOOL) isValidMobileNumber;

/**
 * 正则有效的真实姓名
 */
- (BOOL) isValidRealName;
/**
 * 正则是否只有中文
 */
- (BOOL) isOnlyChinese;
/**
 * 正则有效的验证码(根据项目的验证码位数进行修改)
 */
- (BOOL) isValidVerifyCode;
/**
 * 正则有效的银行卡号
 */
- (BOOL) isValidBankCardNumber;
/**
 * 正则有效的邮箱
 */
- (BOOL) isValidEmail;
/**
 * 正则有效的字母数字密码
 */
- (BOOL) isValidAlphaNumberPassword;
/**
 * 正则检测有效身份证(15位)
 */
- (BOOL) isValidIdentifyFifteen;
/**
 * 正则检测有效身份证(18位)
 */
- (BOOL) isValidIdentifyEighteen;
/**
 * 正则是否为纯数字
 */
- (BOOL) isOnlyNumber;

/**
 *  正则检查自身是否是邮件地址
 *
 *  @return YES是，NO不是
 */
- (BOOL)isEmail;

/**
 *  正则检查给出的字符串是否是邮件地址
 *
 *  @param email 被检查的字符串
 *
 *  @return YES是，NO不是
 */
+ (BOOL)isEmail:(NSString * _Nonnull)email;

/**
 * 电话号码中间4位****显示
 */
+ (NSString * _Nonnull) getSecrectStringWithPhoneNumber:(NSString * _Nonnull)phoneNum;

/**
 * 银行卡号中间8位**** ****显示
 */
+ (NSString * _Nonnull) getSecrectStringWithAccountNo:(NSString * _Nonnull)accountNo;

#pragma mark - 字符串与时间戳之间的相互转换处理
/**
 * 通过时间戳计算时间差（几小时前、几天前）
 */
+ (NSString * _Nonnull) compareCurrentTime:(NSTimeInterval) compareDate;
/**
 * 通过时间戳得出显示时间
 */
+ (NSString * _Nonnull) getDateStringWithTimestamp:(NSTimeInterval)timestamp;
/**
 * 通过时间戳和格式显示时间
 * 参数1: 时间戳
 * 参数2: 时间格式 例:@"yyyy-MM-dd HH:mm:ss",@"yyyy/MM/dd",@"yyyy-MM-dd HH:mm",@"MM-dd HH:mm"
 */
+ (NSString * _Nonnull) getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString *_Nonnull)formatter;


#pragma mark - 字符串的各种处理

/**
 *  在指定的字符串中按照开始字符和结束字符获取子字符串
 *  如:"This is a test" with start char 'h' and end char 't' will return "is is a "
 *
 *  @param string 被搜索的字符串
 *  @param start  开始字符
 *  @param end    结束字符
 *
 *  @return 返回子字符串
 */
+ (NSString * _Nonnull)searchInString:(NSString *_Nonnull)string
                            charStart:(char)start
                              charEnd:(char)end;

/**
 *  在字符串本身中按照开始字符和结束字符获取子字符串
 *  如: "This is a test" with start char 'h' and end char 't' will return "is is a "
 *
 *  @param start  开始字符
 *  @param end    结束字符
 *
 *  @return 返回子字符串
 */
- (NSString * _Nonnull)searchCharStart:(char)start
                               charEnd:(char)end;

/**
 *  返回给出字符的索引值(注:返回第一次被找到字符的索引值)
 *
 *  @param character 被搜索的字符
 *
 *  @return 返回被搜索字符的索引值，如果找不到返回-1
 */
- (NSInteger)indexOfCharacter:(char)character;

/**
 *  截取一段从指定字符至末尾的子字符串(注：以找到的第一个字符索引位置开始)
 *
 *  @param character 指定字符
 *
 *  @return 返回从指定字符至末尾的子字符串
 */
- (NSString * _Nonnull)substringFromCharacter:(char)character;

/**
 *  截取一段从头至指定字符的子字符串(注：以找到的第一个字符索引位置开始)
 *
 *  @param character 指定字符
 *
 *  @return 返回从头至指定字符的子字符串
 */
- (NSString * _Nonnull)substringToCharacter:(char)character;

/**
 *  在高敏感度下检查自身是否包含指定的子字符串(区分大小写)
 *
 *  @param substring 被检查的子字符串
 *
 *  @return YES包含，NO不包含
 */
- (BOOL)hasString:(NSString * _Nonnull)substring;

/**
 *  在指定敏感度下检查自身是否包含自定的子字符串
 *
 *  @param substring     被检查的子字符串
 *  @param caseSensitive YES高敏感度(区分大小写),NO低敏感度(不区分大小写)
 *
 *  @return YES包含，NO不包含
 */
- (BOOL)hasString:(NSString * _Nonnull)substring
    caseSensitive:(BOOL)caseSensitive;



/**
 *  对指定的字符串进行Base64编码
 *
 *  @param string 被编码的字符串
 *
 *  @return 返回编码后的字符串
 */
+ (NSString * _Nonnull)encodeToBase64:(NSString * _Nonnull)string;

/**
 *  对自身进行Base64编码
 *
 *  @return 返回编码后的字符串
 */
- (NSString * _Nonnull)encodeToBase64;

/**
 *  对指定的字符串进行Base64解码
 *
 *  @param string 被解码的字符串
 *
 *  @return 返回解码后的字符串
 */
+ (NSString * _Nonnull)decodeBase64:(NSString * _Nonnull)string;

/**
 *  对自身进行Base64解码
 *
 *  @return 返回解码后的字符串
 */
- (NSString * _Nonnull)decodeBase64;

/**
 *  将指定的字符串转换为data数据
 *
 *  @param string 需要转换的字符串
 *
 *  @return 返回转换得到的data数据
 */
+ (NSData * _Nonnull)convertToNSData:(NSString * _Nonnull)string;

/**
 *  转换自身为data数据
 *
 *  @return 返回转换得到的data数据
 */
- (NSData * _Nonnull)convertToNSData;

/**
 *  将指定字符串转换为句首大写的标准语法
 *  如: "This is a Test" will return "This is a test" and "this is a test" will return "This is a test"
 *
 *  @return 返回句首大写的字符串
 */
- (NSString * _Nonnull)sentenceCapitalizedString;

/**
 *  将时间戳转换为人类易于识别的字符串
 *
 *  @return 返回人类易于识别的字符串
 */
- (NSString * _Nonnull)dateFromTimestamp;

/**
 *  创建一个UUID字符串
 *
 *  @return 返回被创建的UUID字符串
 */
+ (NSString * _Nonnull)generateUUID;

/**
 *  判断此UUID是否可用
 *
 *  @return YES可用，NO不可用
 */
- (BOOL)isUUID;

/**
 *  判断此UUID对APNS是否可用
 *
 *  @return YES可用，NO不可用
 */
- (BOOL)isUUIDForAPNS;

/**
 *  将自身转换为一个对APNS可用的UUID(No "<>" or "-" or spaces)
 *
 *  @return 返回对APNS可用的UUID(No "<>" or "-" or spaces)
 */
- (NSString * _Nonnull)convertToAPNSUUID;


@end
