#line 1 "/OnGit/FeiIOS/RunningIndicator/RunningIndicator/RunningIndicator.xm"
#import "SpringBoard.h"
#import <GraphicsServices/GSEvent.h>

static NSMutableSet *runningIcons;
static BOOL showCloseButtons;
static BOOL showRunningIndicator;



#include <substrate.h>
@class SBApplicationIcon; @class SBAwayController; @class SBScreenFlash; @class SBSearchController; @class SBIconViewMap; @class SBIconView; @class SBIconModel; @class SBIconController; @class SBStatusBarDataManager; @class SpringBoard; @class SBAppSwitcherController; 
static void (*_logos_orig$_ungrouped$SBAppSwitcherController$applicationLaunched$)(SBAppSwitcherController*, SEL, SBApplication *); static void _logos_method$_ungrouped$SBAppSwitcherController$applicationLaunched$(SBAppSwitcherController*, SEL, SBApplication *); static void (*_logos_orig$_ungrouped$SBAppSwitcherController$applicationDied$)(SBAppSwitcherController*, SEL, SBApplication *); static void _logos_method$_ungrouped$SBAppSwitcherController$applicationDied$(SBAppSwitcherController*, SEL, SBApplication *); static void (*_logos_orig$_ungrouped$SBApplicationIcon$closeBoxTapped)(SBApplicationIcon*, SEL); static void _logos_method$_ungrouped$SBApplicationIcon$closeBoxTapped(SBApplicationIcon*, SEL); static void (*_logos_orig$_ungrouped$SBApplicationIcon$setShowsCloseBox$)(SBApplicationIcon*, SEL, BOOL); static void _logos_method$_ungrouped$SBApplicationIcon$setShowsCloseBox$(SBApplicationIcon*, SEL, BOOL); static void (*_logos_orig$_ungrouped$SBIconView$closeBoxTapped)(SBIconView*, SEL); static void _logos_method$_ungrouped$SBIconView$closeBoxTapped(SBIconView*, SEL); static void (*_logos_orig$_ungrouped$SBIconView$setShowsCloseBox$animated$)(SBIconView*, SEL, BOOL, BOOL); static void _logos_method$_ungrouped$SBIconView$setShowsCloseBox$animated$(SBIconView*, SEL, BOOL, BOOL); static void (*_logos_orig$_ungrouped$SBIconViewMap$_addIconView$forIcon$)(SBIconViewMap*, SEL, SBIconView *, SBIcon *); static void _logos_method$_ungrouped$SBIconViewMap$_addIconView$forIcon$(SBIconViewMap*, SEL, SBIconView *, SBIcon *); static void (*_logos_orig$_ungrouped$SpringBoard$_lockdownActivationChanged$)(SpringBoard*, SEL, id); static void _logos_method$_ungrouped$SpringBoard$_lockdownActivationChanged$(SpringBoard*, SEL, id); static void (*_logos_orig$_ungrouped$SpringBoard$_powerDownNow)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$_powerDownNow(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$_rebootNow)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$_rebootNow(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$reboot)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$reboot(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$powerDown)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$powerDown(SpringBoard*, SEL); static BOOL (*_logos_orig$_ungrouped$SpringBoard$isPoweringDown)(SpringBoard*, SEL); static BOOL _logos_method$_ungrouped$SpringBoard$isPoweringDown(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$powerDownRequested$)(SpringBoard*, SEL, id); static void _logos_method$_ungrouped$SpringBoard$powerDownRequested$(SpringBoard*, SEL, id); static void (*_logos_orig$_ungrouped$SpringBoard$powerDownCanceled$)(SpringBoard*, SEL, id); static void _logos_method$_ungrouped$SpringBoard$powerDownCanceled$(SpringBoard*, SEL, id); static void (*_logos_orig$_ungrouped$SpringBoard$hideSpringBoardStatusBar)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$hideSpringBoardStatusBar(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$showSpringBoardStatusBar)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$showSpringBoardStatusBar(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$frontDisplayDidChange)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$frontDisplayDidChange(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$didIdle)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$didIdle(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$showSimulatedScreenBlank)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$showSimulatedScreenBlank(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$hideSimulatedScreenBlank)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$hideSimulatedScreenBlank(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$quitTopApplication$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$quitTopApplication$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SpringBoard$applicationExited$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$applicationExited$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SpringBoard$anotherApplicationFinishedLaunching$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$anotherApplicationFinishedLaunching$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SpringBoard$applicationSuspend$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$applicationSuspend$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SpringBoard$applicationSuspended$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$applicationSuspended$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SpringBoard$applicationSuspendedSettingsUpdated$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$applicationSuspendedSettingsUpdated$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SpringBoard$applicationDidBecomeActive$)(SpringBoard*, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$applicationDidBecomeActive$(SpringBoard*, SEL, UIApplication *); static void (*_logos_orig$_ungrouped$SpringBoard$applicationDidEnterBackground$)(SpringBoard*, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$applicationDidEnterBackground$(SpringBoard*, SEL, UIApplication *); static void (*_logos_orig$_ungrouped$SpringBoard$applicationWillEnterForeground$)(SpringBoard*, SEL, UIApplication *); static void _logos_method$_ungrouped$SpringBoard$applicationWillEnterForeground$(SpringBoard*, SEL, UIApplication *); static void (*_logos_orig$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$)(SpringBoard*, SEL, int); static void _logos_method$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$(SpringBoard*, SEL, int); static void (*_logos_orig$_ungrouped$SpringBoard$handleKeyEvent$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$handleKeyEvent$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SpringBoard$wipeDeviceNow)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$wipeDeviceNow(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$_setMenuButtonTimer$)(SpringBoard*, SEL, id); static void _logos_method$_ungrouped$SpringBoard$_setMenuButtonTimer$(SpringBoard*, SEL, id); static void (*_logos_orig$_ungrouped$SpringBoard$checkPasscodeCompliance)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$checkPasscodeCompliance(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$lockButtonDown$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$lockButtonDown$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SpringBoard$_setLockButtonTimer$)(SpringBoard*, SEL, id); static void _logos_method$_ungrouped$SpringBoard$_setLockButtonTimer$(SpringBoard*, SEL, id); static void (*_logos_orig$_ungrouped$SpringBoard$lockButtonWasHeld)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$lockButtonWasHeld(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$systemWillSleep)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$systemWillSleep(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$setBacklightLevel$)(SpringBoard*, SEL, float); static void _logos_method$_ungrouped$SpringBoard$setBacklightLevel$(SpringBoard*, SEL, float); static void (*_logos_orig$_ungrouped$SpringBoard$setBacklightLevel$permanently$)(SpringBoard*, SEL, float, BOOL); static void _logos_method$_ungrouped$SpringBoard$setBacklightLevel$permanently$(SpringBoard*, SEL, float, BOOL); static void (*_logos_orig$_ungrouped$SpringBoard$dimToBlackKeepingTouchOn)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$dimToBlackKeepingTouchOn(SpringBoard*, SEL); static BOOL (*_logos_orig$_ungrouped$SpringBoard$shouldDimToBlackInsteadOfLock)(SpringBoard*, SEL); static BOOL _logos_method$_ungrouped$SpringBoard$shouldDimToBlackInsteadOfLock(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$autoLock)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$autoLock(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$noteCaseHardwarePresent)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$noteCaseHardwarePresent(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$caseLatchWantsToAttemptLock)(SpringBoard*, SEL); static void _logos_method$_ungrouped$SpringBoard$caseLatchWantsToAttemptLock(SpringBoard*, SEL); static void (*_logos_orig$_ungrouped$SpringBoard$lockDevice$)(SpringBoard*, SEL, GSEventRef); static void _logos_method$_ungrouped$SpringBoard$lockDevice$(SpringBoard*, SEL, GSEventRef); static void (*_logos_orig$_ungrouped$SBScreenFlash$flashColor$)(SBScreenFlash*, SEL, UIColor *); static void _logos_method$_ungrouped$SBScreenFlash$flashColor$(SBScreenFlash*, SEL, UIColor *); static void (*_logos_orig$_ungrouped$SBStatusBarDataManager$_updateBatteryPercentItem)(SBStatusBarDataManager*, SEL); static void _logos_method$_ungrouped$SBStatusBarDataManager$_updateBatteryPercentItem(SBStatusBarDataManager*, SEL); static void (*_logos_orig$_ungrouped$SBSearchController$searchBarSearchButtonClicked$)(SBSearchController*, SEL, UISearchBar *); static void _logos_method$_ungrouped$SBSearchController$searchBarSearchButtonClicked$(SBSearchController*, SEL, UISearchBar *); static void (*_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded)(SBAwayController*, SEL); static void _logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded(SBAwayController*, SEL); static void (*_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed)(SBAwayController*, SEL); static void _logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed(SBAwayController*, SEL); 
static Class _logos_static_class$SBIconViewMap; static Class _logos_static_class$SBIconModel; static Class _logos_static_class$SBIconController; 
#line 10 "/OnGit/FeiIOS/RunningIndicator/RunningIndicator/RunningIndicator.xm"



static void _logos_method$_ungrouped$SBAppSwitcherController$applicationLaunched$(SBAppSwitcherController* self, SEL _cmd, SBApplication * application) {
	NSLog(@"qhk runningIndicator: applicationLaunched self=%p bundleIdentifier:%@", self, application.bundleIdentifier);
	SBIconModel *iconModel = [_logos_static_class$SBIconModel sharedInstance];
	SBIcon *icon = [iconModel applicationIconForDisplayIdentifier:[application displayIdentifier]];
	if (icon)
	{
		[runningIcons addObject:icon];
		if (showRunningIndicator || showCloseButtons)
		{
			SBIconView *iconView = _logos_static_class$SBIconViewMap ? [[_logos_static_class$SBIconViewMap homescreenMap] mappedIconViewForIcon:icon] : (SBIconView *)icon;
			if (iconView)
			{
				if ([icon respondsToSelector:@selector(setShowsImages:)])
					[icon setShowsImages:YES];
				[iconView prepareDropGlow];
				UIImageView *dropGlow = [iconView dropGlow];
				dropGlow.image = [UIImage imageNamed:@"RunningGlow"];
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:1.0];
				[iconView showDropGlow:showRunningIndicator];
				[iconView setShowsCloseBox:showCloseButtons];
				[UIView commitAnimations];
			}
		}
	}
	_logos_orig$_ungrouped$SBAppSwitcherController$applicationLaunched$(self, _cmd, application);
}


static void _logos_method$_ungrouped$SBAppSwitcherController$applicationDied$(SBAppSwitcherController* self, SEL _cmd, SBApplication * application) {
	NSLog(@"qhk runningIndicator: applicationDied self=%p %@", self, application);
	SBIconModel *iconModel = [_logos_static_class$SBIconModel sharedInstance];
	SBIcon *icon = [iconModel applicationIconForDisplayIdentifier:[application displayIdentifier]];
	if (icon)
	{
		[runningIcons removeObject:icon];
		if (showRunningIndicator || showCloseButtons)
		{
			SBIconView *iconView = _logos_static_class$SBIconViewMap ? [[_logos_static_class$SBIconViewMap homescreenMap] mappedIconViewForIcon:icon] : (SBIconView *)icon;
			if (iconView)
			{
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:1.0];
				[iconView showDropGlow:NO];
				[iconView setShowsCloseBox:NO];
				[UIView commitAnimations];
			}
		}
	}
	_logos_orig$_ungrouped$SBAppSwitcherController$applicationDied$(self, _cmd, application);
}













































 


