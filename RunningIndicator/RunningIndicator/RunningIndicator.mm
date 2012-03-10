#line 1 "/OnGitHub/FeiIOS/RunningIndicator/RunningIndicator/RunningIndicator.xm"
#import "SpringBoard.h"

static NSMutableSet *runningIcons;
static BOOL showCloseButtons;

#include <substrate.h>
@class SBIconView; @class SBIconViewMap; @class SBApplicationIcon; @class SBIconModel; @class SBIconController; @class SBAppSwitcherController; 
static void (*_logos_orig$_ungrouped$SBAppSwitcherController$applicationLaunched$)(SBAppSwitcherController*, SEL, SBApplication *); static void _logos_method$_ungrouped$SBAppSwitcherController$applicationLaunched$(SBAppSwitcherController*, SEL, SBApplication *); static void (*_logos_orig$_ungrouped$SBAppSwitcherController$applicationDied$)(SBAppSwitcherController*, SEL, SBApplication *); static void _logos_method$_ungrouped$SBAppSwitcherController$applicationDied$(SBAppSwitcherController*, SEL, SBApplication *); static void (*_logos_orig$_ungrouped$SBAppSwitcherController$viewWillAppear)(SBAppSwitcherController*, SEL); static void _logos_method$_ungrouped$SBAppSwitcherController$viewWillAppear(SBAppSwitcherController*, SEL); static void (*_logos_orig$_ungrouped$SBAppSwitcherController$viewDidAppear)(SBAppSwitcherController*, SEL); static void _logos_method$_ungrouped$SBAppSwitcherController$viewDidAppear(SBAppSwitcherController*, SEL); static void (*_logos_orig$_ungrouped$SBAppSwitcherController$viewWillDisappear)(SBAppSwitcherController*, SEL); static void _logos_method$_ungrouped$SBAppSwitcherController$viewWillDisappear(SBAppSwitcherController*, SEL); static void (*_logos_orig$_ungrouped$SBApplicationIcon$closeBoxTapped)(SBApplicationIcon*, SEL); static void _logos_method$_ungrouped$SBApplicationIcon$closeBoxTapped(SBApplicationIcon*, SEL); static void (*_logos_orig$_ungrouped$SBApplicationIcon$setShowsCloseBox$)(SBApplicationIcon*, SEL, BOOL); static void _logos_method$_ungrouped$SBApplicationIcon$setShowsCloseBox$(SBApplicationIcon*, SEL, BOOL); static void (*_logos_orig$_ungrouped$SBIconView$closeBoxTapped)(SBIconView*, SEL); static void _logos_method$_ungrouped$SBIconView$closeBoxTapped(SBIconView*, SEL); static void (*_logos_orig$_ungrouped$SBIconView$setShowsCloseBox$animated$)(SBIconView*, SEL, BOOL, BOOL); static void _logos_method$_ungrouped$SBIconView$setShowsCloseBox$animated$(SBIconView*, SEL, BOOL, BOOL); static void (*_logos_orig$_ungrouped$SBIconViewMap$_addIconView$forIcon$)(SBIconViewMap*, SEL, SBIconView *, SBIcon *); static void _logos_method$_ungrouped$SBIconViewMap$_addIconView$forIcon$(SBIconViewMap*, SEL, SBIconView *, SBIcon *); 
static Class _logos_static_class$SBIconViewMap; static Class _logos_static_class$SBIconModel; static Class _logos_static_class$SBIconController; 
#line 6 "/OnGitHub/FeiIOS/RunningIndicator/RunningIndicator/RunningIndicator.xm"



