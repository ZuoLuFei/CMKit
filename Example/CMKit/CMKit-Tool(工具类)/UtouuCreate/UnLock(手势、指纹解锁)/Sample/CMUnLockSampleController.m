//
//  CMUnLockSampleController.m
//  CMKit
//
//  Created by HC on 16/11/28.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import "CMUnLockSampleController.h"
#import "DWUNlock.h"


static NSInteger const gesturesLockCount = 4;

@interface CMUnLockSampleController ()

/** 手势解锁 */
@property(strong, nonatomic) DWGesturesLock *gesture;

//手势密码Label
@property (nonatomic, strong) UILabel *gesturesPasswordLabel;




@end

@implementation CMUnLockSampleController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [self initUI];
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [DWGesturesLock dw_removePassword];
    
}

#pragma mark - 初始化UI
- (void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *figerPrintBtn = [[UIButton alloc] init];
    figerPrintBtn.frame = CGRectMake(10, 74, self.view.bounds.size.width - 20, 40);
    [figerPrintBtn setTitle:@"指纹解锁" forState:UIControlStateNormal];
    figerPrintBtn.backgroundColor = [UIColor grayColor];
    [figerPrintBtn addTarget:self action:@selector(figerPrintBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:figerPrintBtn];
    
    UIButton *gesturesBtn = [[UIButton alloc] init];
    gesturesBtn.frame = CGRectMake(10, CGRectGetMaxY(figerPrintBtn.frame)+10, self.view.bounds.size.width - 20, 40);
    [gesturesBtn setTitle:@"手势解锁" forState:UIControlStateNormal];
    gesturesBtn.backgroundColor = [UIColor grayColor];
    [gesturesBtn addTarget:self action:@selector(gesturesBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gesturesBtn];
    
    
    UILabel *gesturesPasswordLabel = [[UILabel alloc] init];
    self.gesturesPasswordLabel = gesturesPasswordLabel;
    gesturesPasswordLabel.frame = CGRectMake(10, CGRectGetMaxY(gesturesBtn.frame)+5, self.view.bounds.size.width - 20, 30);
    gesturesPasswordLabel.backgroundColor = [UIColor lightGrayColor];
//    gesturesPasswordLabel.textAlignment = NSTextAlignmentCenter;
    gesturesPasswordLabel.text = [NSString stringWithFormat:@"手势密码：%@",[DWGesturesLock obtainUserPassword]];
    [self.view addSubview:gesturesPasswordLabel];

}

#pragma mark - selector
- (void)figerPrintBtnClick{
    
    if (self.gesture) {
        [self.gesture removeFromSuperview];
    }
    
    [DWFingerprintUNlock dw_initWithFingerprintUNlockPromptMsg:@"此操作需要认证您的身份" cancelMsg:@"取消" otherMsg:@"启动手势解锁" enabled:YES otherClick:^(NSString *otherClick) {
        
        NSLog(@"选择了其它方式登录:%@---线程:%@", otherClick, [NSThread currentThread]);
        
        [self gesturesBtnClick];
        
    } success:^(BOOL success) {
        
        NSLog(@"认证成功---success:%d---线程:%@",success, [NSThread currentThread]);
        
        [MBProgressHUD showSuccess:@"认证成功"];
        
    } error:^(NSError *error) {
        
        NSLog(@"认证失败---error:%@---线程:%@",error, [NSThread currentThread]);
        
    } errorMsg:^(NSString *errorMsg) {
        
        
        NSLog(@"错误信息中文:%@---线程:%@", errorMsg, [NSThread currentThread]);
        
    }];


}

- (void)gesturesBtnClick{
    
    DWGesturesLock *gestures = [[DWGesturesLock alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 3, self.view.frame.size.width, self.view.frame.size.height / 3 * 2)];
    
    self.gesture = gestures;
    
    gestures.lineColor = [UIColor orangeColor];
    
    gestures.bgImage = [UIImage imageNamed:@"DWUNlock.bundle/bg"];
    
    gestures.lineTimer = 0.85;
    
    [self.view addSubview:gestures];
    
    if ([[DWGesturesLock obtainUserPassword] isBlank]) {
        [MBProgressHUD showSuccess:@"请录入初始密码"];
    }
    
    
    
    [gestures dw_passwordSuccess:^(BOOL success, NSString *password, NSString *userPassword) {
        
        NSLog(@"%d--%@--%@", success, password, userPassword);
        
        NSLog(@"%ld", password.length);
        
        NSLog(@"连续输入%ld次密码", gestures.inputCount);
        
        
        if (success) {
            
            NSLog(@"验证成功");
            self.gesturesPasswordLabel.text = [NSString stringWithFormat:@"手势密码：%@",userPassword];
            
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"验证成功,您的密码是:%@",password]];
            [self.gesture removeFromSuperview];
            self.gesture = nil;
            

            
        }else {
            
            NSLog(@"验证失败");
            
            if (gesturesLockCount - gestures.inputCount > 0) {
                NSString *falseStr = [NSString stringWithFormat:@"密码验证失败，您还有%ld次机会",(gesturesLockCount - gestures.inputCount)];
                [MBProgressHUD showError:falseStr];
            }else{
                [MBProgressHUD showError:@"密码输入太频繁，请稍后再试"];
                [self.gesture removeFromSuperview];
                self.gesture = nil;
            }
            
            
        }
        
    }];

    
}




@end
