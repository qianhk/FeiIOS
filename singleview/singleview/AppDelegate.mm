//
//  AppDelegate.m
//  singleview
//
//  Created by hongkai.qian on 12-2-9.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import <sqlite3.h>
#import <objc/runtime.h>
#import "substrate.h"
#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
	[_window release];
	[_viewController release];
    [super dealloc];
}

@class ML3MusicLibrary;

//static IMP original_ML3MusicLibrary_openedDatabaseHandle = 
static sqlite3 * (*original_ML3MusicLibrary_openedDatabaseHandle)(ML3MusicLibrary*, SEL);
static sqlite3 * replaced_ML3MusicLibrary_openedDatabaseHandle(ML3MusicLibrary* self, SEL _cmd)
{
	NSLog(@"qhk singleView : self=%p openedDatabaseHandle gaga", self);
	
	object_setInstanceVariable(self, "_enableWrites", (void *)YES);
	
	return original_ML3MusicLibrary_openedDatabaseHandle(self, _cmd);
}

static BOOL (*original_ML3MusicLibrary_writable)(ML3MusicLibrary*, SEL);
static BOOL replaced_ML3MusicLibrary_writable(ML3MusicLibrary* self, SEL _cmd)
{
	NSLog(@"qhk singleView : self=%p writable haha", self);
	
	object_setInstanceVariable(self, "_enableWrites", (void *)YES);
	
	return original_ML3MusicLibrary_writable(self, _cmd);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSLog(@"See Time 1 application:didFinishLanuchingWithOptions");
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
	self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
	Class _ML3MusicLibrary = objc_getClass("ML3MusicLibrary");
	MSHookMessageEx(_ML3MusicLibrary, @selector(openedDatabaseHandle), (IMP)&replaced_ML3MusicLibrary_openedDatabaseHandle, (IMP*)&original_ML3MusicLibrary_openedDatabaseHandle);

	MSHookMessageEx(_ML3MusicLibrary, @selector(writable), (IMP)&replaced_ML3MusicLibrary_writable, (IMP*)&original_ML3MusicLibrary_writable);
#endif

	NSLog(@"See Time 2 application:didFinishLanuchingWithOptions");
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

@end
