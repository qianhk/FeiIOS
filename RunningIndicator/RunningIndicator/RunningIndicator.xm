#import "SpringBoard.h"
#import <GraphicsServices/GSEvent.h>

static NSMutableSet *runningIcons;
static BOOL showCloseButtons;
static BOOL showRunningIndicator;

//int GSEventGetType(GSEventRef event);

%hook SBAppSwitcherController

- (void)applicationLaunched:(SBApplication *)application
{
	NSLog(@"qhk runningIndicator: applicationLaunched self=%p bundleIdentifier:%@", self, application.bundleIdentifier);
	SBIconModel *iconModel = [%c(SBIconModel) sharedInstance];
	SBIcon *icon = [iconModel applicationIconForDisplayIdentifier:[application displayIdentifier]];
	if (icon)
	{
		[runningIcons addObject:icon];
		if (showRunningIndicator || showCloseButtons)
		{
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
				[iconView showDropGlow:showRunningIndicator];
				[iconView setShowsCloseBox:showCloseButtons];
				[UIView commitAnimations];
			}
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
		if (showRunningIndicator || showCloseButtons)
		{
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
	}
	%orig;
}

//- (void)viewWillAppear
//{
////	NSLog(@"qhk runningIndicator: viewWillAppear self=%p", self);
//	%orig;
//}
//
//- (void)viewDidAppear
//{
////	NSLog(@"qhk runningIndicator: viewDidAppear self=%p", self);
//	%orig;
//}
//
//- (void)viewWillDisappear
//{
////	NSLog(@"qhk runningIndicator: viewWillDisappear self=%p", self);
//	%orig;
//}
//
//- (void)appSwitcherBarRemovedFromSuperview:(id)superview
//{
////	NSLog(@"qhk runningIndicator: appSwitcherBarRemovedFromSuperview self=%p %@", self, superview);
//	%orig;
//}
//
//- (BOOL)appSwitcherBar:(id)bar scrollShouldCancelInContentForView:(id)scroll
//{
//	NSLog(@"qhk runningIndicator: scrollShouldCancelInContentForView self=%p %@ %@", self, bar, scroll);
//	return %orig;;
//}
//
//- (void)appSwitcherBar:(id)bar pageAtIndexDidAppear:(int)pageAtIndex
//{
//	NSLog(@"qhk runningIndicator: pageAtIndexDidAppear self=%p %@ %d", self, bar, pageAtIndex);
//	%orig;
//}
//
//- (void)appSwitcherBar:(id)bar pageAtIndexDidDisappear:(int)pageAtIndex
//{
//	NSLog(@"qhk runningIndicator: pageAtIndexDidDisappear self=%p %@ %d", self, bar, pageAtIndex);
//	%orig;
//}

%end

/*
 Apr  9 10:50:21 unknown SpringBoard[5554] <Warning>: MS:Warning: message not found [SBApplicationIcon closeBoxTapped]
 Apr  9 10:50:21 unknown SpringBoard[5554] <Warning>: MS:Warning: message not found [SBApplicationIcon setShowsCloseBox:]
 */
%hook SBApplicationIcon //未见使用这个，一般都是SBIconView

- (void)closeBoxTapped
{
//	NSLog(@"qhk runningIndicator: SBApplicationIcon closeBoxTapped");
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
//	NSLog(@"qhk runningIndicator: SBApplicationIcon setShowsCloseBox:%d", newValue);
	%orig(newValue || ([runningIcons containsObject:self] && showCloseButtons));
}

%end

%hook SBIconView //一般用这个，未见SBApplicationIcon的NSLog

- (void)closeBoxTapped
{
//	NSLog(@"qhk runningIndicator: SBIconView closeBoxTapped");
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
//	NSLog(@"qhk runningIndicator: SBIconView setShowsCloseBox");
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
		[iconView showDropGlow:showRunningIndicator];
		[iconView setShowsCloseBox:showCloseButtons];
	}
}

