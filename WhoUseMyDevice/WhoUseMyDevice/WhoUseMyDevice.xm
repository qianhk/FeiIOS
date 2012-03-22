
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
//	[_mailManager release], _mailManager = nil; //保留此实例不release，防止上个邮件未发完就release了，那么deleget将无效，程序应会崩溃，暂时还没有取消的功能。
	
	NSLog(@"qhk WhoUseMyDevice: This Time Over <Screen Locked or Away sucess>." );
	[_locationManager release], _locationManager = nil;
	[_photoManager release], _photoManager = nil;
	[lockImage release], lockImage = nil;
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
	AwaySucess();
	awayFailedTimes = 0;
}

- (void)_sendToDeviceLockOwnerDeviceUnlockFailed
{
	%orig;
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

%end


%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	%init;

	[pool drain];
}

