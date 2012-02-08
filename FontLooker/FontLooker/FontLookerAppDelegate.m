//
//  FontLookerAppDelegate.m
//  FontLooker
//
//  Created by HJC on 11-5-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FontLookerAppDelegate.h"
#import "FontLookerViewController.h"


@implementation FontLookerAppDelegate
@synthesize mainWindow = m_mainWindow;
@synthesize mainViewController = m_mainViewController;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect windowFrame = [UIScreen mainScreen].bounds;
    self.mainWindow = [[[UIWindow alloc] initWithFrame:windowFrame] autorelease];
    
    FontLookerViewController* aController = [[[FontLookerViewController alloc] init] autorelease]; 
    UINavigationController* navigation = [[[UINavigationController alloc] initWithRootViewController:aController]
                                          autorelease];
    self.mainViewController = navigation;
    
    // Override point for customization after application launch.
    [self.mainWindow addSubview:self.mainViewController.view];
    [self.mainWindow makeKeyAndVisible];
    return YES;
}


- (void)dealloc
{
    [m_mainViewController release];
    [m_mainWindow release];
    [super dealloc];
}

@end
