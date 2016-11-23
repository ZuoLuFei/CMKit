//
//  CMDBOperationQueryCell.h
//  CMKit
//
//  Created by HC on 16/11/23.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMDBUserModel;

@interface CMDBOperationQueryCell : UITableViewCell

@property (nonatomic, strong) CMDBUserModel *userModel;

+ (instancetype)createTableViewCellWith:(UITableView *)tableView;

@end
