//
//  CMVideoListController.m
//  CMKit
//
//  Created by HC on 17/2/14.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMVideoListController.h"
#import "CMMoviePlayerViewController.h"


@interface CMVideoListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray     *dataSource;

@end

@implementation CMVideoListController


#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化数据
    [self initData];
    
    
    //2.创建UI
    [self initUI];
}

#pragma mark - 初始化数据
- (void)initData{
    self.dataSource = @[@"http://7xqhmn.media1.z0.glb.clouddn.com/femorning-20161106.mp4",
                        @"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4",
                        @"http://baobab.wdjcdn.com/1456117847747a_x264.mp4",
                        @"http://baobab.wdjcdn.com/14525705791193.mp4",
                        @"http://baobab.wdjcdn.com/1456459181808howtoloseweight_x264.mp4",
                        @"http://baobab.wdjcdn.com/1455968234865481297704.mp4",
                        @"http://baobab.wdjcdn.com/1455782903700jy.mp4",
                        @"http://baobab.wdjcdn.com/14564977406580.mp4",
                        @"http://baobab.wdjcdn.com/1456316686552The.mp4",
                        @"http://baobab.wdjcdn.com/1456480115661mtl.mp4",
                        @"http://baobab.wdjcdn.com/1456665467509qingshu.mp4",
                        @"http://baobab.wdjcdn.com/1455614108256t(2).mp4",
                        @"http://baobab.wdjcdn.com/1456317490140jiyiyuetai_x264.mp4",
                        @"http://baobab.wdjcdn.com/1455888619273255747085_x264.mp4",
                        @"http://baobab.wdjcdn.com/1456734464766B(13).mp4",
                        @"http://baobab.wdjcdn.com/1456653443902B.mp4",
                        @"http://baobab.wdjcdn.com/1456231710844S(24).mp4"];
    
}

#pragma mark - 初始化UI
//创建UI
- (void)initUI{
    
    //1.创建TableView
    UITableView *tableView = [UITableView initWithFrame:self.view.bounds style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];
    
    [self.view addSubview:tableView];
    
}

// 必须支持转屏，但只是只支持竖屏，否则横屏启动起来页面是横的
- (BOOL)shouldAutorotate
{
    return YES;
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMVideoListController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text   = [NSString stringWithFormat:@"网络视频%zd",indexPath.row+1];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataSource[indexPath.row];
    if (dict) {
        
        CMMoviePlayerViewController *Vc = [[CMMoviePlayerViewController alloc] init];
//        Vc.title = dict[@"titleName"];
        NSURL *URL                       = [NSURL URLWithString:self.dataSource[indexPath.row]];
        Vc.videoURL                   = URL;
        [self.navigationController pushViewController:Vc animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
