//
//  ViewController.m
//  TTSlideInView
//
//  Created by TTKai on 12-10-23.
//  Copyright (c) 2012年 kai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
	[_labelOne release];
	[super dealloc];
}
@end
