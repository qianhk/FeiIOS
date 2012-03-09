//
//  DesktopSettingWindow.m
//  singleview
//
//  Created by hongkai.qian on 12-3-9.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "DesktopSettingWindow.h"

@implementation DesktopSettingWindow

- (UIButton *)makeButtonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image action:(SEL)action tag:(NSInteger)tag
{
	UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = frame;
	button.showsTouchWhenHighlighted = YES;
	button.tag = tag;
	[button setTitle:title forState:UIControlStateNormal];
	[button setImage:image forState:UIControlStateNormal];
	[button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
	
	return button;
}

- (id)initWithFrame:(CGRect)frame
{    
	if (self = [super initWithFrame:frame])
	{    
		self.windowLevel = 5000000.0f;
		self.layer.cornerRadius = 7.5;
		self.frame = frame;
		self.backgroundColor = [UIColor yellowColor];
		
		btnFontSizeSmaller = [[self makeButtonWithFrame:CGRectMake(10, 5, 50, 30) title:@"Smaller" image:nil action:@selector(btnChangeFontSizeClicked:) tag:0] retain];
		btnFontSizeBigger = [[self makeButtonWithFrame:CGRectMake(70, 5, 50, 30) title:@"Bigger" image:nil action:@selector(btnChangeFontSizeClicked:) tag:0] retain];
		
		btnOK = [[self makeButtonWithFrame:CGRectMake(250, 5, 50, 30) title:@"OK" image:nil action:@selector(btnOkClicked:) tag:0] retain];
		
		[self addSubview:btnFontSizeSmaller];
		[self addSubview:btnFontSizeBigger];
		[self addSubview:btnOK];
	}
	
	return self;
}

- (void)btnChangeFontSizeClicked:(id)sender
{
	if (sender == btnFontSizeSmaller)
	{
		
	}
	else if (sender == btnFontSizeBigger)
	{
		
	}
}

- (void)btnOkClicked:(id)sender
{
	self.hidden = YES;
	[self release];
}

- (void)dealloc
{
	[btnFontSizeSmaller release];
	[btnFontSizeBigger release];
	
	[arrBtnColor release];
	[btnOK release];
}


@end
