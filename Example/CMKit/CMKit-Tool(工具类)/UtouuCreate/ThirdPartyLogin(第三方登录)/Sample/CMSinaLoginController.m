//
//  CMSinaLoginController.m
//  CMKit
//
//  Created by HC on 16/11/2.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMSinaLoginController.h"
#import "AFNetworking.h"
#define  APPKEY       @"3914053230"
#define  REDIRECT_URI @"http://www.utouu.com"
#define  APPSECRET    @"a35f877297c64a1134400e5b7f6b6d8e"



@interface CMSinaLoginController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation CMSinaLoginController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化UI
    [self initUI];
    
}

#pragma mark - 初始化UI
- (void) initUI{
    
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = self.view.bounds;
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",APPKEY,REDIRECT_URI];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    
    [MBProgressHUD showMessage:@"加载中" toView:self.view];
    
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    NSLog(@"url-->%@",url);
    NSRange  range = [url rangeOfString:@"/?code="];
    NSString  *code = nil;
    
    
    [MBProgressHUD hideHUDForView:self.view];
    
    if (range.length > 0) {
        code = [url substringFromIndex:range.location + range.length];
        NSLog(@"code = %@",code);
        [self accessTokenWithCode:code];
        return  NO;
    }
    return  YES;
}

- (void)accessTokenWithCode:(NSString*) code {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forKey:@"Content-Type"];
    [manager setRequestSerializer:requestSerializer];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *parameters = [NSMutableDictionary  dictionary];
    parameters[@"client_id"] = APPKEY;
    parameters[@"client_secret"] = APPSECRET;
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = REDIRECT_URI;
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /**
         * 获得uid(可做用户名)和access_token(可做密码)在自己的服务器进行注册登录操作
         */
        NSLog(@"%@",responseObject);
        NSString *uid = responseObject[@"uid"];
        NSString *access_token = responseObject[@"access_token"];
        NSLog(@"uid = %@, access_token =%@",uid,access_token);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);;
    }];
    
}


@end
