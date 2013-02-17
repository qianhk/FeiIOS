//
//  KaiStatusBar.m
//  iconrenamer
//
//  Created by 红凯 钱 on 12-2-19.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "KaiStatusBar.h"

#import "FloatViewController.h"

@implementation KaiStatusBar


- (id) initWithFrame:(CGRect)frame{    
	if (self = [super initWithFrame:frame]) {    
		// 将窗体置于正确的位置和级别，就是比状态栏的级别稍高即可    
		// 否则该窗体会被标准状态栏遮住，相当于web开发的zoom    
		self.windowLevel = UIWindowLevelStatusBar + 1.0f;    
//		self.windowLevel = CGFLOAT_MAX;
		// 使窗体的框架和状态栏框架一致    
//		self.frame = [UIApplication sharedApplication].statusBarFrame;  
		self.frame = frame;
		self.layer.cornerRadius = 7.5;
		
		// 创建一个灰色图片背景，使他视觉上还是一个标准状态栏的感觉    
//		UIImageView* backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];    
//		backgroundImageView.image = [[UIImage imageNamed:@"statusbar_background.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];    
//		[self addSubview:backgroundImageView];    
//		[backgroundImageView release];   
		self.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
		
		//创建一个progress    
//		indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];    
//		indicator.frame = (CGRect) {    
//			.origin.x = 2.0f,     
//			.origin.y = 3.0f,     
//			.size.width = self.frame.size.height - 6,     
//			.size.height = self.frame.size.height - 6    
//		};    
//		indicator.hidesWhenStopped = YES;    
//		[self addSubview:indicator];    
		
		//文字信息，用于和用户进行交互，最好能提示用户当前是什么操作    
		

		
		controller = [[FloatViewController alloc] initWithFrame:frame];
		UIViewController* c = self.rootViewController;
//		self.rootViewController = controller;
		frame.origin.y = 0;
		controller.view.frame = frame;
//		[self setDelegate:controller];
//		c = self.rootViewController;
		[self addSubview:controller.view];
		[self kaisetupforDeviceOri];
		
//		CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI/2);
//		[self setTransform:rotation];

	}    
	return self;    
}

-(void)kaisetupforDeviceOri {
	[self matchDeviceOrientation];
	[self setAutorotates:YES forceUpdateInterfaceOrientation:YES];
//	[self setupForOrientation:[[UIDevice currentDevice] orientation]];
	self.frame = CGRectMake(0, 200, 220, 60);
}


- (void) showWithStatusMessage:(NSString*) msg {    
	if (!msg) return;    
//	lblStatus.text = msg;    
//	[indicator startAnimating];    
	self.hidden = NO;
}    


- (void) hide {    
//	[indicator stopAnimating];    
	self.hidden = YES;
}    


- (void) dealloc {
	self.rootViewController = nil;
    [controller release];   
	[super dealloc];    
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//	NSLog(@"KaiStatusBar shouldAutorotateToInterfaceOrientation");
//	return YES;
//}
//
//// New Autorotation support.
//- (BOOL)shouldAutorotate
//{
//	NSLog(@"KaiStatusBar shouldAutorotate");
//	return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//	NSLog(@"KaiStatusBar supportedInterfaceOrientations");
//	return UIInterfaceOrientationMaskAll;
//}


@end
