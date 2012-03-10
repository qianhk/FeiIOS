#import "SpringBoard.h"

static NSMutableSet *runningIcons;
static BOOL showCloseButtons;

%hook SBAppSwitcherController

- (void)applicationLaunched:(SBApplication *)application
{
	NSLog(@"qhk runningIndicator: applicationLaunched self=%p %@", self, application);
	SBIconModel *iconModel = [%c(SBIconModel) sharedInstance];
	SBIcon *icon = [iconModel applicationIconForDisplayIdentifier:[application displayIdentifier]];
	if (icon)
	{
		[runningIcons addObject:icon];
		SBIconView *iconView = %c(SBIconViewMap) ? [[%c(SBIconViewMap) homescreenMap] mappedIconViewForIcon:icon] : (SBIconView *)icon;
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
	%orig;
}

- (void)applicationDied:(SBApplication *)application
{
	NSLog(@"qhk runningIndicator: applicationDied self=%p %@", self, application);
	SBIconModel *iconModel = [%c(SBIconModel) sharedInstance];
	SBIcon *icon = [iconModel applicationIconForDisplayIdentifier:[application displayIdentifier]];
	if (icon)
	{
		[runningIcons removeObject:icon];
		SBIconView *iconView = %c(SBIconViewMap) ? [[%c(SBIconViewMap) homescreenMap] mappedIconViewForIcon:icon] : (SBIconView *)icon;
		if (iconView)
		{
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:1.0];
			[iconView showDropGlow:NO];
			[iconView setShowsCloseBox:NO];
			[UIView commitAnimations];
		}
	}
	%orig;
}

- (void)viewWillAppear
{
	NSLog(@"qhk runningIndicator: viewWillAppear self=%p", self);
	%orig;
}

- (void)viewDidAppear
{
	NSLog(@"qhk runningIndicator: viewDidAppear self=%p", self);
	%orig;
}

- (void)viewWillDisappear
{
	NSLog(@"qhk runningIndicator: viewWillDisappear self=%p", self);
	%orig;
}

- (void)appSwitcherBarRemovedFromSuperview:(id)superview
{
	NSLog(@"qhk runningIndicator: appSwitcherBarRemovedFromSuperview self=%p %@", self, superview);
	%orig;
}

- (BOOL)appSwitcherBar:(id)bar scrollShouldCancelInContentForView:(id)scroll
{
	NSLog(@"qhk runningIndicator: scrollShouldCancelInContentForView self=%p %@ %@", self, bar, scroll);
	return %orig;;
}

- (void)appSwitcherBar:(id)bar pageAtIndexDidAppear:(int)pageAtIndex
{
	NSLog(@"qhk runningIndicator: pageAtIndexDidAppear self=%p %@ %d", self, bar, pageAtIndex);
	%orig;
}

- (void)appSwitcherBar:(id)bar pageAtIndexDidDisappear:(int)pageAtIndex
{
	NSLog(@"qhk runningIndicator: pageAtIndexDidDisappear self=%p %@ %d", self, bar, pageAtIndex);
	%orig;
}

%end

%hook SBApplicationIcon

- (void)closeBoxTapped
{
	NSLog(@"qhk runningIndicator: SBApplicationIcon closeBoxTapped");
	if (showCloseButtons && [runningIcons containsObject:self])
	{
		SBIconController *iconController = [%c(SBIconController) sharedInstance];
		if (![iconController isEditing] || ![iconController canUninstallIcon:self])
		{
			[[self application] kill];
			return;
		}
	}
	%orig;
}

- (void)setShowsCloseBox:(BOOL)newValue
{
	NSLog(@"qhk runningIndicator: SBApplicationIcon setShowsCloseBox:%d", newValue);
	%orig(newValue || ([runningIcons containsObject:self] && showCloseButtons));
}

%end

%hook SBIconView

- (void)closeBoxTapped
{
	NSLog(@"qhk runningIndicator: SBIconView closeBoxTapped");
	SBApplicationIcon *icon = (SBApplicationIcon *)self.icon;
	if (showCloseButtons && [runningIcons containsObject:icon])
	{
		SBIconController *iconController = [%c(SBIconController) sharedInstance];
		if (![iconController isEditing] || ![iconController canUninstallIcon:icon])
		{
			[[icon application] kill];
			return;
		}
	}
	%orig;
}

- (void)setShowsCloseBox:(BOOL)newValue animated:(BOOL)animated
{
	NSLog(@"qhk runningIndicator: SBIconView setShowsCloseBox");
	%orig(newValue || ([runningIcons containsObject:self.icon] && showCloseButtons), animated);
}

%end

%hook SBIconViewMap

- (void)_addIconView:(SBIconView *)iconView forIcon:(SBIcon *)icon
{
	%orig;
	if ([runningIcons containsObject:icon])
	{
		[iconView prepareDropGlow];
		UIImageView *dropGlow = [iconView dropGlow];
		dropGlow.image = [UIImage imageNamed:@"RunningGlow"];
		[iconView showDropGlow:YES];
		[iconView setShowsCloseBox:showCloseButtons];
	}
}

%end

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
	if (%c(SBIconViewMap))
	{
		SBIconViewMap *map = [%c(SBIconViewMap) homescreenMap];
		for (SBIcon *icon in runningIcons)
			[[map mappedIconViewForIcon:icon] setShowsCloseBox:showCloseButtons];
	}
	else
	{
		for (SBIcon *icon in runningIcons)
			[icon setShowsCloseBox:showCloseButtons];
	}
}

%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	%init;
	LoadSettings();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, SettingsChanged, CFSTR("cn.njnu.kai.runningindicator/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	runningIcons = [[NSMutableSet alloc] init];
	[pool drain];
}