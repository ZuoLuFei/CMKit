//
//  DWGesturesLock.m
//  DWUNlock
//
//  Created by dwang_sui on 2016/10/28.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWGesturesLock.h"

@interface DWGesturesLock ()

/** 所有按钮 */
@property (strong, nonatomic) NSMutableArray *points;

/** 画线数组 */
@property (strong, nonatomic) NSMutableArray *lines;

/** point点 */
@property (assign, nonatomic) CGPoint currentPoint;

@end

/** 九宫格排列方式 */
#define DWPointCount 9

#define DWPassword [[NSUserDefaults standardUserDefaults] objectForKey:@"DWGesturesLock"]

@implementation DWGesturesLock

#pragma mark ---点击这个view的时候调用
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    
    //获取触摸对象
    UITouch* t = touches.anyObject;
    
    //获取手指的点击的位置
    CGPoint p = [t locationInView:t.view];
    
    //遍历所有按钮 进行判断
    for (int i = 0; i < self.points.count; i++) {
        
        //获取button
        UIButton* btn = self.points[i];
        
        //判断手指的位置 是不是在按钮的frame的范围之内
        if (CGRectContainsPoint(btn.frame, p)) {
            
            btn.highlighted = YES;
            
            //判断 这个需要画线的数组 是不是已经有了这个btn 如果没有再添加
            if (![self.lines containsObject:btn]) {
                
                //设置为高亮 表示这个btn需要进行连线
                [self.lines addObject:btn];
                
            }
        }
    }
}

#pragma mark ---在view上移动时调用
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    
    //获取触摸对象
    UITouch* t = touches.anyObject;
    
    //获取手指当前移动到的位置(最新的位置)
    CGPoint p = [t locationInView:t.view];
    
    //给全局属性赋值
    self.currentPoint = p;
    
    //遍历所有按钮
    for (int i = 0; i < self.points.count; i++) {
        
        //获取btn
        UIButton* btn = self.points[i];
        
        //判断手指的位置是不是在 某一个btn的frame范围之内
        if (CGRectContainsPoint(btn.frame, p)) {
        
            //如果在 设置成 高亮状态
            btn.highlighted = YES;
            
            //判断 这个需要画线的数组 是不是已经有了这个btn 如果没有再添加
            if (![self.lines containsObject:btn]) {
            
                //设置为高亮 表示这个btn需要进行连线
                [self.lines addObject:btn];
            }
        }
    }
    
    //重绘
    [self setNeedsDisplay];
}

#pragma mark ---view停止滑动
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    
    //连续输入密码的次数
    self.inputCount = self.inputCount + 1;
    
    UIButton *lastObject = [self.lines lastObject];
    
    //把"当前手指的位置"变成需要连线的数组中的最后的一个按钮的center
    self.currentPoint = [lastObject center];
    
    //重绘
    [self setNeedsDisplay];
    
    //生成密码
    NSString* password = @"";
    
    for (int i = 0; i < self.lines.count; i++) {
        
        //获取btn
        UIButton* btn = self.lines[i];
        
        NSString* btnPassword = [NSString stringWithFormat:@"%ld", btn.tag];
        
        password = [password stringByAppendingString:btnPassword];
        
    }
    
    self.passwordImage = [self snipGesturesPasswordsView:self];
    
    //密码最小长度
    NSUInteger passwordLength;
    
    if (self.passwordLength > 0) {
        
        passwordLength = self.passwordLength;
        
    }else {
        
        passwordLength = 3;
        
    }
    
    if (!DWPassword && password.length >= passwordLength) {
        
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"DWGesturesLock"];
        
    }
    
    if (self.password) {
        
        BOOL isbool;
        
        if ([password isEqualToString:DWPassword]) {
            
            isbool = YES;
            
        }else {
            
            isbool = NO;
            
        }
        
        self.password(isbool, password, DWPassword);
        
    }
    
    //遍历 连线的数组
    for (int i = 0; i < self.lines.count; i++) {
        
        //获取button
        UIButton* btn = self.lines[i];
        
        if ([DWPassword isEqualToString:password]) {
            
            //设置正确状态的图片
            if (self.gesturesSuccess) {
                
                 [btn setBackgroundImage:self.gesturesSuccess forState:UIControlStateSelected];
                
            }else {
            
                [btn setBackgroundImage:[UIImage imageNamed:@"DWUNlock.bundle/gesture_node_success"]  forState:UIControlStateSelected];
            
            }
            
        }else {
            
            //设置错误状态的图片
            if (self.gesturesError) {
                
                [btn setBackgroundImage:self.gesturesError forState:UIControlStateSelected];
                
            }else {
            
                [btn setBackgroundImage:[UIImage imageNamed:@"DWUNlock.bundle/gesture_node_error"] forState:UIControlStateSelected];
            
            }
            
        }
        
        //设置选中状态
        btn.selected = YES;
        
        btn.highlighted = NO;
    }
    
    //禁用当前view的用户交互(解决错误以后还能编辑的问题)
    self.userInteractionEnabled = NO;
    
    double lineTimer;
    
    if (self.lineTimer > 0) {
        
        lineTimer = self.lineTimer;
        
    }else {
        
        lineTimer = 2.0;
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(lineTimer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.userInteractionEnabled = YES;
        
        [self clear]; // 恢复到最初始的状态
    });
}

