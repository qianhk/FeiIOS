#line 1 "/OnGitHub/FeiIOS/MathAlarm/MathAlarm/MathAlarm.xm"

#import <SpringBoard/SpringBoard.h>
#import "SBRemoteLocalNotificationAlert.h"
#import <CaptainHook/CaptainHook.h>
#import <notify.h>



static BOOL MAEnabled;
#ifdef PRO_VERSION
static NSInteger MADifficulty;
static NSInteger MAOperator;
static BOOL MAAllowSnooze;
#endif

static BOOL waitingForAnswer;
static NSUInteger answer;
static NSString *alertMessage;
static SBRemoteLocalNotificationAlert *activeAlert;

#include <objc/message.h>
@class SBSystemLocalNotificationAlert; @class SBAlertItemsController; @class SBApplicationController; @class SBRemoteLocalNotificationAlert; @class SBAwayController; 
static Class _logos_class$_ungrouped$SBRemoteLocalNotificationAlert, _logos_metaclass$_ungrouped$SBRemoteLocalNotificationAlert; static Class _logos_superclass$_ungrouped$SBRemoteLocalNotificationAlert; static Class _logos_supermetaclass$_ungrouped$SBRemoteLocalNotificationAlert; static id (*_logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$)(Class, SEL, id, SBApplication *);static void (*_logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone)(Class, SEL);static void (*_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$)(id, SEL, BOOL, BOOL);static void (*_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$)(id, SEL, UIAlertView *, NSInteger);static Class _logos_superclass$_ungrouped$SBAwayController; static void (*_logos_orig$_ungrouped$SBAwayController$_sendLockStateChangedNotification)(SBAwayController*, SEL);
static Class _logos_static_class$SBSystemLocalNotificationAlert; static Class _logos_static_class$SBApplicationController; static Class _logos_static_class$SBRemoteLocalNotificationAlert; static Class _logos_static_class$SBAlertItemsController; static Class _logos_static_class$SBAwayController; 
#line 21 "/OnGitHub/FeiIOS/MathAlarm/MathAlarm/MathAlarm.xm"



static id _logos_meta_super$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$(Class self, SEL _cmd, id localNotification, SBApplication * application) {return ((id (*)(Class, SEL, id, SBApplication *))class_getMethodImplementation(_logos_supermetaclass$_ungrouped$SBRemoteLocalNotificationAlert, @selector(presentWithLocalNotification:application:)))(self, _cmd, localNotification, application);}static id _logos_meta_method$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$(Class self, SEL _cmd, id localNotification, SBApplication * application) {
	return waitingForAnswer ? nil : _logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$(self, _cmd, localNotification, application);
}


static void _logos_meta_super$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone(Class self, SEL _cmd) {return ((void (*)(Class, SEL))class_getMethodImplementation(_logos_supermetaclass$_ungrouped$SBRemoteLocalNotificationAlert, @selector(stopPlayingAlertSoundOrRingtone)))(self, _cmd);}static void _logos_meta_method$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone(Class self, SEL _cmd) {
	if (!waitingForAnswer)
		_logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone(self, _cmd);
}

static inline BOOL IsMobileTimerAlarm(SBRemoteLocalNotificationAlert *self)
{

	return [[CHIvar(self, _app, SBApplication *) displayIdentifier] isEqualToString:@"com.apple.mobiletimer"];
}


