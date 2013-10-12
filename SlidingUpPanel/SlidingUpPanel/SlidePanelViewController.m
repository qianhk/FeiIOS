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
