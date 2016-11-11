//
//  NSBundle+UTImagePicker.h
//  UTImagePickerController
//
//  Created by yons on 16/08/18.
//  Copyright © 2016年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (UTImagePicker)

+ (NSString *)ut_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)ut_localizedStringForKey:(NSString *)key;

@end

