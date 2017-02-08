//
//  FeiPhoneInfoAppDelegate.m
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import "FeiPhoneInfoAppDelegate.h"
#import "SwitchViewController.h"

@implementation FeiPhoneInfoAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.
    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue ]>= 7.0) {
//        [application setStatusBarStyle:UIStatusBarStyleLightContent];
//        self.window.clipsToBounds = YES;
//        self.window.frame = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height - 20);
//    }

	switchController = [[SwitchViewController alloc] init];
	self.window.rootViewController = switchController;
	
	[self.window makeKeyAndVisible];
	
	NSString * tmpS = [NSString stringWithFormat:@"432%d", 1];
	NSString *str = [[NSString alloc] initWithString:tmpS];
	NSString *str2 =[[NSString alloc] initWithString:tmpS];
	NSLog(@"%p %u %p %u", str, [str retainCount], str2, [str2 retainCount]);
	str = @"123";
	NSLog(@"%p %u %p %u", str, [str retainCount], str2, [str2 retainCount]);
	[str release];
	NSLog(@"%p %u %p %u", str, [str retainCount], str2, [str2 retainCount]);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

- (void)dealloc
{
	[switchController release];
	[_window release];
    [super dealloc];
}

@end
