//
//  CMSystemFontInfoSampleControllerViewController.m
//  CMKit
//
//  Created by HC on 16/11/17.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMSystemFontInfoSampleControllerViewController.h"
#import "CMFontListCell.h"
#import "CMFontInfoModel.h"
#import "CMFontInfomation.h"
#import "CMFontListHeaderView.h"

@interface CMSystemFontInfoSampleControllerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSArray      *fontsList;

@end

@implementation CMSystemFontInfoSampleControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary   *fontListDictionary = [CMFontInfomation systomFontNameList];
    NSMutableArray *fontList           = [NSMutableArray array];
    
    [fontListDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        CMFontInfoModel *tmpModel = [CMFontInfoModel new];
        tmpModel.fontFamilyName = key;
        tmpModel.fontNames      = obj;
        
        [fontList addObject:tmpModel];
    }];
    
    self.fontsList = fontList;
    
    self.tableView                     = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    self.tableView.delegate            = self;
    self.tableView.dataSource          = self;
    self.tableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight           = 40;
    self.tableView.sectionHeaderHeight = 40;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[CMFontListCell class]  forCellReuseIdentifier:@"CMFontListCell"];
    [self.tableView registerClass:[CMFontListHeaderView class] forHeaderFooterViewReuseIdentifier:@"CMFontListHeaderView"];
}

#pragma mark - UITableView's delegate & dataSource.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.fontsList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CMFontInfoModel *model = self.fontsList[section];
    
    return model.fontNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CMFontInfoModel *model = self.fontsList[indexPath.section];
    
    
    CMFontListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMFontListCell"];
    cell.fontStr        = model.fontNames[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CMFontInfoModel *model = self.fontsList[section];
    
    CMFontListHeaderView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CMFontListHeaderView"];
    titleView.titleStr                = model.fontFamilyName;

    return titleView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CMFontInfoModel *model = self.fontsList[indexPath.section];
    NSLog(@"选中字体-->%@",model.fontNames[indexPath.row]);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}




@end
