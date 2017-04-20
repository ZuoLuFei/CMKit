//
//  CMThreeLevelCityPickerView.h
//  CMKit
//
//  Created by 黄超 on 2017/4/20.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMThreeLevelCityPickerView : UIView

/** 选中的城市信息 */
typedef void(^CityMessage)(NSString *proviceStr,NSString *cityStr,NSString *distr);


/** ToolBar标题 */
@property (nonatomic, copy) NSString *toolBarTitle;

/** 显示 */
-(void)showCityPickerView:(CityMessage) cityMessage;


@end
