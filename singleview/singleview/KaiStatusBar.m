//
//  KaiStatusBar.m
//  iconrenamer
//
//  Created by 红凯 钱 on 12-2-19.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "KaiStatusBar.h"

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
		self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2]; 
		
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
		lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];    
		lblStatus.backgroundColor = [UIColor clearColor];    
		lblStatus.textColor = [UIColor blackColor];    
		lblStatus.font = [UIFont systemFontOfSize:18.0f];    
		[self addSubview:lblStatus]; 
		
		UIWindow* win = [[UIApplication sharedApplication] keyWindow];
		NSInteger count = [[win subviews] count];
		NSLog(@"win count=%d %@", count, win);
		if (count > 0)
		{
			referenceView = [[win subviews] objectAtIndex:0];
		}
		
		

	}    
	return self;    
}    


- (void) showWithStatusMessage:(NSString*) msg {    
	if (!msg) return;    
	lblStatus.text = msg;    
	[indicator startAnimating];    
	self.hidden = NO;    
}    


- (void) hide {    
	[indicator stopAnimating];    
	self.hidden = YES;    
}    


- (void) dealloc {    
	[lblStatus release];    
	[indicator release];    
	[super dealloc];    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	lastPoint = [[touches anyObject] locationInView:referenceView];
//	NSLog(@"ttdesktop touchesbegan (%.2f, %.2f)", pointBeginDrag.x, pointBeginDrag.y);
	needToFrame = self.frame;
	self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
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

- (void)setNewFrame
{
	self.frame = needToFrame;
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
		self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2]; 
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

@end
