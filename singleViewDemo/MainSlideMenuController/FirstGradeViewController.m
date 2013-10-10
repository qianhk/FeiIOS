//
//  FirstGradeViewController.m
//  singleViewDemo
//
//  Created by TTKai on 13-10-10.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "FirstGradeViewController.h"

@interface FirstGradeViewController ()

@end

@implementation FirstGradeViewController

- (IBAction)showMainMenu:(id)sender
{
	NSLog(@"showMainMenu self=%@ sender=%@", self, sender);
    [self.frostedViewController presentMenuViewController];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
