//
//  NSFileManager+CMKit.h
//  CMKit-HCCategory
//
//  Created by HC on 16/10/27.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  目录类型枚举
 */
typedef NS_ENUM(NSInteger, DirectoryType) {
    /**
     *  主bundle目录
     */
    DirectoryTypeMainBundle = 0,
    /**
     *  Library目录
     */
    DirectoryTypeLibrary,
    /**
     *  Documents目录
     */
    DirectoryTypeDocuments,
    /**
     *  Cache目录
     */
    DirectoryTypeCache
};


/**
 *  此分类增加了一些关于NSFileManager的有用方法
 */
@interface NSFileManager (CMKit)

/**
 *  读取一份文件以字符串输出
 *
 *  @param file 文件名字
 *  @param type 文件类型
 *
 *  @return 返回文件字符串内容
 */
+ (NSString * _Nullable)readTextFile:(NSString * _Nonnull)file
                              ofType:(NSString * _Nonnull)type;

/**
 *  将指定的数组保存到指定目录下的指定文件中
 *
 *  @param path     PLIST目录
 *  @param fileName PLIST文件名
 *  @param array    需要保存的数组
 *
 *  @return YSE操作成功，NO失败
 */
+ (BOOL)saveArrayToPath:(DirectoryType)path
           withFilename:(NSString * _Nonnull)fileName
                  array:(NSArray * _Nonnull)array;

/**
 *  从指定的目录下指定文件，返回数组
 *
 *  @param path     PLIST目录
 *  @param fileName PLIST文件名
 *
 *  @return 返回加载出的数组
 */
+ (NSArray * _Nullable)loadArrayFromPath:(DirectoryType)path
                            withFilename:(NSString * _Nonnull)fileName;

/**
 *  获取主Bundle目录下的指定文件地址
 *
 *  @param fileName 文件名
 *
 *  @return 返回字符串地址
 */
+ (NSString * _Nonnull)getBundlePathForFile:(NSString * _Nonnull)fileName;

/**
 *  获取Documents目录下的指定文件地址
 *
 *  @param fileName 文件名
 *
 *  @return 返回字符串目录地址
 */
+ (NSString * _Nonnull)getDocumentsDirectoryForFile:(NSString * _Nonnull)fileName;

/**
 *  获取Library目录下的指定文件地址
 *
 *  @param fileName 文件名
 *
 *  @return 返回字符串目录地址
 */
+ (NSString * _Nonnull)getLibraryDirectoryForFile:(NSString * _Nonnull)fileName;

/**
 *  获取Cache目录下的指定文件地址
 *
 *  @param fileName 文件名
 *
 *  @return 返回字符串目录地址
 */
+ (NSString * _Nonnull)getCacheDirectoryForFile:(NSString * _Nonnull)fileName;

/**
 *  返回指定目录下指定文件的的文件大小
 *
 *  @param fileName  文件名
 *  @param directory 文件目录
 *
 *  @return 返回文件大小
 */
+ (NSNumber * _Nullable)fileSize:(NSString * _Nonnull)fileName
                   fromDirectory:(DirectoryType)directory;

/**
 *  删除指定目录下的指定文件
 *
 *  @param fileName 需要被删除文件的文件名
 *  @param directory   文件目录
 *
 *  @return YES操作成功，NO失败
 */
+ (BOOL)deleteFile:(NSString * _Nonnull)fileName
     fromDirectory:(DirectoryType)directory;

/**
 *  将文件从一个目录移动到另一个目录
 *
 *  @param fileName    被移动的文件
 *  @param origin      文件的原目录
 *  @param destination 文件的目标目录
 *
 *  @return YES操作成功，NO失败
 */
+ (BOOL)moveLocalFile:(NSString * _Nonnull)fileName
        fromDirectory:(DirectoryType)origin
          toDirectory:(DirectoryType)destination;

/**
 *  将文件从一个目录移动到另一个目录
 *
 *  @param fileName    被移动的文件
 *  @param origin      文件的原目录
 *  @param destination 文件的目标目录
 *  @param folderName  目标目录的文件夹名称，如果文件夹不存在将会自动创建
 *
 *  @return YES操作成功，NO失败
 */
+ (BOOL)moveLocalFile:(NSString * _Nonnull)fileName
        fromDirectory:(DirectoryType)origin
          toDirectory:(DirectoryType)destination
       withFolderName:(NSString * _Nullable)folderName;

/**
 *  复制一个文件到另一个目录
 *
 *  @param origin      原始地址
 *  @param destination 目标地址
 *
 *  @return YES操作成功，NO失败
 */
+ (BOOL)duplicateFileAtPath:(NSString * _Nonnull)origin
                  toNewPath:(NSString * _Nonnull)destination;

/**
 *  对指定目录下的指定文件进行重命名
 *
 *  @param origin  目录类型
 *  @param path    子目录地址
 *  @param oldName 原文件名
 *  @param newName 新文件名
 *
 *  @return YES操作成功，NO失败
 */
+ (BOOL)renameFileFromDirectory:(DirectoryType)origin
                         atPath:(NSString * _Nonnull)path
                    withOldName:(NSString * _Nonnull)oldName
                     andNewName:(NSString * _Nonnull)newName;

/**
 *  根据给出的key获取APP的偏好设置
 *
 *  @param objKey 键值
 *
 *  @return 通过键值获取的APP偏好设置对象
 */
+ (id _Nullable)getAppSettingsForObjectWithKey:(NSString * _Nonnull)objKey;

/**
 *  设置APP偏好设置通过key和object值，偏好设置文件被保存在Library目录
 *
 *  @param value  被设置的对象值
 *  @param objKey 被设置对象的key值，
 *
 *  @return YES操作成功，NO失败
 */
+ (BOOL)setAppSettingsForObject:(id _Nonnull)value
                         forKey:(NSString * _Nonnull)objKey;

/**
 *  通过指定的key获取设置文件中的值
 *
 *  @param settings 设置文件名
 *  @param objKey   键值
 *
 *  @return 返回key对应的对象值
 */
+ (id _Nullable)getSettings:(NSString * _Nonnull)settings
               objectForKey:(NSString * _Nonnull)objKey;

/**
 *  将指定的key和value添加到指定的设置文件中，设置文件将保存在Library目录中
 *
 *  @param settings 设置文件名
 *  @param value    添加的对象
 *  @param objKey   添加对象对应的key值
 *
 *  @return YES操作成功，NO失败
 */
+ (BOOL)setSettings:(NSString * _Nonnull)settings
             object:(id _Nonnull)value
             forKey:(NSString * _Nonnull)objKey;


@end
