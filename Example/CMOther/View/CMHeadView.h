//
//  CMHeadView.h
//  CMKit
//
//  Created by HC on 16/11/17.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMHeadView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, assign) CGFloat hight;


/** 创建HeadView */
+ (instancetype)headView;


@end
