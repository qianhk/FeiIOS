//
//  TTDesktop.mm
//  TTDesktop
//
//  Created by kai on 12-2-27.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"
#include <notify.h> // not required; for examples only
#import "DesktopWindow.h"

#define KTTMessagePort "com.ttpod.ttdesktop.port"

static DesktopWindow* deskWin = nil;
static CFMessagePortRef messagePort = NULL;
static int callbacktimes = 0;

static CFDataRef messagePortCallBack(CFMessagePortRef local, SInt32 msgid, CFDataRef data, void *info)
{
	if (deskWin == nil)
	{
		deskWin = [[DesktopWindow alloc] initWithFrame:CGRectMake(0, 100, 320, 50)];
	}
	++callbacktimes;
	int datalen = CFDataGetLength(data);
	NSMutableString* str = [NSMutableString stringWithFormat:@"%d msgid=%d, data=%08X len=%d str=", callbacktimes, msgid, data, datalen];
	const UInt8* pData = CFDataGetBytePtr(data);
	for (int idx = 0; idx < datalen && idx < 100; ++idx)
	{
		[str appendFormat:@"%c", pData[idx]];
	}
	[deskWin showWithMessage:str];
	
	
	return NULL;
}


static void ExternallyPostedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
//	if (deskWin == nil)
//	{
//		deskWin = [[DesktopWindow alloc] initWithFrame:CGRectMake(0, 100, 320, 50)];
//	}
}

CHDeclareClass(SpringBoard)

CHOptimizedMethod(1, self, void, SpringBoard, applicationDidFinishLaunching, id, application)
{
	CHSuper(1, SpringBoard, applicationDidFinishLaunching, application);
	
	messagePort = CFMessagePortCreateLocal(kCFAllocatorDefault, CFSTR(KTTMessagePort), messagePortCallBack, NULL, NULL);
	if (messagePort == NULL)
	{
		NSLog(@"qhk: TTDesktop CFMessagePortCreateLocal failed");
		return;
	}
	CFRunLoopSourceRef source = CFMessagePortCreateRunLoopSource(kCFAllocatorDefault, messagePort, 0);
	CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
}


CHConstructor // code block that runs immediately upon load
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	CHLoadLateClass(SpringBoard);
	CHHook(1, SpringBoard, applicationDidFinishLaunching);
	
	// listen for system-side notification (not required; for example only)
	// this would be posted using: notify_post("com.ttpod.TTDesktop.eventname");
	CFNotificationCenterRef darwin = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(darwin, (void *)666, ExternallyPostedNotification, CFSTR("com.ttpod.TTDesktop/displayString"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	
	[pool drain];
}
