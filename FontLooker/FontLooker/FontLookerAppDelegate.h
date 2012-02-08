//
//  FontLookerAppDelegate.h
//  FontLooker
//
//  Created by HJC on 11-5-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FontLookerAppDelegate : NSObject <UIApplicationDelegate> 
{
@private
    UIWindow*           m_mainWindow;
    UIViewController*   m_mainViewController;
}

@property (nonatomic, retain)   UIWindow*           mainWindow;
@property (nonatomic, retain)   UIViewController*   mainViewController;

@end
