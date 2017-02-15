//
//  CMVideoResolution.h
//  CMKit
//
//  Created by HC on 17/2/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMVideoResolution : NSObject

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, copy  ) NSString  *name;
@property (nonatomic, copy  ) NSString  *type;
@property (nonatomic, copy  ) NSString  *url;

@end
