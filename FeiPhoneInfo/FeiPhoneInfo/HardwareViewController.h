//
//  HardwareViewController.h
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-28.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIDevice-Reachability.h"

@class Reachability;

@interface HardwareViewController : BaseViewController <ReachabilityWatcher>
{
	NSTimer* _timer;
	Reachability *reachable;
	
	NSNumber* _lastFreeDiskSpace;
	
	NSString* _lastFreeDiskSpaceStr;
	NSString* _lastUserMemoryStr;
	NSString* _lastMemoryWire;
	NSString* _lastMemoryActive;
	NSString* _lastMemoryInactive;
	NSString* _lastMemoryFree;
	
	int pageSize;
}

@end
