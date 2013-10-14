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

const float Animation_Duration = 0.5f;

@implementation SlidePanelViewController

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"SlidePanelViewController willRotateToInterfaceOrientation %@", NSStringFromCGRect(self.view.frame));
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"SlidePanelViewController didRotateFromInterfaceOrientation %@", NSStringFromCGRect(self.view.frame));
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
    [self.view setAutoresizesSubviews:YES];
	
	CGRect rect = _topGrayView.frame;
	rect.size.width = self.view.frame.size.width;
	_topGrayView.frame = rect;
    [_topGrayView setTranslatesAutoresizingMaskIntoConstraints:YES];
    _topGrayView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _dragView = _topGrayView;
	
//	if (self.dragView == nil) {
//		self.dragView = self.view;
//	}
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 50)];
    [self.view addSubview:testView];
    testView.backgroundColor = [UIColor blueColor];
    testView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	
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
		float shoudBottomYPos = _parentHeight - _collapseHeight;
        if (frame.origin.y > shoudBottomYPos) {
            frame.origin.y = shoudBottomYPos;
        } else if (frame.origin.y < _parentHeight - _expandHeight) {
            frame.origin.y = _parentHeight - _expandHeight;
        }
        
        [self.view setFrame:frame];
		float canDragHeight = _expandHeight - _collapseHeight;
		float dragedHeight = shoudBottomYPos - frame.origin.y;
		SlidePanelRootController *rootController = (SlidePanelRootController *)[self parentViewController];
		[rootController setMidViewAlpha:dragedHeight / canDragHeight];
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
	NSLog(@"tapGestureRecognized frame=%@ window=%@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect([[UIApplication sharedApplication] keyWindow].frame));
	_anmitioning = YES;
	SlidePanelRootController *rootController = (SlidePanelRootController *)[self parentViewController];
	
    if (_expand) {
		NSLog(@"PanelView will collapse");
		[UIView animateWithDuration:Animation_Duration animations:^{
			[self.view setFrame:CGRectMake(0, _parentHeight - _collapseHeight, self.view.frame.size.width, _expandHeight)];
		} completion:^(BOOL finished) {
			_anmitioning = NO;
		}];
		[rootController setMidViewAlpha:0.0f duration:Animation_Duration];
	} else {
		NSLog(@"PanelView will expand");
		[UIView animateWithDuration:Animation_Duration animations:^{
			[self.view setFrame:CGRectMake(0, _parentHeight - _expandHeight, self.view.frame.size.width, _expandHeight)];
		} completion:^(BOOL finished) {
			_anmitioning = NO;
		}];
		[rootController setMidViewAlpha:1.0f duration:Animation_Duration];
	}
	_expand = !_expand;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
