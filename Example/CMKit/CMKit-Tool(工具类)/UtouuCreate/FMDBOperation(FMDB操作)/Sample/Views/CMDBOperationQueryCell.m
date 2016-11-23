//
//  CMDBOperationQueryCell.m
//  CMKit
//
//  Created by HC on 16/11/23.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMDBOperationQueryCell.h"
#import "CMDBUserModel.h"

@interface CMDBOperationQueryCell ()
@property (weak, nonatomic) IBOutlet UILabel *pkLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@end

@implementation CMDBOperationQueryCell


#pragma mark - set方法
- (void)setUserModel:(CMDBUserModel *)userModel {
    _userModel = userModel;
    
    self.pkLabel.text = [NSString stringWithFormat:@"%d",userModel.pk];
    self.nameLabel.text = userModel.name;
    self.sexLabel.text = userModel.sex;
    self.ageLabel.text = [NSString stringWithFormat:@"%d",userModel.age];
    self.headImageView.image = [UIImage imageWithData:userModel.imageData];
}

#pragma mark - 工厂方法
+ (instancetype)createTableViewCellWith:(UITableView *)tableView {
    
    static NSString *ID = @"CMDBOperationQuerySampleControllerTableView";
    CMDBOperationQueryCell *cell = (CMDBOperationQueryCell *)[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell= (CMDBOperationQueryCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"CMDBOperationQueryCell" owner:self options:nil]  lastObject];
    }
    
    return cell;
    
}


@end
