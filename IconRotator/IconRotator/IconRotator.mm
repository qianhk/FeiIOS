#line 1 "/OnGit/FeiIOS/IconRotator/IconRotator/IconRotator.xm"

#import <QuartzCore/QuartzCore.h>
#import <SpringBoard/SpringBoard.h>
#import <notify.h>
#import <CaptainHook/CaptainHook.h>


static CFMutableSetRef icons;
static CATransform3D currentTransform;
static int notify_token;
static uint64_t lastOrientation;

#include <substrate.h>
@class SBIconView; @class SBAccelerometerClient; @class SBAccelerometerInterface; @class SpringBoard; 
static void (*_logos_orig$_ungrouped$SBIconView$didMoveToWindow)(SBIconView*, SEL); static void _logos_method$_ungrouped$SBIconView$didMoveToWindow(SBIconView*, SEL); static void (*_logos_orig$_ungrouped$SBIconView$dealloc)(SBIconView*, SEL); static void _logos_method$_ungrouped$SBIconView$dealloc(SBIconView*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$)(SpringBoard*, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(SpringBoard*, SEL, UIApplication *); 
static Class _logos_static_class$SBAccelerometerClient; static Class _logos_static_class$SBAccelerometerInterface; 
#line 13 "/OnGit/FeiIOS/IconRotator/IconRotator/IconRotator.xm"



static void _logos_method$_ungrouped$SBIconView$didMoveToWindow(SBIconView* self, SEL _cmd) {
	_logos_orig$_ungrouped$SBIconView$didMoveToWindow(self, _cmd);
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


static void _logos_method$_ungrouped$SBIconView$dealloc(SBIconView* self, SEL _cmd) {
	CFSetRemoveValue(icons, self);
	_logos_orig$_ungrouped$SBIconView$dealloc(self, _cmd);
}






static void _logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$(SpringBoard* self, SEL _cmd, UIApplication * application) {
	_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$(self, _cmd, application);
	
	SBAccelerometerInterface *accelerometer = [_logos_static_class$SBAccelerometerInterface sharedInstance];
	NSMutableArray **_clients = CHIvarRef(accelerometer, _clients, NSMutableArray *);
	if (_clients)
	{
		NSMutableArray *clients = *_clients;
		if (!clients)
			*_clients = clients = [[NSMutableArray alloc] init];
		SBAccelerometerClient *client = [[_logos_static_class$SBAccelerometerClient alloc] init];
		if (client)
		{
			[client setUpdateInterval:0.1];
			[clients addObject:client];
		}
		[client release];
	}
}



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

static __attribute__((constructor)) void _logosLocalCtor_ac627ab1()
{
	{{Class _logos_class$_ungrouped$SBIconView = objc_getClass("SBIconView"); MSHookMessageEx(_logos_class$_ungrouped$SBIconView, @selector(didMoveToWindow), (IMP)&_logos_method$_ungrouped$SBIconView$didMoveToWindow, (IMP*)&_logos_orig$_ungrouped$SBIconView$didMoveToWindow);MSHookMessageEx(_logos_class$_ungrouped$SBIconView, @selector(dealloc), (IMP)&_logos_method$_ungrouped$SBIconView$dealloc, (IMP*)&_logos_orig$_ungrouped$SBIconView$dealloc);Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationDidFinishLaunching:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationDidFinishLaunching$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationDidFinishLaunching$);}{_logos_static_class$SBAccelerometerClient = objc_getClass("SBAccelerometerClient"); _logos_static_class$SBAccelerometerInterface = objc_getClass("SBAccelerometerInterface"); }}
	currentTransform = CATransform3DIdentity;
	icons = CFSetCreateMutable(kCFAllocatorDefault, 0, NULL);
	notify_register_check("com.apple.springboard.rawOrientation", &notify_token);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, OrientationChangedCallback, CFSTR("com.apple.springboard.rawOrientation"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
