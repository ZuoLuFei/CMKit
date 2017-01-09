//
//  KNThirdViewController.h
//  KNSemiModalViewControllerDemo
//
//  Created by Kent Nguyen on 2/5/12.
//  Copyright (c) 2012 Kent Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNThirdViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *helpLabel;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UIButton *resizeButton;

- (IBAction)dismissButtonDidTouch:(id)sender;
- (IBAction)resizeSemiModalView:(id)sender;

@end