static void _logos_super$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$(id self, SEL _cmd, BOOL configure, BOOL actions) {return ((void (*)(id, SEL, BOOL, BOOL))class_getMethodImplementation(_logos_superclass$_ungrouped$SBRemoteLocalNotificationAlert, @selector(configure:requirePasscodeForActions:)))(self, _cmd, configure, actions);}static void _logos_method$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$(id self, SEL _cmd, BOOL configure, BOOL actions) {
	if (IsMobileTimerAlarm(self) && MAEnabled)
	{
		if (!waitingForAnswer)
		{
			waitingForAnswer = YES;
			NSUInteger a = arc4random();
			NSUInteger b = arc4random();
#ifdef PRO_VERSION
			switch (MADifficulty)
			{
				case 0:
					a = (a % 10) + 3;
					b = (b % 10) + 3;
					break;
				case 1:
					a = (a % 25) + 4;
					b = (b % 10) + 3;
					break;
				case 2:
#endif
					a = (a % 90) + 11;
					b = (b % 10) + 3;
#ifdef PRO_VERSION
					break;
				case 3:
					a = a % 90 + 11;
					b = b % 90 + 11;
					break;
			}
#endif
			NSString *operatorString;
#ifdef PRO_VERSION
			switch (MAOperator)
			{
				case 0:
					operatorString = @"+";
					answer = a + b;
					break;
				case 1:
					operatorString = @"-";
					answer = a;
					a = a + b;
					break;
				case 2:
#endif
					operatorString = @"×";
					answer = a * b;
#ifdef PRO_VERSION
					break;
				case 3:
					operatorString = @"÷";
					answer = a;
					a = a * b;
					break;
				default:
					operatorString = nil;
					break;
			}
#endif
			[alertMessage release];
			alertMessage = [[NSString alloc] initWithFormat:@"%d %@ %d = ?", a, operatorString, b];
		}
		UIAlertView *alertView = [self alertSheet];
		alertView.title = @"Alarm";
		if ([[_logos_static_class$SBAwayController sharedAwayController] isLocked])
		{
			alertView.message = @"Unlock to deactivate";
		}
		else
		{
			alertView.message = alertMessage;
			UITextField *textField = [alertView addTextFieldWithValue:nil label:@"Answer"];
			textField.keyboardAppearance = UIKeyboardAppearanceAlert;
			textField.keyboardType = UIKeyboardTypeNumberPad;
			alertView.cancelButtonIndex = [alertView addButtonWithTitle:@"Snooze"];
			[alertView addButtonWithTitle:@"Deactivate"];
			[alertView setNumberOfRows:1];
		}
		[activeAlert autorelease];
		activeAlert = [self retain];
	}
	else
	{
		_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$(self, _cmd, configure, actions);
	}
}

static void ReactivateAlert()
{
	SBApplication *app = [[_logos_static_class$SBApplicationController sharedInstance] applicationWithDisplayIdentifier:@"com.apple.mobiletimer"];
	SBRemoteLocalNotificationAlert *newAlert = [[_logos_static_class$SBRemoteLocalNotificationAlert ?: _logos_static_class$SBSystemLocalNotificationAlert alloc] initWithApplication:app body:nil showActionButton:YES actionLabel:nil];
	if (newAlert)
	{
		newAlert.delegate = activeAlert.delegate;
		[(SBAlertItemsController *)[_logos_static_class$SBAlertItemsController sharedInstance] performSelector:@selector(activateAlertItem:) withObject:newAlert afterDelay:0.0];
	}
	[activeAlert release];
	activeAlert = newAlert;
}


static void _logos_super$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$(id self, SEL _cmd, UIAlertView * alertView, NSInteger buttonIndex) {return ((void (*)(id, SEL, UIAlertView *, NSInteger))class_getMethodImplementation(_logos_superclass$_ungrouped$SBRemoteLocalNotificationAlert, @selector(alertView:clickedButtonAtIndex:)))(self, _cmd, alertView, buttonIndex);}static void _logos_method$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$(id self, SEL _cmd, UIAlertView * alertView, NSInteger buttonIndex) {
	if (IsMobileTimerAlarm(self) && MAEnabled)
	{
		if ([alertView textFieldCount])
		{
			UITextField *textField = [alertView textFieldAtIndex:0];
			[textField resignFirstResponder];
			waitingForAnswer = ![textField.text isEqualToString:[NSString stringWithFormat:@"%d", answer]];
#ifdef PRO_VERSION
			if (waitingForAnswer && (buttonIndex == 0) && MAAllowSnooze)
				waitingForAnswer = NO;
#endif
		}
		else
		{
			waitingForAnswer = YES;
		}
		if (waitingForAnswer)
			[(SBRemoteLocalNotificationAlert *)self dismiss:1];
		else
			_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$(self, _cmd, alertView, buttonIndex);
		if (waitingForAnswer)
			ReactivateAlert();
	}
	else
	{
		_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$(self, _cmd, alertView, buttonIndex);
	}
}



