//
//  CMPlayerCell.m
//  CMKit
//
//  Created by HC on 17/2/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMPlayerCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"


@interface CMPlayerCell ()

@property (weak, nonatomic  ) IBOutlet UIImageView          *avatarImageView;

@property (weak, nonatomic  ) IBOutlet UILabel              *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
- (IBAction)playBtnClick:(UIButton *)sender;


@end

@implementation CMPlayerCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    [self layoutIfNeeded];
//    [self cutRoundView:self.avatarImageView];
//    
//    // 设置imageView的tag，在PlayerView中取（建议设置100以上）
//    self.picView.tag = 101;
//    
//    // 代码添加playerBtn到imageView上
//    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.playBtn setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
//    [self.playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
//    [self.picView addSubview:self.playBtn];
//    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.picView);
//        make.width.height.mas_equalTo(50);
//    }];
//    
//}


#pragma mark - 工厂方法
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier        = @"playerCell";
    CMPlayerCell *cell                 = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CMPlayerCell" owner:nil options:nil] firstObject];
    }
    return cell;
}





#pragma mark - 数据源设置
-(void)setModel:(CMVideoModel *)model
{
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed] placeholderImage:[UIImage imageNamed:@"loading_bgView"]];
    self.titleLabel.text = model.title;
}

//- (void)play:(UIButton *)sender {
//    if (self.playBlock) {
//        self.playBlock(sender);
//    }
//}


#pragma mark - selector
- (IBAction)playBtnClick:(UIButton *)sender {
    
    if (self.playBlock) {
        self.playBlock(sender);
    }
    
}


#pragma mark - 私有方法
// 切圆角
- (void)cutRoundView:(UIImageView *)imageView
{
    CGFloat corner = imageView.frame.size.width / 2;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
    shapeLayer.path = path.CGPath;
    imageView.layer.mask = shapeLayer;
}

@end
