//
//  NSBundle+UTImagePicker.m
//  UTImagePickerController
//
//  Created by yons on 16/08/18.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "NSBundle+UTImagePicker.h"
#import "UTImagePickerController.h"

@implementation NSBundle (UTImagePicker)

+ (instancetype)ut_imagePickerBundle {
    static NSBundle *UTBundle = nil;
    if (UTBundle == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"UTImagePickerController" ofType:@"bundle"];
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:@"UTImagePickerController" ofType:@"bundle" inDirectory:@"Frameworks/UTImagePickerController.framework/"];
        }
        UTBundle = [NSBundle bundleWithPath:path];
    }
    return UTBundle;
}

+ (NSString *)ut_localizedStringForKey:(NSString *)key {
    return [self ut_localizedStringForKey:key value:@""];
}

+ (NSString *)ut_localizedStringForKey:(NSString *)key value:(NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        } else {
            language = @"en";
        }
        bundle = [NSBundle bundleWithPath:[[NSBundle ut_imagePickerBundle] pathForResource:language ofType:@"lproj"]];
    }
    NSString *value1 = [bundle localizedStringForKey:key value:value table:nil];
    return value1;
}
@end