static void _logos_method$_ungrouped$SBApplicationIcon$closeBoxTapped(SBApplicationIcon* self, SEL _cmd) {

	if (showCloseButtons && [runningIcons containsObject:self])
	{
		SBIconController *iconController = [_logos_static_class$SBIconController sharedInstance];
		if (![iconController isEditing] || ![iconController canUninstallIcon:self])
		{
			[[self application] kill];
			return;
		}
	}
	_logos_orig$_ungrouped$SBApplicationIcon$closeBoxTapped(self, _cmd);
}


static void _logos_method$_ungrouped$SBApplicationIcon$setShowsCloseBox$(SBApplicationIcon* self, SEL _cmd, BOOL newValue) {

	_logos_orig$_ungrouped$SBApplicationIcon$setShowsCloseBox$(self, _cmd, newValue || ([runningIcons containsObject:self] && showCloseButtons));
}



 


static void _logos_method$_ungrouped$SBIconView$closeBoxTapped(SBIconView* self, SEL _cmd) {

	SBApplicationIcon *icon = (SBApplicationIcon *)self.icon;
	if (showCloseButtons && [runningIcons containsObject:icon])
	{
		SBIconController *iconController = [_logos_static_class$SBIconController sharedInstance];
		if (![iconController isEditing] || ![iconController canUninstallIcon:icon])
		{
			[[icon application] kill];
			return;
		}
	}
	_logos_orig$_ungrouped$SBIconView$closeBoxTapped(self, _cmd);
}


