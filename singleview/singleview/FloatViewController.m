//
//  FloatViewController.m
//  singleview
//
//  Created by TTKai on 13-2-16.
//  Copyright (c) 2013年 TTPod. All rights reserved.
//

#import "FloatViewController.h"

@interface FloatViewController ()

@end

@implementation FloatViewController

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        initFrame = frame;
		initFrame.origin.x = 0;
		initFrame.origin.y = 0;
		
    }
    return self;
}

- (void)loadView
{
	[super loadView];
	
//	CGRect frame = self.view.frame;
//	self.view.bounds = initFrame;
//	[self.view setClipsToBounds:YES];
//	frame = self.view.frame;
	
	self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3];
	
	lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 20)];
	lblStatus.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.4];
	lblStatus.textColor = [UIColor blackColor];
	lblStatus.font = [UIFont systemFontOfSize:18.0f];
	lblStatus.text = @"Test FloatView rotation";
	[self.view addSubview:lblStatus];
	
	NSLog(@"FloatViewController loadView");
}

- (void)dealloc
{
	[lblStatus release];
	
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	UIWindow* win = [[UIApplication sharedApplication] keyWindow];
	NSInteger count = [[win subviews] count];
	NSLog(@"win count=%d %@", count, win);
	if (count > 0)
	{
		referenceView = [[win subviews] objectAtIndex:0];
	}
	
	NSLog(@"FloatViewController viewDidLoad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    self.view.frame = CGRectMake(0, 0, 200, 80);
	NSLog(@"FloatViewController viewWillLayoutSubviews");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	NSLog(@"FloatViewController shouldAutorotateToInterfaceOrientation");
	return YES;
}

// New Autorotation support.
- (BOOL)shouldAutorotate
{
	NSLog(@"FloatViewController shouldAutorotate");
	return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
	NSLog(@"FloatViewController supportedInterfaceOrientations");
	return UIInterfaceOrientationMaskAll;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	lastPoint = [[touches anyObject] locationInView:referenceView];
	needToFrame = self.view.frame;
	NSLog(@"ttdesktop touchesbegan (%.2f, %.2f) (frame %.1f %.1f %.1f %.1f)", lastPoint.x, lastPoint.y, needToFrame.origin.x, needToFrame.origin.y, needToFrame.size.width, needToFrame.size.height);
	self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	CGPoint curPoint = [touch locationInView:referenceView];
	needToFrame.origin.y += curPoint.y - lastPoint.y;
	if (needToFrame.origin.y >= 0 && (needToFrame.origin.y + needToFrame.size.height) <= 480)
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
		[self performSelector:@selector(setNewFrame) withObject:nil afterDelay:0];
	}
	lastPoint = curPoint;
}

- (void)touchesOver:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	CGPoint curPoint = [touch locationInView:referenceView];
	needToFrame.origin.y += curPoint.y - lastPoint.y;
	if (needToFrame.origin.y >= 0 && (needToFrame.origin.y + needToFrame.size.height) <= 480)
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
		[self performSelector:@selector(setNewFrame) withObject:nil afterDelay:0];
	}
	[self performSelector:@selector(recoverBackgroundColor) withObject:nil afterDelay:2.0f];
}

- (void)recoverBackgroundColor
{
	[UIView animateWithDuration:0.4f animations:^{
		self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
	}];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self touchesOver:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self touchesOver:touches withEvent:event];
}

- (void)setNewFrame
{
	self.view.frame = needToFrame;
}

-(BOOL)window:(id)window shouldAutorotateToInterfaceOrientation:(int)interfaceOrientation
{
	NSLog(@"FloatViewController win shouldAutorotateToInterfaceOrientation");
	return YES;
}

@end
