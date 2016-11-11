//
//  CMImagePickerSampleController.m
//  CMKit
//
//  Created by HC on 16/11/1.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMImagePickerSampleController.h"
#import "CMImagePickerManager.h"
#import "CMAlbumImagesSampleController.h"

//打开相机
static NSString * const OpenCamera = @"OpenCamera";
//打开单选相册
static NSString * const OpenAlbum = @"OpenAlbum";
//打开多选相册
static NSString * const OpenAlbumImages = @"OpenAlbumImages";

@interface CMImagePickerSampleController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *imagePickerArray;

@end

@implementation CMImagePickerSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化数据
    [self initData];
    
    //2.创建UI
    [self initUI];
}

#pragma mark - 初始化数据
- (void)initData{
    self.imagePickerArray = @[@{@"name":@"openCamera(打开相机)",@"pickerType":OpenCamera},
                       @{@"name":@"openAlbum(打开单选相册)",@"pickerType":OpenAlbum},
                       @{@"name":@"openAlbumImages(打开多选相册)",@"pickerType":OpenAlbumImages}];
}

#pragma mark - 初始化UI
//创建UI
- (void)initUI{
    
    //1.创建TableView
    UITableView *tableView = [UITableView initWithFrame:self.view.bounds style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imagePickerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMImagePickerSampleController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSDictionary *dict = self.imagePickerArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.imagePickerArray[indexPath.row];
    
    if ([dict[@"pickerType"] isEqualToString:OpenCamera] ) {
        [[CMImagePickerManager sharedCMImagePickerManager] showCameraWithViewController:self handler:^(UIImage *image) {
            NSLog(@"相机拍摄照片-->%@",image.description);
        }];
        
    }else if([dict[@"pickerType"] isEqualToString:OpenAlbum] ){
        [[CMImagePickerManager sharedCMImagePickerManager] showPhotoLibraryWithViewController:self handler:^(UIImage *image) {
            NSLog(@"相册选中照片-->%@",image.description);
        }];
    }else if([dict[@"pickerType"] isEqualToString:OpenAlbumImages] ){
        CMAlbumImagesSampleController *albumImagesSampleController = [[CMAlbumImagesSampleController alloc] init];
        [self.navigationController pushViewController:albumImagesSampleController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
