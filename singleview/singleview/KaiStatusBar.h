//
//  KaiStatusBar.h
//  iconrenamer
//
//  Created by 红凯 钱 on 12-2-19.
//  Copyright (c) 2012年 SDS. All rights reserved.
//



@interface KaiStatusBar : UIWindow
{
	@private    
	UILabel *lblStatus;    
	UIActivityIndicatorView *indicator;  
	
	CGPoint lastPoint;
//	CGRect originalFrame;
	CGRect needToFrame;
	
	UIView* referenceView;
}


-(void)showWithStatusMessage:(NSString*)msg;    
-(void)hide;

@end
