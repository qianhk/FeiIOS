//
//  SlidePanelViewController.m
//  SlidingUpPanel
//
//  Created by TTKai on 13-10-12.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "SlidePanelViewController.h"
#import "SlidePanelRootController.h"

@interface SlidePanelViewController ()
{
	BOOL _expand;
	BOOL _anmitioning;
	float _originYPos;
}
@end

@implementation SlidePanelViewController

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"SlidePanelViewController willRotateToInterfaceOrientation(%f %f %f %f)", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"SlidePanelViewController didRotateFromInterfaceOrientation(%f %f %f %f)", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
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

    [self.view setBackgroundColor:[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f]];
    
	if (self.dragView == nil) {
		self.dragView = self.view;
	}
	
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self.dragView addGestureRecognizer:tapRecognizer];
	
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [self.dragView addGestureRecognizer:panRecognizer];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateBegan) {
//        [self presentMenuViewControllerWithAnimatedApperance:NO];
    }
	
    CGPoint point = [recognizer translationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
		_originYPos = self.view.frame.origin.y;
        _anmitioning = YES;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.view.frame;
		frame.origin.y = point.y + _originYPos;
        if (frame.origin.y > _parentHeight - _collapseHeight) {
            frame.origin.y = _parentHeight - _collapseHeight;
        } else if (frame.origin.y < _parentHeight - _expandHeight) {
            frame.origin.y = _parentHeight - _expandHeight;
        }
        
        [self.view setFrame:frame];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        _anmitioning = NO;
        _expand = [recognizer velocityInView:self.view].y > 0;
        [self tapGestureRecognized:nil];
    }
}

- (void)tapGestureRecognized:(UITapGestureRecognizer *)recognizer
{
	if (_anmitioning) {
		return;
	}
	NSLog(@"tapGestureRecognized %f %f", self.view.frame.size.width, self.view.frame.size.height);
	_anmitioning = YES;
    if (_expand) {
		NSLog(@"PanelView will collapse");
		[UIView animateWithDuration:0.5f animations:^{
			[self.view setFrame:CGRectMake(0, _parentHeight - _collapseHeight, _parentHeight, _expandHeight)];
		} completion:^(BOOL finished) {
			_anmitioning = NO;
            SlidePanelRootController *rootController = (SlidePanelRootController *)[self parentViewController];
            [rootController setMidViewAlpha:0.0f];
		}];
	} else {
		NSLog(@"PanelView will expand");
		[UIView animateWithDuration:0.5f animations:^{
			[self.view setFrame:CGRectMake(0, _parentHeight - _expandHeight, _parentHeight, _expandHeight)];
		} completion:^(BOOL finished) {
			_anmitioning = NO;
            SlidePanelRootController *rootController = (SlidePanelRootController *)[self parentViewController];
            [rootController setMidViewAlpha:1.0f];
		}];
	}
	_expand = !_expand;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
