//
//  KaiStatusBar.m
//  iconrenamer
//
//  Created by 红凯 钱 on 12-2-19.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

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
		self.frame = CGRectMake(50, 50, 220, 50);
		
		// 创建一个灰色图片背景，使他视觉上还是一个标准状态栏的感觉    
//		UIImageView* backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];    
//		backgroundImageView.image = [[UIImage imageNamed:@"statusbar_background.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];    
//		[self addSubview:backgroundImageView];    
//		[backgroundImageView release];   
		self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0 alpha:0.6]; 
		
		//创建一个progress    
		indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];    
		indicator.frame = (CGRect) {    
			.origin.x = 2.0f,     
			.origin.y = 3.0f,     
			.size.width = self.frame.size.height - 6,     
			.size.height = self.frame.size.height - 6    
		};    
		indicator.hidesWhenStopped = YES;    
		[self addSubview:indicator];    
		
		//文字信息，用于和用户进行交互，最好能提示用户当前是什么操作    
		lblStatus = [[UILabel alloc] initWithFrame:(CGRect){.origin.x = self.frame.size.height, .origin.y = 0.0f, .size.width = 200.0f, .size.height = self.frame.size.height}];    
		lblStatus.backgroundColor = [UIColor clearColor];    
		lblStatus.textColor = [UIColor blackColor];    
		lblStatus.font = [UIFont systemFontOfSize:18.0f];    
		[self addSubview:lblStatus];            
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

@end
