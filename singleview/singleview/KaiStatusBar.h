//
//  KaiStatusBar.h
//  iconrenamer
//
//  Created by 红凯 钱 on 12-2-19.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

@class FloatViewController;

@interface KaiStatusBar : UIWindow
{
	@private    
	
	FloatViewController* controller;
}


-(void)showWithStatusMessage:(NSString*)msg;    
-(void)hide;

-(void)setDelegate:(id)delegate;

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
//- (BOOL)shouldAutorotate;
//- (NSUInteger)supportedInterfaceOrientations;
-(void)matchDeviceOrientation;
-(void)setupForOrientation:(int)orientation;
-(void)kaisetupforDeviceOri;
-(void)setAutorotates:(BOOL)autorotates forceUpdateInterfaceOrientation:(BOOL)orientation;
@end
