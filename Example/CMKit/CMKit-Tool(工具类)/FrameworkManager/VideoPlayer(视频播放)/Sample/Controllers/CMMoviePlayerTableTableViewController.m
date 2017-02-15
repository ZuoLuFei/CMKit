//
//  CMMoviePlayerTableTableViewController.m
//  CMKit
//
//  Created by HC on 17/2/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMMoviePlayerTableTableViewController.h"
#import "CMVideoModel.h"
#import "CMPlayerCell.h"
#import "CMVideoResolution.h"
#import "Masonry.h"
#import "ZFPlayer.h"

@interface CMMoviePlayerTableTableViewController () <ZFPlayerDelegate>

@property (nonatomic, strong) NSMutableArray      *dataSource;
@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation CMMoviePlayerTableTableViewController

#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 379.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self requestData];
}

// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}

- (void)requestData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    self.dataSource = @[].mutableCopy;
    NSArray *videoList = [rootDict objectForKey:@"videoList"];
    for (NSDictionary *dataDic in videoList) {
        CMVideoModel *model = [[CMVideoModel alloc] init];
        [model setValuesForKeysWithDictionary:dataDic];
        [self.dataSource addObject:model];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *identifier        = @"playerCell";
//    CMPlayerCell *cell                 = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    CMPlayerCell *cell = [CMPlayerCell cellWithTableView:tableView];
    
    // 取到对应cell的model
    __block CMVideoModel *model        = self.dataSource[indexPath.row];
    // 赋值model
    cell.model                         = model;
    __block NSIndexPath *weakIndexPath = indexPath;
    __block CMPlayerCell *weakCell     = cell;
    __weak typeof(self)  weakSelf      = self;
    // 点击播放的回调
    cell.playBlock = ^(UIButton *btn){
        
        // 分辨率字典（key:分辨率名称，value：分辨率url)
        NSMutableDictionary *dic = @{}.mutableCopy;
        for (CMVideoResolution * resolution in model.playInfo) {
            [dic setValue:resolution.url forKey:resolution.name];
        }
        // 取出字典中的第一视频URL
        NSURL *videoURL = [NSURL URLWithString:dic.allValues.firstObject];
        
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title            = model.title;
        playerModel.videoURL         = videoURL;
        playerModel.placeholderImageURLString = model.coverForFeed;
        playerModel.tableView        = weakSelf.tableView;
        playerModel.indexPath        = weakIndexPath;
        // 赋值分辨率字典
        playerModel.resolutionDic    = dic;
        // player的父视图
        playerModel.fatherView       = weakCell.picView;
        
        // 设置播放控制层和model
        [weakSelf.playerView playerControlView:weakSelf.controlView playerModel:playerModel];
        // 下载功能
        weakSelf.playerView.hasDownload = NO;
        // 自动播放
        [weakSelf.playerView autoPlayTheVideo];
    };
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath---%zd",indexPath.row);
}

- (ZFPlayerView *)playerView
{
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
        // _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 静音
        // _playerView.mute = YES;
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView
{
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
    }
    return _controlView;
}

#pragma mark - ZFPlayerDelegate

//- (void)zf_playerDownload:(NSString *)url
//{
//    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
//    NSString *name = [url lastPathComponent];
//    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
//    // 设置最多同时下载个数（默认是3）
//    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
//}



@end
