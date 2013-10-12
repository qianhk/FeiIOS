//
//  SlidePanelViewController.m
//  SlidingUpPanel
//
//  Created by TTKai on 13-10-12.
//  Copyright (c) 2013年 njnu. All rights reserved.
//

#import "SlidePanelViewController.h"

@interface SlidePanelViewController ()
{
	BOOL _expand;
	BOOL _anmitioning;
	float _originYPos;
}
@end

@implementation SlidePanelViewController

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
	
	if (self.dragView == nil) {
		self.dragView = self.view;
	}
	
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self.dragView addGestureRecognizer:tapRecognizer];
	
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [self.view addGestureRecognizer:panRecognizer];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateBegan) {
//        [self presentMenuViewControllerWithAnimatedApperance:NO];
    }
	
    CGPoint point = [recognizer translationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
		_originYPos = self.view.frame.origin.y;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.view.frame;
		frame.origin.y = point.y + _originYPos;
        
        [self.view setFrame:frame];
    }
    
//    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        if (self.frostedViewController.direction == REFrostedViewControllerDirectionLeft) {
//            if ([recognizer velocityInView:self.view].x < 0) {
//                [self hide];
//            } else {
//                [self show];
//            }
//        }
//        
//        if (self.frostedViewController.direction == REFrostedViewControllerDirectionRight) {
//            if ([recognizer velocityInView:self.view].x < 0) {
//                [self show];
//            } else {
//                [self hide];
//            }
//        }
//        
//        if (self.frostedViewController.direction == REFrostedViewControllerDirectionTop) {
//            if ([recognizer velocityInView:self.view].y < 0) {
//                [self hide];
//            } else {
//                [self show];
//            }
//        }
//        
//        if (self.frostedViewController.direction == REFrostedViewControllerDirectionBottom) {
//            if ([recognizer velocityInView:self.view].y < 0) {
//                [self show];
//            } else {
//                [self hide];
//            }
//        }
//    }
}

- (void)tapGestureRecognized:(UITapGestureRecognizer *)recognizer
{
	if (_anmitioning) {
		return;
	}
	
	_anmitioning = YES;
    if (_expand) {
		NSLog(@"PanelView will collapse");
		[UIView animateWithDuration:0.5f animations:^{
			[self.view setFrame:CGRectMake(0, _parentHeight - _collapseHeight, _parentHeight, _collapseHeight)];
		} completion:^(BOOL finished) {
			_anmitioning = NO;
		}];
	} else {
		NSLog(@"PanelView will expand");
		[UIView animateWithDuration:0.5f animations:^{
			[self.view setFrame:CGRectMake(0, _parentHeight - _expandHeight, _parentHeight, _expandHeight)];
		} completion:^(BOOL finished) {
			_anmitioning = NO;
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
