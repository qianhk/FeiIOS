
#import <QuartzCore/QuartzCore.h>
#import <SpringBoard/SpringBoard.h>
#import <notify.h>
#import <CaptainHook/CaptainHook.h>


static CFMutableSetRef icons;
static CATransform3D currentTransform;
static int notify_token;
static uint64_t lastOrientation;

%hook SBIconView

- (void)didMoveToWindow
{
	%orig;
	if (((UIView *)self).window)
	{
		CFSetSetValue(icons, self);
		((UIView *)self).layer.sublayerTransform = currentTransform;
	}
	else
	{
		CFSetRemoveValue(icons, self);
	}
}

- (void)dealloc
{
	CFSetRemoveValue(icons, self);
	%orig;
}

%end

%hook SpringBoard

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	%orig;
	// This code is quite evil
	SBAccelerometerInterface *accelerometer = [%c(SBAccelerometerInterface) sharedInstance];
	NSMutableArray **_clients = CHIvarRef(accelerometer, _clients, NSMutableArray *);
	if (_clients)
	{
		NSMutableArray *clients = *_clients;
		if (!clients)
			*_clients = clients = [[NSMutableArray alloc] init];
		SBAccelerometerClient *client = [[%c(SBAccelerometerClient) alloc] init];
		if (client)
		{
			[client setUpdateInterval:0.1];
			[clients addObject:client];
		}
		[client release];
	}
}

%end

static void OrientationChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	uint64_t orientation = 0;
	notify_get_state(notify_token, &orientation);
	if (orientation == lastOrientation)
		return;
	switch (orientation)
	{
		case UIDeviceOrientationPortrait:
			currentTransform = CATransform3DIdentity;
			break;
		case UIDeviceOrientationPortraitUpsideDown:
			currentTransform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
			break;
		case UIDeviceOrientationLandscapeLeft:
			currentTransform = CATransform3DMakeRotation(0.5f * M_PI, 0.0f, 0.0f, 1.0f);
			break;
		case UIDeviceOrientationLandscapeRight:
			currentTransform = CATransform3DMakeRotation(-0.5f * M_PI, 0.0f, 0.0f, 1.0f);
			break;
		default:
			return;
	}
	lastOrientation = orientation;
	NSValue *value = [NSValue valueWithCATransform3D:currentTransform];
	for (UIView *view in (id)icons)
	{
		CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform"];
		animation.toValue = value;
		animation.duration = 0.2;
		animation.removedOnCompletion = YES;
		CALayer *layer = view.layer;
		animation.fromValue = [NSValue valueWithCATransform3D:layer.sublayerTransform];
		layer.sublayerTransform = currentTransform;
		[layer addAnimation:animation forKey:@"IconRotator"];
	}
}

%ctor
{
	%init;
	currentTransform = CATransform3DIdentity;
	icons = CFSetCreateMutable(kCFAllocatorDefault, 0, NULL);
	notify_register_check("com.apple.springboard.rawOrientation", &notify_token);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, OrientationChangedCallback, CFSTR("com.apple.springboard.rawOrientation"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
