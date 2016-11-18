//
//  CMFontInfomation.m
//  CMKit
//
//  Created by HC on 16/11/17.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMFontInfomation.h"

static NSMutableDictionary *_systemFontDictionary = nil; // 系统字体信息

@implementation CMFontInfomation

+ (void)initialize {
    
    if (self == [CMFontInfomation class]) {
        
        _systemFontDictionary = [[NSMutableDictionary alloc] init];
        
        // 获取系统字体族
        [CMFontInfomation getSystemFontList];
    }
}

+ (void)getSystemFontList {
    
    NSArray *familyNames = [UIFont familyNames];
    
    for( NSString *familyName in familyNames) {
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        [_systemFontDictionary setObject:fontNames forKey:familyName];
    }
}

+ (NSDictionary *)systomFontNameList {
    
    return [NSDictionary dictionaryWithDictionary:_systemFontDictionary];
}


@end
