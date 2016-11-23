//
//  CMDBUserModel.m
//  CMKit
//
//  Created by HC on 16/11/23.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMDBUserModel.h"

@implementation CMDBUserModel

#pragma mark - override method

+(NSArray *)transients
{
    return [NSArray arrayWithObjects:@"field1",@"field2",nil];
}



@end
