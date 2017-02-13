//
//  CMCountLabelSampleController.m
//  CMKit
//
//  Created by HC on 17/2/13.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "CMCountLabelSampleController.h"
#import "UICountingLabel.h"

@interface CMCountLabelSampleController ()

@end

@implementation CMCountLabelSampleController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
}


#pragma mark - 初始化UI
- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self sample1];
    
    [self sample2];
    
    [self sample3];
    
    [self sample4];
    
    [self sample5];
}


// 样例一
- (void)sample1 {
    // make one that counts up
    UICountingLabel* myLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 70, 200, 40)];
    myLabel.method = UILabelCountingMethodLinear;
    myLabel.format = @"%d";
    [self.view addSubview:myLabel];
    [myLabel countFrom:1 to:10 withDuration:3.0];

}

// 样例二
- (void)sample2 {
    UICountingLabel* countPercentageLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 110, 200, 40)];
    [self.view addSubview:countPercentageLabel];
    countPercentageLabel.format = @"%.1f%%";
    [countPercentageLabel countFrom:5 to:10];
}

// 样例三
- (void)sample3 {
    // count up using a string that uses a number formatter
    UICountingLabel* scoreLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 150, 200, 40)];
    [self.view addSubview:scoreLabel];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    scoreLabel.formatBlock = ^NSString* (CGFloat value)
    {
        NSString* formatted = [formatter stringFromNumber:@((int)value)];
        return [NSString stringWithFormat:@"Score: %@",formatted];
    };
    scoreLabel.method = UILabelCountingMethodEaseOut;
    [scoreLabel countFrom:0 to:10000 withDuration:2.5];
}


// 样例四
- (void)sample4 {
    // count up with attributed string
    NSInteger toValue = 100;
    UICountingLabel* attributedLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 190, 200, 40)];
    [self.view addSubview:attributedLabel];
    attributedLabel.attributedFormatBlock = ^NSAttributedString* (CGFloat value)
    {
        NSDictionary* normal = @{ NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 20] };
        NSDictionary* highlight = @{ NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue" size: 20] };
        
        NSString* prefix = [NSString stringWithFormat:@"%d", (int)value];
        NSString* postfix = [NSString stringWithFormat:@"/%d", (int)toValue];
        
        NSMutableAttributedString* prefixAttr = [[NSMutableAttributedString alloc] initWithString: prefix
                                                                                       attributes: highlight];
        NSAttributedString* postfixAttr = [[NSAttributedString alloc] initWithString: postfix
                                                                          attributes: normal];
        [prefixAttr appendAttributedString: postfixAttr];
        
        return prefixAttr;
    };
    [attributedLabel countFrom:0 to:toValue withDuration:2.5];
    
}


// 样例五
- (void)sample5 {
    UICountingLabel *colorLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 230, 200, 40)];
    [self.view addSubview:colorLabel];
    colorLabel.method = UILabelCountingMethodEaseInOut;
    colorLabel.format = @"%d%%";
    __weak UICountingLabel *blockColorLabel = colorLabel;
    colorLabel.completionBlock = ^{
        blockColorLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1];
    };
    [colorLabel countFrom:0 to:100];
}




@end
