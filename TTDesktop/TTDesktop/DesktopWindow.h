//
//  DesktopWindow.h
//
//  Created by kai on 12-2-19.
//  Copyright (c) 2012年 SDS. All rights reserved.
//


@interface DesktopWindow : UIWindow
{
@private    
	UILabel *lblStatus;    
}


-(void)showWithMessage:(NSString*)msg;    
-(void)hide;

@end
