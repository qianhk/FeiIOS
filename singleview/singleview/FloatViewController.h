//
//  FloatViewController.h
//  singleview
//
//  Created by TTKai on 13-2-16.
//  Copyright (c) 2013年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIWindowDelegate <NSObject>
@optional
-(void)window:(id)window willAnimateSecondHalfOfRotationFromInterfaceOrientation:(int)interfaceOrientation duration:(double)duration;
-(void)window:(id)window willAnimateFirstHalfOfRotationToInterfaceOrientation:(int)interfaceOrientation duration:(double)duration;
-(void)window:(id)window willAnimateRotationToInterfaceOrientation:(int)interfaceOrientation duration:(double)duration;
-(BOOL)shouldWindowUseOnePartInterfaceRotationAnimation:(id)animation;
-(void)window:(id)window didRotateFromInterfaceOrientation:(int)interfaceOrientation;
-(void)window:(id)window didAnimateFirstHalfOfRotationToInterfaceOrientation:(int)interfaceOrientation;
-(void)window:(id)window willRotateToInterfaceOrientation:(int)interfaceOrientation duration:(double)duration;
-(id)rotatingFooterViewForWindow:(id)window;
-(id)rotatingHeaderViewForWindow:(id)window;
-(id)rotatingContentViewForWindow:(id)window;
-(BOOL)window:(id)window shouldAutorotateToInterfaceOrientation:(int)interfaceOrientation;
-(void)window:(id)window willAnimateFromContentFrame:(CGRect)contentFrame toContentFrame:(CGRect)contentFrame3;
@end

@interface FloatViewController : UIViewController<UIWindowDelegate>
{
	CGRect initFrame;
	UILabel *lblStatus;
	UIActivityIndicatorView *indicator;
	
	CGPoint lastPoint;
	//	CGRect originalFrame;
	CGRect needToFrame;
	
	UIView* referenceView;
}

- (id)initWithFrame:(CGRect)frame;

@end