static void _logos_method$_ungrouped$SBIconView$setShowsCloseBox$animated$(SBIconView* self, SEL _cmd, BOOL newValue, BOOL animated) {

	_logos_orig$_ungrouped$SBIconView$setShowsCloseBox$animated$(self, _cmd, newValue || ([runningIcons containsObject:self.icon] && showCloseButtons), animated);
}






static void _logos_method$_ungrouped$SBIconViewMap$_addIconView$forIcon$(SBIconViewMap* self, SEL _cmd, SBIconView * iconView, SBIcon * icon) {
	_logos_orig$_ungrouped$SBIconViewMap$_addIconView$forIcon$(self, _cmd, iconView, icon);
	if ([runningIcons containsObject:icon])
	{
		[iconView prepareDropGlow];
		UIImageView *dropGlow = [iconView dropGlow];
		dropGlow.image = [UIImage imageNamed:@"RunningGlow"];
		[iconView showDropGlow:YES];
		[iconView setShowsCloseBox:showCloseButtons];
	}
}



static void LoadSettings()
{
	NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/cn.njnu.kai.runningindicator.plist"];
	id temp = [settings objectForKey:@"RIShowCloseButtons"];
	showCloseButtons = temp ? [temp boolValue] : YES;
	temp = [settings objectForKey:@"RIShowRunningindicator"];
	showRunningIndicator = temp ? [temp boolValue] : YES;
	[settings release];
}

static void ShowRunningIndicator(SBIconView* iconView, SBIcon* icon)
{
	if (showRunningIndicator)
	{
		if ([icon respondsToSelector:@selector(setShowsImages:)])
			[icon setShowsImages:YES];
		[iconView prepareDropGlow];
		UIImageView *dropGlow = [iconView dropGlow];
		dropGlow.image = [UIImage imageNamed:@"RunningGlow"];
		[iconView showDropGlow:YES];
	}
	else
	{
		[iconView showDropGlow:NO];
	}
}

static void SettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{

	LoadSettings();
	if (_logos_static_class$SBIconViewMap)
	{
		SBIconViewMap *map = [_logos_static_class$SBIconViewMap homescreenMap];
		for (SBIcon *icon in runningIcons)
		{
			SBIconView* iconView = [map mappedIconViewForIcon:icon];
			[iconView setShowsCloseBox:showCloseButtons];
			ShowRunningIndicator(iconView, icon);
		}
	}
	else
	{
		for (SBIcon* icon in runningIcons)
		{
			[icon setShowsCloseBox:showCloseButtons];
			ShowRunningIndicator((SBIconView *)icon, icon);
		}
	}
}




