//
//  kainotifyController.m
//  kainotify
//
//  Created by hongkai.qian on 12-2-9.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <SpringBoard/SBWiFiManager.h>
#import <QuartzCore/QuartzCore.h>

#import "kainotifyController.h"

@implementation kainotifyController

-(id)init
{
	if ((self = [super init]))
	{
//		_timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerCome) userInfo:nil repeats:YES];
	}

	return self;
}

- (void)timerCome
{
	if (lbl != nil)
	{
		lbl.text = [NSString stringWithFormat:@"Hell0, world,凯凯say: %d", ++_js];
	}
}

- (void)viewDidAppear
{
	_timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerCome) userInfo:nil repeats:YES];
	SBWiFiManager* wifiManager = (SBWiFiManager *)[objc_getClass("SBWiFiManager") sharedInstance];
	_wifiStatus.text = [wifiManager wiFiEnabled] ? @"Wifi On" : @"Wifi Off";
}

- (void)viewWillDisappear
{
	[_timer invalidate];
	_timer = nil;
//	lbl.text = @"Hello, World viewWillDisappear";
	
}

-(void)dealloc
{
//	[_timer release];
	[_timer invalidate];
	[lbl release];
	[_wifiStatus release];
	[_view release];
	[super dealloc];
}

- (UIView *)view
{
	if (_view == nil)
	{
		_view = [[UIView alloc] initWithFrame:CGRectMake(2, 0, 316, 71)];

		UIImage *bg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/kainotify.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:71];
		UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
		bgView.frame = CGRectMake(0, 0, 316, 71);
		[_view addSubview:bgView];
		[bgView release];

		lbl = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 250, 71)];
		lbl.backgroundColor = [UIColor clearColor];
		lbl.textColor = [UIColor whiteColor];
		lbl.text = @"Hello, World 凯1234!";
		lbl.textAlignment = UITextAlignmentRight;
		[_view addSubview:lbl];
		[lbl release];
		
		_wifiStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 66, 71)];
		_wifiStatus.backgroundColor = [UIColor clearColor];
		_wifiStatus.textColor = [UIColor whiteColor];
		[_view addSubview:_wifiStatus];
		[_wifiStatus release];
		
//		UIImage* image = [UIImage
		
		UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 72, 37)];
		[btn1 setTitle:@"上一首" forState:UIControlStateNormal];
		[btn1 addTarget:self action:@selector(btn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
		[_view addSubview:btn1];
		[btn1 release];
		
		UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[btn2 setFrame:CGRectMake(110, 10, 72, 37)];
		[btn2 setTitle:@"下一首" forState:UIControlStateNormal];
		[btn2 addTarget:self action:@selector(btn2Clicked:) forControlEvents:UIControlEventTouchDown];
		//	btn2
		[self.view addSubview:btn2];
	}

	return _view;
}

- (void)btn1Clicked:(id)sender
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Btn1Clicked" message:@"you clicked button" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)btn2Clicked:(id)sender
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Btn2Clicked" message:@"you clicked button" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	lbl.text = @"Clicked button 2";
}

- (float)viewHeight
{
	return 71.0f;
}

@end