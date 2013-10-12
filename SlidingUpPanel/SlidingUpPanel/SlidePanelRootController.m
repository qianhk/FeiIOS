//
//  SlidePanelViewController.m
//  SlidingUpPanel
//
//  Created by TTKai on 13-10-12.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "SlidePanelRootController.h"

@interface SlidePanelRootController ()

@end

@implementation SlidePanelRootController

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
	
	[self displayController:_contentViewController frame:self.view.frame];
	CGRect panelFrame = self.view.frame;
	panelFrame.size.height = _panelViewController.expandHeight;
	panelFrame.origin.y = self.view.frame.size.height - _panelViewController.collapseHeight;
	[self displayController:_panelViewController frame:panelFrame];
	_panelViewController.parentHeight = self.view.frame.size.height;
	
//	[self.view addSubview:_panelViewController.view];
//	[self transitionFromViewController:_panelViewController toViewController:_contentViewController duration:3.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{} completion:^(BOOL finished){}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
	self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
	self.panelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"panelController"];
	self.panelViewController.expandHeight = 300;
	self.panelViewController.collapseHeight = 40;
}

- (void)displayController:(UIViewController *)controller frame:(CGRect)frame
{
    [self addChildViewController:controller];
    controller.view.frame = frame;
    [self.view addSubview:controller.view];
//    [controller didMoveToParentViewController:self];
}

- (void)hideController:(UIViewController *)controller
{
//    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}

@end