static void _logos_method$_ungrouped$SpringBoard$_lockdownActivationChanged$(SpringBoard* self, SEL _cmd, id changed) {
	NSLog(@"qhk runningIndicator: _lockdownActivationChanged %@", changed);
	_logos_orig$_ungrouped$SpringBoard$_lockdownActivationChanged$(self, _cmd, changed);
}


static void _logos_method$_ungrouped$SpringBoard$_powerDownNow(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> _powerDownNow]", self);
	_logos_orig$_ungrouped$SpringBoard$_powerDownNow(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$_rebootNow(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> _rebootNow]", self);
	_logos_orig$_ungrouped$SpringBoard$_rebootNow(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$reboot(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> reboot]", self);
	_logos_orig$_ungrouped$SpringBoard$reboot(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$powerDown(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> powerDown]", self);
	_logos_orig$_ungrouped$SpringBoard$powerDown(self, _cmd);
}


static BOOL _logos_method$_ungrouped$SpringBoard$isPoweringDown(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> isPoweringDown]", self);
	return _logos_orig$_ungrouped$SpringBoard$isPoweringDown(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$powerDownRequested$(SpringBoard* self, SEL _cmd, id requested) {
	NSLog(@"-[<SpringBoard: %p> powerDownRequested:%@]", self, requested);
	_logos_orig$_ungrouped$SpringBoard$powerDownRequested$(self, _cmd, requested);
}


static void _logos_method$_ungrouped$SpringBoard$powerDownCanceled$(SpringBoard* self, SEL _cmd, id canceled) {
	NSLog(@"-[<SpringBoard: %p> powerDownCanceled:%@]", self, canceled);
	_logos_orig$_ungrouped$SpringBoard$powerDownCanceled$(self, _cmd, canceled);
}


static void _logos_method$_ungrouped$SpringBoard$hideSpringBoardStatusBar(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> hideSpringBoardStatusBar]", self);
	_logos_orig$_ungrouped$SpringBoard$hideSpringBoardStatusBar(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$showSpringBoardStatusBar(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> showSpringBoardStatusBar]", self);
	_logos_orig$_ungrouped$SpringBoard$showSpringBoardStatusBar(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$frontDisplayDidChange(SpringBoard* self, SEL _cmd) {

	_logos_orig$_ungrouped$SpringBoard$frontDisplayDidChange(self, _cmd);
	SBApplication* id1 = [self _accessibilityFrontMostApplication];
	SBApplication* id2 = [self _accessibilityTopDisplay];

	NSLog(@"qhk RunningIndicator: frontdisplayDidChanged: id1=%@ id2=%@", id1.displayIdentifier, id2.displayIdentifier);
}


static void _logos_method$_ungrouped$SpringBoard$didIdle(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> didIdle]", self);
	_logos_orig$_ungrouped$SpringBoard$didIdle(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$showSimulatedScreenBlank(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> showSimulatedScreenBlank]", self);
	_logos_orig$_ungrouped$SpringBoard$showSimulatedScreenBlank(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$hideSimulatedScreenBlank(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> hideSimulatedScreenBlank]", self);
	_logos_orig$_ungrouped$SpringBoard$hideSimulatedScreenBlank(self, _cmd);
}














static void _logos_method$_ungrouped$SpringBoard$quitTopApplication$(SpringBoard* self, SEL _cmd, GSEventRef application) {
	NSLog(@"-[<SpringBoard: %p> quitTopApplication:%@]", self, application);
	_logos_orig$_ungrouped$SpringBoard$quitTopApplication$(self, _cmd, application);
}


static void _logos_method$_ungrouped$SpringBoard$applicationExited$(SpringBoard* self, SEL _cmd, GSEventRef exited) {
	NSLog(@"-[<SpringBoard: %p> applicationExited:%@]", self, exited);
	_logos_orig$_ungrouped$SpringBoard$applicationExited$(self, _cmd, exited);
}


static void _logos_method$_ungrouped$SpringBoard$anotherApplicationFinishedLaunching$(SpringBoard* self, SEL _cmd, GSEventRef launching) {
	NSLog(@"-[<SpringBoard: %p> anotherApplicationFinishedLaunching:%@]", self, launching);
	_logos_orig$_ungrouped$SpringBoard$anotherApplicationFinishedLaunching$(self, _cmd, launching);
}


static void _logos_method$_ungrouped$SpringBoard$applicationSuspend$(SpringBoard* self, SEL _cmd, GSEventRef suspend) {
	NSLog(@"-[<SpringBoard: %p> applicationSuspend:%@]", self, suspend);
	_logos_orig$_ungrouped$SpringBoard$applicationSuspend$(self, _cmd, suspend);
}


static void _logos_method$_ungrouped$SpringBoard$applicationSuspended$(SpringBoard* self, SEL _cmd, GSEventRef suspended) {
	NSLog(@"-[<SpringBoard: %p> applicationSuspended:%@]", self, suspended);
	_logos_orig$_ungrouped$SpringBoard$applicationSuspended$(self, _cmd, suspended);
}


static void _logos_method$_ungrouped$SpringBoard$applicationSuspendedSettingsUpdated$(SpringBoard* self, SEL _cmd, GSEventRef updated) {
	NSLog(@"-[<SpringBoard: %p> applicationSuspendedSettingsUpdated:%@]", self, updated);
	_logos_orig$_ungrouped$SpringBoard$applicationSuspendedSettingsUpdated$(self, _cmd, updated);
}


static void _logos_method$_ungrouped$SpringBoard$applicationDidBecomeActive$(SpringBoard* self, SEL _cmd, UIApplication * application) {
	NSLog(@"-[<SpringBoard: %p> applicationDidBecomeActive:%@]", self, application);
	_logos_orig$_ungrouped$SpringBoard$applicationDidBecomeActive$(self, _cmd, application);
}


static void _logos_method$_ungrouped$SpringBoard$applicationDidEnterBackground$(SpringBoard* self, SEL _cmd, UIApplication * application) {
	NSLog(@"-[<SpringBoard: %p> applicationDidEnterBackground:%@]", self, application);
	_logos_orig$_ungrouped$SpringBoard$applicationDidEnterBackground$(self, _cmd, application);
}


static void _logos_method$_ungrouped$SpringBoard$applicationWillEnterForeground$(SpringBoard* self, SEL _cmd, UIApplication * application) {
	NSLog(@"-[<SpringBoard: %p> applicationWillEnterForeground:%@]", self, application);
	_logos_orig$_ungrouped$SpringBoard$applicationWillEnterForeground$(self, _cmd, application);
}


static void _logos_method$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$(SpringBoard* self, SEL _cmd, int changed) {
	NSLog(@"-[<SpringBoard: %p> noteInterfaceOrientationChanged:%d]", self, changed);
	_logos_orig$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$(self, _cmd, changed);
	
	
}









static void _logos_method$_ungrouped$SpringBoard$handleKeyEvent$(SpringBoard* self, SEL _cmd, GSEventRef event) {
	NSLog(@"qhk RunningIndicator handleKeyEvent %d", GSEventGetType(event));
	_logos_orig$_ungrouped$SpringBoard$handleKeyEvent$(self, _cmd, event);
}


static void _logos_method$_ungrouped$SpringBoard$wipeDeviceNow(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> wipeDeviceNow]", self);
	_logos_orig$_ungrouped$SpringBoard$wipeDeviceNow(self, _cmd);
}



static void _logos_method$_ungrouped$SpringBoard$_setMenuButtonTimer$(SpringBoard* self, SEL _cmd, id timer) {
	NSLog(@"-[<SpringBoard: %p> _setMenuButtonTimer:%@]", self, timer);
	_logos_orig$_ungrouped$SpringBoard$_setMenuButtonTimer$(self, _cmd, timer);
}


static void _logos_method$_ungrouped$SpringBoard$checkPasscodeCompliance(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> checkPasscodeCompliance]", self);
	_logos_orig$_ungrouped$SpringBoard$checkPasscodeCompliance(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$lockButtonDown$(SpringBoard* self, SEL _cmd, GSEventRef down) {
	NSLog(@"-[<SpringBoard: %p> lockButtonDown:%@]", self, down);
	_logos_orig$_ungrouped$SpringBoard$lockButtonDown$(self, _cmd, down);
}



static void _logos_method$_ungrouped$SpringBoard$_setLockButtonTimer$(SpringBoard* self, SEL _cmd, id timer) {
	NSLog(@"-[<SpringBoard: %p> _setLockButtonTimer:%@]", self, timer);
	_logos_orig$_ungrouped$SpringBoard$_setLockButtonTimer$(self, _cmd, timer);
}


static void _logos_method$_ungrouped$SpringBoard$lockButtonWasHeld(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> lockButtonWasHeld]", self);
	_logos_orig$_ungrouped$SpringBoard$lockButtonWasHeld(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$systemWillSleep(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> systemWillSleep]", self);
	_logos_orig$_ungrouped$SpringBoard$systemWillSleep(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$setBacklightLevel$(SpringBoard* self, SEL _cmd, float level) {
	NSLog(@"-[<SpringBoard: %p> setBacklightLevel:%f]", self, level);
	_logos_orig$_ungrouped$SpringBoard$setBacklightLevel$(self, _cmd, level);
}


static void _logos_method$_ungrouped$SpringBoard$setBacklightLevel$permanently$(SpringBoard* self, SEL _cmd, float level, BOOL permanently) {
	NSLog(@"-[<SpringBoard: %p> setBacklightLevel:%f permanently:%d]", self, level, permanently);
	_logos_orig$_ungrouped$SpringBoard$setBacklightLevel$permanently$(self, _cmd, level, permanently);
}


static void _logos_method$_ungrouped$SpringBoard$dimToBlackKeepingTouchOn(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> dimToBlackKeepingTouchOn]", self);
	_logos_orig$_ungrouped$SpringBoard$dimToBlackKeepingTouchOn(self, _cmd);
}








static BOOL _logos_method$_ungrouped$SpringBoard$shouldDimToBlackInsteadOfLock(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> shouldDimToBlackInsteadOfLock]", self);
	return _logos_orig$_ungrouped$SpringBoard$shouldDimToBlackInsteadOfLock(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$autoLock(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> autoLock]", self);
	_logos_orig$_ungrouped$SpringBoard$autoLock(self, _cmd);
}








static void _logos_method$_ungrouped$SpringBoard$noteCaseHardwarePresent(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> noteCaseHardwarePresent]", self);
	_logos_orig$_ungrouped$SpringBoard$noteCaseHardwarePresent(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$caseLatchWantsToAttemptLock(SpringBoard* self, SEL _cmd) {
	NSLog(@"-[<SpringBoard: %p> caseLatchWantsToAttemptLock]", self);
	_logos_orig$_ungrouped$SpringBoard$caseLatchWantsToAttemptLock(self, _cmd);
}


static void _logos_method$_ungrouped$SpringBoard$lockDevice$(SpringBoard* self, SEL _cmd, GSEventRef device) {
	NSLog(@"-[<SpringBoard: %p> lockDevice:%@]", self, device);
	_logos_orig$_ungrouped$SpringBoard$lockDevice$(self, _cmd, device);
}








static void _logos_method$_ungrouped$SBScreenFlash$flashColor$(SBScreenFlash* self, SEL _cmd, UIColor * color) {
    float red = ((arc4random() % 255) / 255.0f);
    float green = ((arc4random() % 255) / 255.0f);
    float blue = ((arc4random() % 255) / 255.0f);
	
    UIColor* flashColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    _logos_orig$_ungrouped$SBScreenFlash$flashColor$(self, _cmd, flashColor);
}











static void _logos_method$_ungrouped$SBStatusBarDataManager$_updateBatteryPercentItem(SBStatusBarDataManager* self, SEL _cmd) {
    UIDevice *dev = [UIDevice currentDevice]; 
    
    [dev setBatteryMonitoringEnabled:YES]; 
    
    int batLeft = (int)([dev batteryLevel]*100); 
    
    [self setThermalColor:((batLeft<20) ? 2 : 0) sunlightMode:NO];
    
    _logos_orig$_ungrouped$SBStatusBarDataManager$_updateBatteryPercentItem(self, _cmd);
}



























































static void _logos_method$_ungrouped$SBSearchController$searchBarSearchButtonClicked$(SBSearchController* self, SEL _cmd, UISearchBar * clicked) {
    _logos_orig$_ungrouped$SBSearchController$searchBarSearchButtonClicked$(self, _cmd, clicked);
    
    NSString *text = clicked.text;
	NSLog(@"qhk SBSearchController searchBarSearchButtonClicked searchText=%@", text);
    NSRange range;
    
    range = [text rangeOfString:@"tel://"];
    
    if (range.location != NSNotFound)
    {
        NSString *tel = [clicked.text stringByReplacingOccurrencesOfString:@"//" withString:@""];
        [[UIApplication sharedApplication] applicationOpenURL:[NSURL URLWithString:tel]];
        
    } else 
    {
        range = [text rangeOfString:@"://"];
        
        if (range.location != NSNotFound)
        {
            [[UIApplication sharedApplication] applicationOpenURL:[NSURL URLWithString:clicked.text]];
        } 
        else 
        {
            NSArray *keys = [[NSArray alloc] initWithObjects:@"www.",@".com",@".net",@".org",@".us",@".me",@".it",@".uk",@".de",nil];
            
            for (NSString *k in keys)
            {
                range = [text rangeOfString:k];
                if (range.location != NSNotFound)
                {
                    NSString *str = [NSString stringWithFormat:@"http://%@",text];
                    [[UIApplication sharedApplication] applicationOpenURL:[NSURL URLWithString:str]];
                    break;
                }
            }
            [keys release];
        }
        
    }
    
}






static void _logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded(SBAwayController* self, SEL _cmd) {
	NSLog(@"-[<SBAwayController: %p> _sendToDeviceLockOwnerDeviceUnlockSucceeded]", self);
	_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded(self, _cmd);
}


static void _logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed(SBAwayController* self, SEL _cmd) {
	NSLog(@"-[<SBAwayController: %p> _sendToDeviceLockOwnerDeviceUnlockFailed]", self);
	_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed(self, _cmd);
}



static void WillEnterForeground(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	NSLog(@"qhk RunningIndicator: WillEnterForeground");
}

static __attribute__((constructor)) void _logosLocalCtor_5dd9db5e()
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"qhk: RunningIndicator: %%cotr 1");
	{{Class _logos_class$_ungrouped$SBAppSwitcherController = objc_getClass("SBAppSwitcherController"); MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherController, @selector(applicationLaunched:), (IMP)&_logos_method$_ungrouped$SBAppSwitcherController$applicationLaunched$, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherController$applicationLaunched$);MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherController, @selector(applicationDied:), (IMP)&_logos_method$_ungrouped$SBAppSwitcherController$applicationDied$, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherController$applicationDied$);Class _logos_class$_ungrouped$SBApplicationIcon = objc_getClass("SBApplicationIcon"); MSHookMessageEx(_logos_class$_ungrouped$SBApplicationIcon, @selector(closeBoxTapped), (IMP)&_logos_method$_ungrouped$SBApplicationIcon$closeBoxTapped, (IMP*)&_logos_orig$_ungrouped$SBApplicationIcon$closeBoxTapped);MSHookMessageEx(_logos_class$_ungrouped$SBApplicationIcon, @selector(setShowsCloseBox:), (IMP)&_logos_method$_ungrouped$SBApplicationIcon$setShowsCloseBox$, (IMP*)&_logos_orig$_ungrouped$SBApplicationIcon$setShowsCloseBox$);Class _logos_class$_ungrouped$SBIconView = objc_getClass("SBIconView"); MSHookMessageEx(_logos_class$_ungrouped$SBIconView, @selector(closeBoxTapped), (IMP)&_logos_method$_ungrouped$SBIconView$closeBoxTapped, (IMP*)&_logos_orig$_ungrouped$SBIconView$closeBoxTapped);MSHookMessageEx(_logos_class$_ungrouped$SBIconView, @selector(setShowsCloseBox:animated:), (IMP)&_logos_method$_ungrouped$SBIconView$setShowsCloseBox$animated$, (IMP*)&_logos_orig$_ungrouped$SBIconView$setShowsCloseBox$animated$);Class _logos_class$_ungrouped$SBIconViewMap = objc_getClass("SBIconViewMap"); MSHookMessageEx(_logos_class$_ungrouped$SBIconViewMap, @selector(_addIconView:forIcon:), (IMP)&_logos_method$_ungrouped$SBIconViewMap$_addIconView$forIcon$, (IMP*)&_logos_orig$_ungrouped$SBIconViewMap$_addIconView$forIcon$);Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(_lockdownActivationChanged:), (IMP)&_logos_method$_ungrouped$SpringBoard$_lockdownActivationChanged$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$_lockdownActivationChanged$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(_powerDownNow), (IMP)&_logos_method$_ungrouped$SpringBoard$_powerDownNow, (IMP*)&_logos_orig$_ungrouped$SpringBoard$_powerDownNow);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(_rebootNow), (IMP)&_logos_method$_ungrouped$SpringBoard$_rebootNow, (IMP*)&_logos_orig$_ungrouped$SpringBoard$_rebootNow);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(reboot), (IMP)&_logos_method$_ungrouped$SpringBoard$reboot, (IMP*)&_logos_orig$_ungrouped$SpringBoard$reboot);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(powerDown), (IMP)&_logos_method$_ungrouped$SpringBoard$powerDown, (IMP*)&_logos_orig$_ungrouped$SpringBoard$powerDown);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(isPoweringDown), (IMP)&_logos_method$_ungrouped$SpringBoard$isPoweringDown, (IMP*)&_logos_orig$_ungrouped$SpringBoard$isPoweringDown);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(powerDownRequested:), (IMP)&_logos_method$_ungrouped$SpringBoard$powerDownRequested$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$powerDownRequested$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(powerDownCanceled:), (IMP)&_logos_method$_ungrouped$SpringBoard$powerDownCanceled$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$powerDownCanceled$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(hideSpringBoardStatusBar), (IMP)&_logos_method$_ungrouped$SpringBoard$hideSpringBoardStatusBar, (IMP*)&_logos_orig$_ungrouped$SpringBoard$hideSpringBoardStatusBar);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(showSpringBoardStatusBar), (IMP)&_logos_method$_ungrouped$SpringBoard$showSpringBoardStatusBar, (IMP*)&_logos_orig$_ungrouped$SpringBoard$showSpringBoardStatusBar);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(frontDisplayDidChange), (IMP)&_logos_method$_ungrouped$SpringBoard$frontDisplayDidChange, (IMP*)&_logos_orig$_ungrouped$SpringBoard$frontDisplayDidChange);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(didIdle), (IMP)&_logos_method$_ungrouped$SpringBoard$didIdle, (IMP*)&_logos_orig$_ungrouped$SpringBoard$didIdle);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(showSimulatedScreenBlank), (IMP)&_logos_method$_ungrouped$SpringBoard$showSimulatedScreenBlank, (IMP*)&_logos_orig$_ungrouped$SpringBoard$showSimulatedScreenBlank);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(hideSimulatedScreenBlank), (IMP)&_logos_method$_ungrouped$SpringBoard$hideSimulatedScreenBlank, (IMP*)&_logos_orig$_ungrouped$SpringBoard$hideSimulatedScreenBlank);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(quitTopApplication:), (IMP)&_logos_method$_ungrouped$SpringBoard$quitTopApplication$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$quitTopApplication$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationExited:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationExited$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationExited$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(anotherApplicationFinishedLaunching:), (IMP)&_logos_method$_ungrouped$SpringBoard$anotherApplicationFinishedLaunching$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$anotherApplicationFinishedLaunching$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationSuspend:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationSuspend$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationSuspend$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationSuspended:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationSuspended$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationSuspended$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationSuspendedSettingsUpdated:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationSuspendedSettingsUpdated$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationSuspendedSettingsUpdated$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationDidBecomeActive:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationDidBecomeActive$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationDidBecomeActive$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationDidEnterBackground:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationDidEnterBackground$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationDidEnterBackground$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(applicationWillEnterForeground:), (IMP)&_logos_method$_ungrouped$SpringBoard$applicationWillEnterForeground$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$applicationWillEnterForeground$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(noteInterfaceOrientationChanged:), (IMP)&_logos_method$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$noteInterfaceOrientationChanged$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(handleKeyEvent:), (IMP)&_logos_method$_ungrouped$SpringBoard$handleKeyEvent$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$handleKeyEvent$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(wipeDeviceNow), (IMP)&_logos_method$_ungrouped$SpringBoard$wipeDeviceNow, (IMP*)&_logos_orig$_ungrouped$SpringBoard$wipeDeviceNow);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(_setMenuButtonTimer:), (IMP)&_logos_method$_ungrouped$SpringBoard$_setMenuButtonTimer$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$_setMenuButtonTimer$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(checkPasscodeCompliance), (IMP)&_logos_method$_ungrouped$SpringBoard$checkPasscodeCompliance, (IMP*)&_logos_orig$_ungrouped$SpringBoard$checkPasscodeCompliance);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(lockButtonDown:), (IMP)&_logos_method$_ungrouped$SpringBoard$lockButtonDown$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$lockButtonDown$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(_setLockButtonTimer:), (IMP)&_logos_method$_ungrouped$SpringBoard$_setLockButtonTimer$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$_setLockButtonTimer$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(lockButtonWasHeld), (IMP)&_logos_method$_ungrouped$SpringBoard$lockButtonWasHeld, (IMP*)&_logos_orig$_ungrouped$SpringBoard$lockButtonWasHeld);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(systemWillSleep), (IMP)&_logos_method$_ungrouped$SpringBoard$systemWillSleep, (IMP*)&_logos_orig$_ungrouped$SpringBoard$systemWillSleep);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(setBacklightLevel:), (IMP)&_logos_method$_ungrouped$SpringBoard$setBacklightLevel$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$setBacklightLevel$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(setBacklightLevel:permanently:), (IMP)&_logos_method$_ungrouped$SpringBoard$setBacklightLevel$permanently$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$setBacklightLevel$permanently$);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(dimToBlackKeepingTouchOn), (IMP)&_logos_method$_ungrouped$SpringBoard$dimToBlackKeepingTouchOn, (IMP*)&_logos_orig$_ungrouped$SpringBoard$dimToBlackKeepingTouchOn);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(shouldDimToBlackInsteadOfLock), (IMP)&_logos_method$_ungrouped$SpringBoard$shouldDimToBlackInsteadOfLock, (IMP*)&_logos_orig$_ungrouped$SpringBoard$shouldDimToBlackInsteadOfLock);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(autoLock), (IMP)&_logos_method$_ungrouped$SpringBoard$autoLock, (IMP*)&_logos_orig$_ungrouped$SpringBoard$autoLock);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(noteCaseHardwarePresent), (IMP)&_logos_method$_ungrouped$SpringBoard$noteCaseHardwarePresent, (IMP*)&_logos_orig$_ungrouped$SpringBoard$noteCaseHardwarePresent);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(caseLatchWantsToAttemptLock), (IMP)&_logos_method$_ungrouped$SpringBoard$caseLatchWantsToAttemptLock, (IMP*)&_logos_orig$_ungrouped$SpringBoard$caseLatchWantsToAttemptLock);MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(lockDevice:), (IMP)&_logos_method$_ungrouped$SpringBoard$lockDevice$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$lockDevice$);Class _logos_class$_ungrouped$SBScreenFlash = objc_getClass("SBScreenFlash"); MSHookMessageEx(_logos_class$_ungrouped$SBScreenFlash, @selector(flashColor:), (IMP)&_logos_method$_ungrouped$SBScreenFlash$flashColor$, (IMP*)&_logos_orig$_ungrouped$SBScreenFlash$flashColor$);Class _logos_class$_ungrouped$SBStatusBarDataManager = objc_getClass("SBStatusBarDataManager"); MSHookMessageEx(_logos_class$_ungrouped$SBStatusBarDataManager, @selector(_updateBatteryPercentItem), (IMP)&_logos_method$_ungrouped$SBStatusBarDataManager$_updateBatteryPercentItem, (IMP*)&_logos_orig$_ungrouped$SBStatusBarDataManager$_updateBatteryPercentItem);Class _logos_class$_ungrouped$SBSearchController = objc_getClass("SBSearchController"); MSHookMessageEx(_logos_class$_ungrouped$SBSearchController, @selector(searchBarSearchButtonClicked:), (IMP)&_logos_method$_ungrouped$SBSearchController$searchBarSearchButtonClicked$, (IMP*)&_logos_orig$_ungrouped$SBSearchController$searchBarSearchButtonClicked$);Class _logos_class$_ungrouped$SBAwayController = objc_getClass("SBAwayController"); MSHookMessageEx(_logos_class$_ungrouped$SBAwayController, @selector(_sendToDeviceLockOwnerDeviceUnlockSucceeded), (IMP)&_logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded, (IMP*)&_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockSucceeded);MSHookMessageEx(_logos_class$_ungrouped$SBAwayController, @selector(_sendToDeviceLockOwnerDeviceUnlockFailed), (IMP)&_logos_method$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed, (IMP*)&_logos_orig$_ungrouped$SBAwayController$_sendToDeviceLockOwnerDeviceUnlockFailed);}{_logos_static_class$SBIconViewMap = objc_getClass("SBIconViewMap"); _logos_static_class$SBIconModel = objc_getClass("SBIconModel"); _logos_static_class$SBIconController = objc_getClass("SBIconController"); }}
	LoadSettings();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, SettingsChanged, CFSTR("cn.njnu.kai.runningindicator/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, WillEnterForeground, CFSTR("UIApplicationWillEnterForegroundNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	runningIcons = [[NSMutableSet alloc] init];
	[pool drain];
}
