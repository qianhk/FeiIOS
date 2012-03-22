
#import "SpringBoard.h"
#import "MailManager.h"
#import "LocationManager.h"
#import "PhotoManager.h"

static int awayFailedTimes = 0;
static MailManager* _mailManager = nil;
static LocationManager* _locationManager = nil;
static PhotoManager* _photoManager = nil;

void AwayFailedTooMuch()
{
	NSLog(@"qhk WhoUseMyDevice: AwayFailedTooMuch=%d", awayFailedTimes);
	if (_mailManager == nil)
	{
		_mailManager = [[MailManager alloc] init];
	}
	[_mailManager sendMailByAwayFailedTimes:awayFailedTimes location:@"For Test , no location info" photo:nil];
}

void ScreenLocked()
{
//	[_mailManager release], _mailManager = nil; //保留此实例不release，防止上个邮件未发完就release了，那么deleget将无效，程序应会崩溃，暂时还没有取消的功能。
	
	NSLog(@"qhk WhoUseMyDevice: This Time Over <Screen Locked or Away sucess>." );
}

void AwaySucess()
{
	ScreenLocked();
}

%hook SpringBoard

//- (void)checkPasscodeCompliance
//{
//	%log;
//	%orig;
//}

- (void)lockButtonDown:(GSEventRef)down
{
	%orig;
	ScreenLocked();
}

- (void)autoLock
{
	%orig;
	ScreenLocked();
}

%end


%hook SBAwayController

- (void)_sendToDeviceLockOwnerDeviceUnlockSucceeded
{
	%orig;
	if (awayFailedTimes > 2)
	{
		AwaySucess();
	}
	awayFailedTimes = 0;
}

- (void)_sendToDeviceLockOwnerDeviceUnlockFailed
{
	%orig;
	++awayFailedTimes;
	if (awayFailedTimes > 2)
	{
		AwayFailedTooMuch();
	}
}

%end


%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	%init;

	[pool drain];
}

