//
//  AppDelegate.h
//  HelloOpenGL
//
//  Created by KaiKai on 11-10-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OpenGLView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
	OpenGLView* _glView;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet OpenGLView *glView;

@end