%end

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
//	NSLog(@"qhk runningIndicator: SettingsChanged");
	LoadSettings();
	if (%c(SBIconViewMap))
	{
		SBIconViewMap *map = [%c(SBIconViewMap) homescreenMap];
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

%hook SpringBoard

- (void)_lockdownActivationChanged:(id)changed
{
	NSLog(@"qhk runningIndicator: _lockdownActivationChanged %@", changed);
	%orig;
}

- (void)_powerDownNow
{
	%log;
	%orig;
}

- (void)_rebootNow
{
	%log;
	%orig;
}

- (void)reboot
{
	%log;
	%orig;
}

- (void)powerDown
{
	%log;
	%orig;
}

- (BOOL)isPoweringDown
{
	%log;
	return %orig;
}

- (void)powerDownRequested:(id)requested
{
	%log;
	%orig;
}

- (void)powerDownCanceled:(id)canceled
{
	%log;
	%orig;
}

- (void)hideSpringBoardStatusBar
{
	%log;
	%orig;
}

- (void)showSpringBoardStatusBar
{
	%log;
	%orig;
}

- (void)frontDisplayDidChange
{
//	%log;
	%orig;
	SBApplication* id1 = [self _accessibilityFrontMostApplication];
	SBApplication* id2 = [self _accessibilityTopDisplay];
//	id id3 = [self _accessibilityRunningApplications];
	NSLog(@"qhk RunningIndicator: frontdisplayDidChanged: id1=%@ id2=%@", id1.displayIdentifier, id2.displayIdentifier);
}

- (void)didIdle
{
	%log;
	%orig;
}

- (void)showSimulatedScreenBlank
{
	%log;
	%orig;
}

- (void)hideSimulatedScreenBlank
{
	%log;
	%orig;
}

//- (id)metaHostView
//{
//	%log;
//	return %orig;
//}
//
//- (id)metaHostWindow
//{
//	%log;
//	return %orig;
//}

- (void)quitTopApplication:(GSEventRef)application
{
	%log;
	%orig;
}

- (void)applicationExited:(GSEventRef)exited
{
	%log;
	%orig;
}

- (void)anotherApplicationFinishedLaunching:(GSEventRef)launching
{
	%log;
	%orig;
}

- (void)applicationSuspend:(GSEventRef)suspend
{
	%log;
	%orig;
}

- (void)applicationSuspended:(GSEventRef)suspended
{
	%log;
	%orig;
}

- (void)applicationSuspendedSettingsUpdated:(GSEventRef)updated
{
	%log;
	%orig;
}

/*
 Apr  9 10:50:21 unknown SpringBoard[5554] <Warning>: MS:Warning: message not found [SpringBoard applicationDidBecomeActive:]
 Apr  9 10:50:21 unknown SpringBoard[5554] <Warning>: MS:Warning: message not found [SpringBoard applicationDidEnterBackground:]
 Apr  9 10:50:21 unknown SpringBoard[5554] <Warning>: MS:Warning: message not found [SpringBoard applicationWillEnterForeground:]
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
	%log;
	%orig;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	%log;
	%orig;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	%log;
	%orig;
}

- (void)noteInterfaceOrientationChanged:(int)changed
{
	%log;
	%orig;
	
	//UIDeviceOrientation p:1 left:3 right:4
}

//- (void)noteInterfaceOrientationChanged:(int)changed updateMirroredDisplays:(BOOL)displays
//{
//	%log;
//	%orig;
//}


- (void)handleKeyEvent:(GSEventRef)event
{
	NSLog(@"qhk RunningIndicator handleKeyEvent %d", GSEventGetType(event));
	%orig;
}

- (void)wipeDeviceNow
{
	%log;
	%orig;
}


- (void)_setMenuButtonTimer:(id)timer
{
	%log;
	%orig;
}

- (void)checkPasscodeCompliance
{
	%log;
	%orig;
}

- (void)lockButtonDown:(GSEventRef)down
{
	%log;
	%orig;
}


- (void)_setLockButtonTimer:(id)timer
{
	%log;
	%orig;
}

- (void)lockButtonWasHeld
{
	%log;
	%orig;
}

- (void)systemWillSleep
{
	%log;
	%orig;
}

- (void)setBacklightLevel:(float)level
{
	%log;
	%orig;
}

- (void)setBacklightLevel:(float)level permanently:(BOOL)permanently
{
	%log;
	%orig;
}

- (void)dimToBlackKeepingTouchOn
{
	%log;
	%orig;
}

//- (void)undim
//{
//	%log;
//	%orig;
//}

- (BOOL)shouldDimToBlackInsteadOfLock
{
	%log;
	return %orig;
}

- (void)autoLock
{
	%log;
	%orig;
}

//- (void)resetIdleTimerAndUndim:(BOOL)undim
//{
//	%log;
//	%orig;
//}

- (void)noteCaseHardwarePresent
{
	%log;
	%orig;
}

- (void)caseLatchWantsToAttemptLock
{
	%log;
	%orig;
}

- (void)lockDevice:(GSEventRef)device
{
	%log;
	%orig;
}


%end


%hook SBScreenFlash

-(void)flashColor:(UIColor *)color
{
    float red = ((arc4random() % 255) / 255.0f);
    float green = ((arc4random() % 255) / 255.0f);
    float blue = ((arc4random() % 255) / 255.0f);
	
    UIColor* flashColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    %orig(flashColor);
}

%end

//@interface SBStatusBarDataManager : NSObject
//+(id)sharedDataManager;
//-(void)setThermalColor:(int)arg1 sunlightMode:(BOOL)arg2;
//@end

%hook SBStatusBarDataManager

-(void)_updateBatteryPercentItem
{
    UIDevice *dev = [UIDevice currentDevice]; 
    
    [dev setBatteryMonitoringEnabled:YES]; 
    
    int batLeft = (int)([dev batteryLevel]*100); 
    
    [self setThermalColor:((batLeft<20) ? 2 : 0) sunlightMode:NO];
    
    %orig;
}


%end


//static UIBarButtonItem *cachedButton=nil;
//static UIBarButtonItem *origButton=nil;
//static BOOL locked=YES;
// //need hook to "com.apple.MobileSMS"
//%hook CKConversationListController
//
//%new(:@@)
//-(void)toggle
//{
//    locked=!locked;
//    [self setEditing:NO animated:YES];
//    [self loadView];    
//}
//
//
//-(void)setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    %orig;
//    if(editing) 
//    {
//        if(!cachedButton) 
//        {
//            origButton=[[self navigationItem].rightBarButtonItem retain];
//            
//            cachedButton=[[UIBarButtonItem alloc] initWithTitle:@"Unlock" style:UIBarButtonItemStylePlain target:self action:@selector(toggle)];
//        } else 
//        {
//            cachedButton.title = (locked) ? @"Unlock" : @"Lock";
//        }
//        
//        [[self navigationItem] setRightBarButtonItem:cachedButton animated:YES];
//    } 
//    else 
//    {
//        [[self navigationItem] setRightBarButtonItem:origButton animated:YES];
//    }
//}
//
//-(int)tableView:(id)view numberOfRowsInSection:(int)section
//{
//    if (locked) { return 0; }
//    return %orig;
//}
//
//-(void)composeButtonClicked:(id)clicked
//{
//    if (locked) { return; }
//    %orig;
//}
//%end

%hook SBSearchController

-(void)searchBarSearchButtonClicked:(UISearchBar *)clicked
{
    %orig;
    
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

%end

%hook SBAwayController

- (void)_sendToDeviceLockOwnerDeviceUnlockSucceeded
{
	%log;
	%orig;
}

- (void)_sendToDeviceLockOwnerDeviceUnlockFailed
{
	%log;
	%orig;
}

%end

static void WillEnterForeground(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	NSLog(@"qhk RunningIndicator: WillEnterForeground");
}

%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"qhk: RunningIndicator: %%cotr 2");
	%init;
	LoadSettings();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, SettingsChanged, CFSTR("cn.njnu.kai.runningindicator/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, WillEnterForeground, CFSTR("UIApplicationWillEnterForegroundNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	runningIcons = [[NSMutableSet alloc] init];
	[pool drain];
}