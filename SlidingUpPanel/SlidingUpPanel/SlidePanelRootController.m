//
//  SlidePanelViewController.m
//  SlidingUpPanel
//
//  Created by TTKai on 13-10-12.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "SlidePanelRootController.h"

@interface SlidePanelRootController ()
{
    UIView *_midView;
}
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"SlidePanelRootController willRotateToInterfaceOrientation(%f %f %f %f)", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"SlidePanelRootController didRotateFromInterfaceOrientation(%f %f %f %f)", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGRect contentFrame = self.view.frame;
    if (IOS_VERSION < 7.0) {
        contentFrame.origin.y = 0;
    }
	[self displayController:_contentViewController frame:contentFrame];
    _contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _midView = [[UIView alloc] initWithFrame:contentFrame];
    [_midView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.5f]];
    [self.view addSubview:_midView];
    [self setMidViewAlpha:0.0f];
    _midView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	CGRect panelFrame = contentFrame;
	panelFrame.size.height = _panelViewController.expandHeight;
	panelFrame.origin.y = contentFrame.size.height - _panelViewController.collapseHeight;
	[self displayController:_panelViewController frame:panelFrame];
    _panelViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _panelViewController.parentHeight = contentFrame.size.height;
	
//	[self.view addSubview:_panelViewController.view];
//	[self transitionFromViewController:_panelViewController toViewController:_contentViewController duration:3.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{} completion:^(BOOL finished){}];
}

- (void)setMidViewAlpha:(float)alpha
{
    _midView.alpha = alpha;
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
	self.panelViewController.collapseHeight = 80;
}

- (void)displayController:(UIViewController *)controller frame:(CGRect)frame
{
    NSLog(@"displayController:(%f %f %f %f)", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
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

- (BOOL)shouldAutorotate
{
	return NO;
}

@end
