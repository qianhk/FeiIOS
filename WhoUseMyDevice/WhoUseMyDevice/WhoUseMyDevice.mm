#line 1 "/OnGitHub/FeiIOS/WhoUseMyDevice/WhoUseMyDevice/WhoUseMyDevice.xm"

#import "SpringBoard.h"
#import "MailManager.h"
#import "LocationManager.h"
#import "PhotoManager.h"

NSLock* lockImage = nil;
static int awayFailedTimes = 0;
static MailManager* _mailManager = nil;
static LocationManager* _locationManager = nil;
static PhotoManager* _photoManager = nil;

void AwayFailedTooMuch()
{
	NSLog(@"qhk WhoUseMyDevice: AwayFailedTooMuch=%d", awayFailedTimes);
	if (lockImage == nil)
	{
		lockImage = [[NSLock alloc] init];
	}
	[lockImage lock];
	[_mailManager sendMailByAwayFailedTimes:awayFailedTimes location:_locationManager.curLocationDescription photo:_photoManager.lastImage];
	[lockImage unlock];
}

void ScreenLocked()
{

	
	NSLog(@"qhk WhoUseMyDevice: This Time Over <Screen Locked or Away sucess>." );
	[_locationManager release], _locationManager = nil;
	[_photoManager release], _photoManager = nil;
	[lockImage release], lockImage = nil;
}

void AwaySucess()
{
	ScreenLocked();
}

#include <substrate.h>
@class SBAwayController; @class SpringBoard; 
static void (*_logos_orig$_ungrouped$SpringBoard$lockButtonDown$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$lockButtonDown$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SpringBoard$autoLock)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$autoLock(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded)(SBAwayController*, SEL); static void _logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded(SBAwayController*, SEL); static void (*_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed)(SBAwayController*, SEL); static void _logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed(SBAwayController*, SEL); 

#line 40 "/OnGitHub/FeiIOS/WhoUseMyDevice/WhoUseMyDevice/WhoUseMyDevice.xm"









static void _logos_method$_ungrouped$SpringBoard$lockButtonDown$(SpringBoard* self, SEL _cmd, GSEventRef down) {
	_logos_orig$_ungrouped$SpringBoard$lockButtonDown$(self, _cmd, down);
	ScreenLocked();
}


static void _logos_method$_ungrouped$SpringBoard$autoLock(SpringBoard* self, SEL _cmd) {
	_logos_orig$_ungrouped$SpringBoard$autoLock(self, _cmd);
	ScreenLocked();
}







static void _logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded(SBAwayController* self, SEL _cmd) {
	_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded(self, _cmd);
	AwaySucess();
	awayFailedTimes = 0;
}


static void _logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed(SBAwayController* self, SEL _cmd) {
	_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed(self, _cmd);
	++awayFailedTimes;
	if (_mailManager == nil)
	{
		_mailManager = [[MailManager alloc] init];
	}
	if (_locationManager == nil)
	{
		_locationManager = [[LocationManager alloc] init];
		[_locationManager start];
	}
	if (_photoManager == nil)
	{
		_photoManager = [[PhotoManager alloc] init];
		[_photoManager beginCapture];
	}
	if (awayFailedTimes > 1)
	{
		AwayFailedTooMuch();
	}
}




static __attribute__((constructor)) void _logosLocalCtor_ed3d2c21()
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	{{Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(lockButtonDown:), (IMP)&_logos_method$_ungrouped$SpringBoard$lockButtonDown$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$lockButtonDown$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(autoLock), (IMP)&_logos_method$_ungrouped$SpringBoard$autoLock, (IMP*)&_logos_orig$_ungrouped$SpringBoard$autoLock);Class _logos_class$_ungrouped$SBAwayController = objc_getClass("SBAwayController"); MSHookMessageEx(_logos_class$_ungrouped$SBAwayController, @selector(_sendToDeviceLockOwnerDeviceUnlockSucceeded), (IMP)&_logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded, (IMP*)&_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded);MSHookMessageEx(_logos_class$_ungrouped$SBAwayController, @selector(_sendToDeviceLockOwnerDeviceUnlockFailed), (IMP)&_logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed, (IMP*)&_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed);}}

	[pool drain];
}