static void _logos_method$_ungrouped$SBRemoteLocalNotificationAlert$didPresentAlertView$(id self, SEL _cmd, UIAlertView * alertView) {
	if ([alertView textFieldCount])
	{
		UITextField *textField = [alertView textFieldAtIndex:0];
		[textField becomeFirstResponder];
	}
}



 


static void _logos_super$_ungrouped$SBAwayController$_sendLockStateChangedNotification(SBAwayController* self, SEL _cmd) {return ((void (*)(SBAwayController*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$SBAwayController, @selector(_sendLockStateChangedNotification)))(self, _cmd);}static void _logos_method$_ungrouped$SBAwayController$_sendLockStateChangedNotification(SBAwayController* self, SEL _cmd) {
	if (waitingForAnswer && activeAlert)
	{
		waitingForAnswer = NO;
		[[activeAlert alertSheet] dismissAnimated:NO];
		[activeAlert dismiss:1];
		_logos_orig$_ungrouped$SBAwayController$_sendLockStateChangedNotification(self, _cmd);
		waitingForAnswer = YES;
		ReactivateAlert();
	}
	else
	{
		_logos_orig$_ungrouped$SBAwayController$_sendLockStateChangedNotification(self, _cmd);
	}
}



@implementation NSObject (MathAlarm)


- (void)mathAlarmTestAlarm {
	NSLog(@"qhk MathAlarm: mathAlarmTestAlarm");
	notify_post("cn.njnu.kai.mathalarm/testalarm");
}

#ifndef PRO_VERSION


- (void)mathAlarmUpgradeToPlus {
	NSLog(@"qhk MathAlarm: mathAlarmUpgradeToPlus");
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.rpetrich.mathalarmplus"]];
}

#endif

@end

static void SettingsCallback()
{
	NSLog(@"qhk MathAlarm: SettingsCallback");
	NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/cn.njnu.kai.mathalarm.plist"];
	id temp;
	temp = [settings objectForKey:@"MAEnabled"];
	MAEnabled = temp ? [temp boolValue] : YES;
#ifdef PRO_VERSION
	temp = [settings objectForKey:@"MADifficulty"];
	MADifficulty = temp ? [temp integerValue] : 2;
	temp = [settings objectForKey:@"MAOperator"];
	MAOperator = temp ? [temp integerValue] : 2;
	MAAllowSnooze = [[settings objectForKey:@"MAAllowSnooze"] boolValue];
#endif
	[settings release];
}

static __attribute__((constructor)) void _logosLocalCtor_e4a6222c()
{
	CHAutoreleasePoolForScope();
	{{_logos_class$_ungrouped$SBRemoteLocalNotificationAlert = objc_getClass("SBRemoteLocalNotificationAlert") ?: objc_getClass("SBSystemLocalNotificationAlert"); _logos_metaclass$_ungrouped$SBRemoteLocalNotificationAlert = object_getClass(_logos_class$_ungrouped$SBRemoteLocalNotificationAlert); _logos_superclass$_ungrouped$SBRemoteLocalNotificationAlert = class_getSuperclass(_logos_class$_ungrouped$SBRemoteLocalNotificationAlert); _logos_supermetaclass$_ungrouped$SBRemoteLocalNotificationAlert = class_getSuperclass(_logos_metaclass$_ungrouped$SBRemoteLocalNotificationAlert); { Class _class = _logos_metaclass$_ungrouped$SBRemoteLocalNotificationAlert;Method _method = class_getInstanceMethod(_class, @selector(presentWithLocalNotification:application:));if (_method) {_logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$ = _logos_meta_super$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$;if (!class_addMethod(_class, @selector(presentWithLocalNotification:application:), (IMP)&_logos_meta_method$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$, method_getTypeEncoding(_method))) {_logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$ = (id (*)(Class, SEL, id, SBApplication *))method_getImplementation(_method);_logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$ = (id (*)(Class, SEL, id, SBApplication *))method_setImplementation(_method, (IMP)&_logos_meta_method$_ungrouped$SBRemoteLocalNotificationAlert$presentWithLocalNotification$application$);}}}{ Class _class = _logos_metaclass$_ungrouped$SBRemoteLocalNotificationAlert;Method _method = class_getInstanceMethod(_class, @selector(stopPlayingAlertSoundOrRingtone));if (_method) {_logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone = _logos_meta_super$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone;if (!class_addMethod(_class, @selector(stopPlayingAlertSoundOrRingtone), (IMP)&_logos_meta_method$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone, method_getTypeEncoding(_method))) {_logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone = (void (*)(Class, SEL))method_getImplementation(_method);_logos_meta_orig$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone = (void (*)(Class, SEL))method_setImplementation(_method, (IMP)&_logos_meta_method$_ungrouped$SBRemoteLocalNotificationAlert$stopPlayingAlertSoundOrRingtone);}}}{ Class _class = _logos_class$_ungrouped$SBRemoteLocalNotificationAlert;Method _method = class_getInstanceMethod(_class, @selector(configure:requirePasscodeForActions:));if (_method) {_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$ = _logos_super$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$;if (!class_addMethod(_class, @selector(configure:requirePasscodeForActions:), (IMP)&_logos_method$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$ = (void (*)(id, SEL, BOOL, BOOL))method_getImplementation(_method);_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$ = (void (*)(id, SEL, BOOL, BOOL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBRemoteLocalNotificationAlert$configure$requirePasscodeForActions$);}}}{ Class _class = _logos_class$_ungrouped$SBRemoteLocalNotificationAlert;Method _method = class_getInstanceMethod(_class, @selector(alertView:clickedButtonAtIndex:));if (_method) {_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$ = _logos_super$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$;if (!class_addMethod(_class, @selector(alertView:clickedButtonAtIndex:), (IMP)&_logos_method$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$ = (void (*)(id, SEL, UIAlertView *, NSInteger))method_getImplementation(_method);_logos_orig$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$ = (void (*)(id, SEL, UIAlertView *, NSInteger))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBRemoteLocalNotificationAlert$alertView$clickedButtonAtIndex$);}}}{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$SBRemoteLocalNotificationAlert, @selector(didPresentAlertView:), (IMP)&_logos_method$_ungrouped$SBRemoteLocalNotificationAlert$didPresentAlertView$, _typeEncoding); }Class _logos_class$_ungrouped$SBAwayController = objc_getClass("SBAwayController"); _logos_superclass$_ungrouped$SBAwayController = class_getSuperclass(_logos_class$_ungrouped$SBAwayController); { Class _class = _logos_class$_ungrouped$SBAwayController;Method _method = class_getInstanceMethod(_class, @selector(_sendLockStateChangedNotification));if (_method) {_logos_orig$_ungrouped$SBAwayController$_sendLockStateChangedNotification = _logos_super$_ungrouped$SBAwayController$_sendLockStateChangedNotification;if (!class_addMethod(_class, @selector(_sendLockStateChangedNotification), (IMP)&_logos_method$_ungrouped$SBAwayController$_sendLockStateChangedNotification, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBAwayController$_sendLockStateChangedNotification = (void (*)(SBAwayController*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$SBAwayController$_sendLockStateChangedNotification = (void (*)(SBAwayController*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBAwayController$_sendLockStateChangedNotification);}}}}{_logos_static_class$SBSystemLocalNotificationAlert = objc_getClass("SBSystemLocalNotificationAlert"); _logos_static_class$SBAlertItemsController = objc_getClass("SBAlertItemsController"); _logos_static_class$SBRemoteLocalNotificationAlert = objc_getClass("SBRemoteLocalNotificationAlert"); _logos_static_class$SBApplicationController = objc_getClass("SBApplicationController"); _logos_static_class$SBAwayController = objc_getClass("SBAwayController"); }}
	CFNotificationCenterRef nc = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(nc, NULL, (CFNotificationCallback)SettingsCallback, CFSTR("cn.njnu.kai.mathalarm/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	CFNotificationCenterAddObserver(nc, NULL, (CFNotificationCallback)ReactivateAlert, CFSTR("cn.njnu.kai.mathalarm/testalarm"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	SettingsCallback();
}
