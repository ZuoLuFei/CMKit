//
//  CMPlayerCell.h
//  CMKit
//
//  Created by HC on 17/2/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMVideoModel.h"


typedef void(^PlayBtnCallBackBlock)(UIButton *);

@interface CMPlayerCell : UITableViewCell

/** model */
@property (nonatomic, strong) CMVideoModel                  *model;

/** 播放按钮block */
@property (nonatomic, copy  ) PlayBtnCallBackBlock          playBlock;

@property (weak, nonatomic  ) IBOutlet UIImageView          *picView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
