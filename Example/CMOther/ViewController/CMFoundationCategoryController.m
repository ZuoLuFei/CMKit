//
//  CMFoundationCategoryController.m
//  CMKit
//
//  Created by HC on 16/11/1.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMFoundationCategoryController.h"
#import "CMDetailedFunctionController.h"
#import "CMHeadView.h"

@interface CMFoundationCategoryController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *foundationArray;

@end

@implementation CMFoundationCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化数据
    [self initData];
    
    //2.创建UI
    [self initUI];
}

#pragma mark - 初始化数据
- (void)initData{
    self.foundationArray = @[@{@"name":@"NSArray+CMKit",@"classFunction":@[@"通过给出的索引在安全的情况下获取一个对象(如果数组本身为空或者索引超出了范围则返回nil)",
                                                                       @"根据自身创建一个倒序的数组",
                                                                       @"通过给出的数组创建一个倒序数组",
                                                                       @"以NSString类型将数组本身转换为JSON",
                                                                       @"将给出的数组转换为NSString类型的JSON",
                                                                       @"将数组本身模拟为一个循环，当超出数组范围时，在相应的位置重新开始"]},
                             @{@"name":@"NSData+CMKit",@"classFunction":@[@"将给出的NSData数据转换为UTF8格式的字符串",
                                                                      @"转换自身为UTF8格式字符串",
                                                                      @"将给出的NSData数据转换为ASCII格式的字符串",
                                                                      @"转换自身为ASCII格式字符串",
                                                                      @"转换自己的UUID为字符串(一般用于消息推送)"]},
                             @{@"name":@"NSDate+CMKit",@"classFunction":@[@"是否为今天",
                                                                      @"是否为昨天",
                                                                      @"是否为今年",
                                                                      @"返回一个只有年月日的时间",
                                                                      @"获得与当前时间的差距",
                                                                      @"通过自身获取工作日",
                                                                      @"通过自身获取当地的工作日描述",
                                                                      @"通过自身获取月数字",
                                                                      @"通过给出的月数字获取当地的月描述",
                                                                      @"比较自身和另一个日期是否为同一天",
                                                                      @"给自身增加天数",
                                                                      @"判断输入dateStr的是今天、昨天还是具体的某天"]},
                             @{@"name":@"NSDictionary+CMKit",@"classFunction":@[@"以NSString类型将字典本身转换为JSON",
                                                                            @"将给出的字典转换为NSString类型的JSON",
                                                                            @"如果key存在返回对应的对象，否则返回nil"]},
                             @{@"name":@"NSFileManager+CMKit",@"classFunction":@[@"读取一份文件以字符串输出",
                                                                             @"将指定的数组保存到指定目录下的指定文件中",
                                                                             @"从指定的目录下指定文件，返回数组",
                                                                             @"获取主Bundle目录下的指定文件地址",
                                                                             @"获取Documents目录下的指定文件地址",
                                                                             @"获取Library目录下的指定文件地址",
                                                                             @"获取Cache目录下的指定文件地址",
                                                                             @"返回指定目录下指定文件的的文件大小",
                                                                             @"删除指定目录下的指定文件",
                                                                             @"将文件从一个目录移动到另一个目录",
                                                                             @"复制一个文件到另一个目录",
                                                                             @"对指定目录下的指定文件进行重命名",
                                                                             @"根据给出的key获取APP的偏好设置",
                                                                             @"设置APP偏好设置通过key和object值，偏好设置文件被保存在Library目录",
                                                                             @"通过指定的key获取设置文件中的值",
                                                                             @"将指定的key和value添加到指定的设置文件中，设置文件将保存在Library目录中"]},
                             @{@"name":@"NSMutableArray+CMKit",@"classFunction":@[@"将指定索引位置的对象移动到另一个索引位置",
                                                                              @"根据自身创建一个倒序的数组",
                                                                              @"根据指定的key对数组进行升序或降序排序"]},
                             @{@"name":@"NSMutableDictionary+CMKit",@"classFunction":@[@"安全的在字典中设置key对应value值"]},
                             @{@"name":@"NSNumber+CMKit",@"classFunction":@[@"在指定范围内创建一个随机integer值",
                                                                        @"创建一个随机的float值",
                                                                        @"在指定范围内创建一个随机float值"]},
                             @{@"name":@"NSObject+CMKit",@"classFunction":@[@"检查对象是否可用(不为nil或null)"]},
                             @{@"name":@"NSProcessInfo+CMKit",@"classFunction":@[@"返回当前APP对CPU的使用量"]},
                             @{@"name":@"NSString+CMKit",@"classFunction":@[@"判断字符串是否为空",
                                                                        @"根据提供的最大width和font计算文本占用的高",
                                                                        @"计算文本占用的尺寸",
                                                                        @"正则有效的电话号码",
                                                                        @"正则有效的真实姓名",
                                                                        @"正则是否只有中文",
                                                                        @"正则有效的验证码(根据项目的验证码位数进行修改)",
                                                                        @"正则有效的银行卡号",
                                                                        @"正则有效的邮箱",
                                                                        @"正则有效的字母数字密码",
                                                                        @"正则检测有效身份证(15位)",
                                                                        @"正则检测有效身份证(18位)",
                                                                        @"正则是否为纯数字",
                                                                        @"正则检查自身是否是邮件地址",
                                                                        @"正则检查给出的字符串是否是邮件地址",
                                                                        @"电话号码中间4位****显示",
                                                                        @"银行卡号中间8位**** ****显示",
                                                                        @"通过时间戳计算时间差（几小时前、几天前）",
                                                                        @"通过时间戳得出显示时间",
                                                                        @"在指定的字符串中按照开始字符和结束字符获取子字符串",
                                                                        @"返回给出字符的索引值(注:返回第一次被找到字符的索引值)",
                                                                        @"截取一段从指定字符至末尾的子字符串(注：以找到的第一个字符索引位置开始)",
                                                                        @"截取一段从头至指定字符的子字符串(注：以找到的第一个字符索引位置开始)",
                                                                        @"在高敏感度下检查自身是否包含指定的子字符串(区分大小写)",
                                                                        @"在指定敏感度下检查自身是否包含自定的子字符串",
                                                                        @"对指定的字符串进行Base64编码",
                                                                        @"对指定的字符串进行Base64解码",
                                                                        @"将指定的字符串转换为data数据",
                                                                        @"将指定字符串转换为句首大写的标准语法",
                                                                        @"将时间戳转换为人类易于识别的字符串",
                                                                        @"创建一个UUID字符串",
                                                                        @"判断此UUID是否可用",
                                                                        @"判断此UUID对APNS是否可用",
                                                                        @"将自身转换为一个对APNS可用的UUID(No ‘<>’ or ‘-’ or spaces)"]}];
    
}

#pragma mark - 初始化UI
//创建UI
- (void)initUI{
    
    //1.创建TableView
    UITableView *tableView = [UITableView initWithFrame:self.view.bounds style:UITableViewStylePlain cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorInset:UIEdgeInsetsMake(0, 0, 0, 0) dataSource:self delegate:self];
    
//    [tableView registerClass:[CMHeadView class] forHeaderFooterViewReuseIdentifier:@"CMHeadView"];
    
    tableView.tableHeaderView = [CMHeadView headView];
    
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.foundationArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"CMFoundationCategoryController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSDictionary *dict = self.foundationArray[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    CMHeadView *headView = [[CMHeadView alloc] initWithReuseIdentifier:@"CMHeadView"];
    headView.titleStr = @"Foundation 框架分类";
    
    return headView;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.foundationArray[indexPath.row];
    if (dict) {
        
        CMDetailedFunctionController *Vc = [[CMDetailedFunctionController alloc] init];
        Vc.functionArray = dict[@"classFunction"];
        Vc.vcTitle = dict[@"name"];
        Vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Vc animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}





@end