#pragma mark ---清空画线数组
- (void)clear {
    
    for (int i = 0; i < self.points.count; i++) {
        
        // 获取button
        UIButton* btn = self.points[i];
        
        btn.highlighted = NO;
        
        btn.selected = NO;
    }
    
    // 清空所有需要画线的数组
    [self.lines removeAllObjects];
    
    // 重绘
    [self setNeedsDisplay];
}

#pragma mark ---开始画线
- (void)drawRect:(CGRect)rect {
    
    // 路径
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    for (int i = 0; i < self.lines.count; i++) {
        
        if (i == 0) {
            
            UIButton *fistObject = self.lines[i];
            
            // 如果是第0个那么 应该设置为起点
            [path moveToPoint:[fistObject center]];
            
        }else {
            
            UIButton *lineObject = self.lines[i];
            
            // 如果不是第0个 那么直接连线
            [path addLineToPoint:[lineObject center]];
        }
    }
    
    // 判断需要画线的数组是否有值 如果没有 再去连线到手指的位置
    if (self.lines.count) {
        
        // 往手指的位置进行连线
        [path addLineToPoint:self.currentPoint];
    }
    
    // 设置颜色
    if (self.lineColor) {
        
     [self.lineColor set];
        
    }else {
        
        [[UIColor whiteColor] set];
        
    }
    
    // 线宽
    if (self.lineWidth > 0) {
        
        [path setLineWidth:self.lineWidth];
        
    }else {
     
        [path setLineWidth:10];
        
    }
    
    // 连接处
    [path setLineJoinStyle:kCGLineJoinRound];
    
    // 头尾处
    [path setLineCapStyle:kCGLineCapRound];
    
    // 渲染
    [path stroke];
}


#pragma mark ---计算九宫格
- (void)layoutSubviews
{
    [super layoutSubviews];
    
        if (self.bgImage) {
            
            self.backgroundColor = [UIColor colorWithPatternImage:self.bgImage];
            
        }else {
            
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DWUNlock.bundle/bg"]];
            
        }
    
    // 计算九宫格位置
    CGFloat width;
    if (self.sizeW_H > 0) {
        
    width = self.sizeW_H;
        
    }else {
    
    width = 74;
    
    }
    
    CGFloat height = width;
    
    int colCount = 3;
    
    CGFloat margin = (self.frame.size.width - 3 * width) / 4;
    
    for (int i = 0; i < self.points.count; i++) {
        
        CGFloat x = (i % colCount) * (margin + width) + margin;
        
        CGFloat y = (i / colCount) * (margin + width) + margin;
        
        [self.points[i] setFrame:CGRectMake(x, y, width, height)];
    }
    
}

#pragma mark ---画线数组懒加载
- (NSMutableArray *)lines {
    
    if (!_lines) {
        
        _lines = [NSMutableArray array];
        
    }
    
    return _lines;
}

#pragma mark ---按钮数组懒加载
- (NSMutableArray *)points {
    
    if (!_points) {
        
        _points = [NSMutableArray array];
        
        //循环创建九个按钮
        for (int i = 0; i < DWPointCount; i ++) {
            
            UIButton *point = [[UIButton alloc] init];
            
            //tag=密码
            point.tag = i;
            
            //关闭高亮状态
            point.userInteractionEnabled = NO;
            
            //设置默认状态的图片
            if (self.gesturesNormal) {
                
                [point setBackgroundImage:self.gesturesNormal forState:UIControlStateNormal];
                
            }else {
            
                [point setBackgroundImage:[UIImage imageNamed:@"DWUNlock.bundle/gesture_node_normal"] forState:UIControlStateNormal];
            
            }
            
            //设置高亮状态的图片
            if (self.gesturesSelected) {
                
                [point setBackgroundImage:self.gesturesSelected forState:UIControlStateHighlighted];
                
            }else {
            
                [point setBackgroundImage:[UIImage imageNamed:@"DWUNlock.bundle/gesture_node_highlighted"] forState:UIControlStateHighlighted];
            
            }
                
            [self addSubview:point];
            
            [_points addObject:point];
        }
        
    }
    
    return _points;
}

#pragma mark ---截取画线视图
- (UIImage *)snipGesturesPasswordsView:(UIView *)view {
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
        
    } else {
        
        UIGraphicsBeginImageContext(view.bounds.size);
        
    }
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //存储图片
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}


#pragma mark ---当前选中与设置密码
- (void)dw_passwordSuccess:(Password)password {
    
    self.password = ^(BOOL success, NSString *pass, NSString *userPass) {
    
        password(success, pass, userPass);
        
    };
    
}

#pragma mark ---删除手势密码
+ (void)dw_removePassword {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"DWGesturesLock"];
    
}


#pragma mark ---原始密码
+ (NSString *)obtainUserPassword {
    NSString *userPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"DWGesturesLock"];
    
    if (userPassword) {
        return userPassword;
    }else{
        return @"";
    }
}



@end
