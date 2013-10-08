//
//  ThirdViewController.m
//  singleViewDemo
//
//  Created by qianhk on 13-10-6.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property(nonatomic, strong)UIButton *button;
@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"initWithNibname nibName=%@", nibNameOrNil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Third Controller";
    
    UIButton *button = self.button;
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIView *superView = button.superview;
    
    NSLayoutConstraint *centerXContraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *centerYContraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
//    [superView addConstraint:centerXContraint];
//    [superView addConstraint:centerYContraint];
    [superView addConstraints:@[centerXContraint, centerYContraint]];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
