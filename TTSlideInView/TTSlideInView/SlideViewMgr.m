//
//  SlideViewMgr.m
//  TTSlideInView
//
//  Created by TTKai on 12-10-23.
//  Copyright (c) 2012年 kai. All rights reserved.
//

#import "SlideViewMgr.h"
#import "ViewController.h"

@interface SlideViewMgr ()

@end

@implementation SlideViewMgr

- (void)dealloc
{
	[super dealloc];
	[_arrayViewController release];
}

- (id)init
{
    self = [super init];
    if (self) {
        _arrayViewController = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	ViewController* controller = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	[controller.labelOne setText:@"First View"];
	controller.view.backgroundColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.2f];
	[_arrayViewController addObject:controller];
	[self.view addSubview:controller.view];
	
	controller = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	[controller.labelOne setText:@"Second View"];
	controller.view.backgroundColor = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:0.2f];
	[_arrayViewController addObject:controller];
	[self.view addSubview:controller.view];
	
	controller = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	[controller.labelOne setText:@"Third View"];
	controller.view.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.2f];
	[_arrayViewController addObject:controller];
	[self.view addSubview:controller.view];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
