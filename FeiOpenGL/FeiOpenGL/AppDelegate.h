//
//  AppDelegate.h
//  FeiOpenGL
//
//  Created by KaiKai on 11-11-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenGLView.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
	OpenGLView* _glView;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;



@end
