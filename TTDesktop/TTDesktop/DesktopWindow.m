//
//  DesktopWindow.m
//
//  Created by kai on 12-2-19.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import "DesktopWindow.h"

@implementation DesktopWindow

//static CGRect winPos(CGRectMake(50, 50, 220, 50));


- (id)initWithFrame:(CGRect)frame
{    
	if (self = [super initWithFrame:frame])
	{    
//		self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		self.windowLevel = MAXFLOAT;
 
		self.frame = frame;
		
//		UIImageView* backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];    
//		backgroundImageView.image = [[UIImage imageNamed:@"statusbar_background.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];    
//		[self addSubview:backgroundImageView];    
//		[backgroundImageView release];   
		self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0 alpha:0.6]; 
		
		lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];    
		lblStatus.backgroundColor = [UIColor clearColor];    
		lblStatus.textColor = [UIColor blackColor];    
		lblStatus.font = [UIFont systemFontOfSize:12.0f];  
		lblStatus.numberOfLines = 0;
		[self addSubview:lblStatus];            
	}
	
	return self;    
}    


- (void)showWithMessage:(NSString*)msg
{       
	lblStatus.text = msg ?: @"";      
	self.hidden = NO;    
}    


- (void)hide
{       
	self.hidden = YES;    
}    


- (void)dealloc
{    
	[lblStatus release];        
	[super dealloc];    
}    

@end
