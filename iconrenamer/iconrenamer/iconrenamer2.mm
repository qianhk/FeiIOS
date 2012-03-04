
//
//  Created by kai on 12-2-19.
//  Copyright (c) 2012年 njnu. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

//#import <Foundation/Foundation.h>
//#import <uikit/uikit.h>
//#import <CaptainHook/CaptainHook.h>
//#include <notify.h> // not required; for examples only
//#import <springboard/springboard.h>





//__attribute__((constructor))
//static void initialize() {
//	NSLog(@"MyExt: Loaded");
////	MSHookFunction(CFShow, replaced_CFShow, &original_CFShow);
//}

/*
%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" 
													message:@"Welcome to your iPhone Brandon!" 
												   delegate:nil 
										  cancelButtonTitle:@"Thanks" 
										  otherButtonTitles:nil];
    [alert show];
    [alert release];
}

%end
*/

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()

/*

@interface kaisubstrate3 : NSObject

@end

@implementation kaisubstrate3

-(id)init
{
	if ((self = [super init]))
	{
		NSInteger a = 0;
		++a;
		CGRect rect = CGRectMake(0, 0, 100, 50);
		rect.origin.x = 10;
	}

    return self;
}

@end


@class ClassToHook;

CHDeclareClass(ClassToHook); // declare class

CHOptimizedMethod(0, self, void, ClassToHook, messageName) // hook method (with no arguments and no return value)
{
	// write code here ...
	
	CHSuper(0, ClassToHook, messageName); // call old (original) method
}

CHOptimizedMethod(2, self, BOOL, ClassToHook, arg1, NSString*, value1, arg2, BOOL, value2) // hook method (with 2 arguments and a return value)
{
	// write code here ...

	return CHSuper(2, ClassToHook, arg1, value1, arg2, value2); // call old (original) method and return its return value
}

static void WillEnterForeground(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	// not required; for example only
}

static void ExternallyPostedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	// not required; for example only
}

CHConstructor // code block that runs immediately upon load
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	// listen for local notification (not required; for example only)
	CFNotificationCenterRef center = CFNotificationCenterGetLocalCenter();
	CFNotificationCenterAddObserver(center, NULL, WillEnterForeground, CFSTR("UIApplicationWillEnterForegroundNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	
	// listen for system-side notification (not required; for example only)
	// this would be posted using: notify_post("cn.njnu.kaisubstrate3.eventname");
	CFNotificationCenterRef darwin = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(darwin, NULL, ExternallyPostedNotification, CFSTR("cn.njnu.kaisubstrate3.eventname"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	
	// CHLoadClass(ClassToHook); // load class (that is "available now")
	// CHLoadLateClass(ClassToHook);  // load class (that will be "available later")
	
	CHHook(0, ClassToHook, messageName); // register hook
	CHHook(2, ClassToHook, arg1, arg2); // register hook
	
	[pool drain];
}
*/