static void _logos_method$_ungrouped$SBAppSwitcherController$applicationLaunched$(SBAppSwitcherController* self, SEL _cmd, SBApplication * application) {
	NSLog(@"qhk runningIndicator: applicationLaunched self=%p %@", self, application);
	SBIconModel *iconModel = [_logos_static_class$SBIconModel sharedInstance];
	SBIcon *icon = [iconModel applicationIconForDisplayIdentifier:[application displayIdentifier]];
	if (icon)
	{
		[runningIcons addObject:icon];
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
			[iconView showDropGlow:YES];
			[iconView setShowsCloseBox:showCloseButtons];
			[UIView commitAnimations];
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
	_logos_orig$_ungrouped$SBAppSwitcherController$applicationDied$(self, _cmd, application);
}


static void _logos_method$_ungrouped$SBAppSwitcherController$viewWillAppear(SBAppSwitcherController* self, SEL _cmd) {
	NSLog(@"qhk runningIndicator: viewWillAppear self=%p", self);
}


static void _logos_method$_ungrouped$SBAppSwitcherController$viewDidAppear(SBAppSwitcherController* self, SEL _cmd) {
	NSLog(@"qhk runningIndicator: viewDidAppear self=%p", self);
}


static void _logos_method$_ungrouped$SBAppSwitcherController$viewWillDisappear(SBAppSwitcherController* self, SEL _cmd) {
	NSLog(@"qhk runningIndicator: viewWillDisappear self=%p", self);
}






static void _logos_method$_ungrouped$SBApplicationIcon$closeBoxTapped(SBApplicationIcon* self, SEL _cmd) {
	NSLog(@"qhk runningIndicator: SBApplicationIcon closeBoxTapped");
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
	NSLog(@"qhk runningIndicator: SBApplicationIcon setShowsCloseBox:%d", newValue);
	_logos_orig$_ungrouped$SBApplicationIcon$setShowsCloseBox$(self, _cmd, newValue || ([runningIcons containsObject:self] && showCloseButtons));
}






static void _logos_method$_ungrouped$SBIconView$closeBoxTapped(SBIconView* self, SEL _cmd) {
	NSLog(@"qhk runningIndicator: SBIconView closeBoxTapped");
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
	NSLog(@"qhk runningIndicator: SBIconView setShowsCloseBox");
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
	[settings release];
}

static void SettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	NSLog(@"qhk runningIndicator: SettingsChanged");
	LoadSettings();
	if (_logos_static_class$SBIconViewMap)
	{
		SBIconViewMap *map = [_logos_static_class$SBIconViewMap homescreenMap];
		for (SBIcon *icon in runningIcons)
			[[map mappedIconViewForIcon:icon] setShowsCloseBox:showCloseButtons];
	}
	else
	{
		for (SBIcon *icon in runningIcons)
			[icon setShowsCloseBox:showCloseButtons];
	}
}

static __attribute__((constructor)) void _logosLocalCtor_fa7cdfad()
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	{{Class _logos_class$_ungrouped$SBAppSwitcherController = objc_getClass("SBAppSwitcherController"); MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherController, @selector(applicationLaunched:), (IMP)&_logos_method$_ungrouped$SBAppSwitcherController$applicationLaunched$, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherController$applicationLaunched$);MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherController, @selector(applicationDied:), (IMP)&_logos_method$_ungrouped$SBAppSwitcherController$applicationDied$, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherController$applicationDied$);MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherController, @selector(viewWillAppear), (IMP)&_logos_method$_ungrouped$SBAppSwitcherController$viewWillAppear, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherController$viewWillAppear);MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherController, @selector(viewDidAppear), (IMP)&_logos_method$_ungrouped$SBAppSwitcherController$viewDidAppear, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherController$viewDidAppear);MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherController, @selector(viewWillDisappear), (IMP)&_logos_method$_ungrouped$SBAppSwitcherController$viewWillDisappear, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherController$viewWillDisappear);Class _logos_class$_ungrouped$SBApplicationIcon = objc_getClass("SBApplicationIcon"); MSHookMessageEx(_logos_class$_ungrouped$SBApplicationIcon, @selector(closeBoxTapped), (IMP)&_logos_method$_ungrouped$SBApplicationIcon$closeBoxTapped, (IMP*)&_logos_orig$_ungrouped$SBApplicationIcon$closeBoxTapped);MSHookMessageEx(_logos_class$_ungrouped$SBApplicationIcon, @selector(setShowsCloseBox:), (IMP)&_logos_method$_ungrouped$SBApplicationIcon$setShowsCloseBox$, (IMP*)&_logos_orig$_ungrouped$SBApplicationIcon$setShowsCloseBox$);Class _logos_class$_ungrouped$SBIconView = objc_getClass("SBIconView"); MSHookMessageEx(_logos_class$_ungrouped$SBIconView, @selector(closeBoxTapped), (IMP)&_logos_method$_ungrouped$SBIconView$closeBoxTapped, (IMP*)&_logos_orig$_ungrouped$SBIconView$closeBoxTapped);MSHookMessageEx(_logos_class$_ungrouped$SBIconView, @selector(setShowsCloseBox:animated:), (IMP)&_logos_method$_ungrouped$SBIconView$setShowsCloseBox$animated$, (IMP*)&_logos_orig$_ungrouped$SBIconView$setShowsCloseBox$animated$);Class _logos_class$_ungrouped$SBIconViewMap = objc_getClass("SBIconViewMap"); MSHookMessageEx(_logos_class$_ungrouped$SBIconViewMap, @selector(_addIconView:forIcon:), (IMP)&_logos_method$_ungrouped$SBIconViewMap$_addIconView$forIcon$, (IMP*)&_logos_orig$_ungrouped$SBIconViewMap$_addIconView$forIcon$);}{_logos_static_class$SBIconViewMap = objc_getClass("SBIconViewMap"); _logos_static_class$SBIconModel = objc_getClass("SBIconModel"); _logos_static_class$SBIconController = objc_getClass("SBIconController"); }}
	LoadSettings();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, SettingsChanged, CFSTR("cn.njnu.kai.runningindicator/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	runningIcons = [[NSMutableSet alloc] init];
	[pool drain];
}
