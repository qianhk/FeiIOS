#line 1 "/OnGitHub/FeiIOS/BlurredNotificationCenter/BlurredNotificationCenter/Custom-Lock.xm"
#import <UIKit/UIKit.h>


@interface TPLCDTextView : UIView { }
-(void)setText:(id)text;
-(void)setTextColor:(id)color;
@end

static NSString *timeLabelText;
static NSInteger timeLabelColor;
static NSString *dateLabelText;
static NSInteger dateLabelColor;
static BOOL clockActive = YES;
static BOOL dateActive = YES;

static UIColor *ColorForIndex(NSInteger colorNumber)
{
	switch (colorNumber)
	{
		case 0:
			return [UIColor redColor];
		case 1:
			return [UIColor blueColor];
		case 2:
			return [UIColor greenColor];
		case 3:
			return [UIColor blackColor];
		case 4:
			return [UIColor purpleColor];
		case 5:
			return [UIColor whiteColor];
		case 6:
			return [UIColor orangeColor];
		default:
			return nil;
	}
}



#include <substrate.h>
@class SBAwayDateView; 
static void (*_logos_orig$_ungrouped$SBAwayDateView$updateClock)(SBAwayDateView*, SEL); static void _logos_method$_ungrouped$SBAwayDateView$updateClock(SBAwayDateView*, SEL); static void (*_logos_orig$_ungrouped$SBAwayDateView$updateLabels)(SBAwayDateView*, SEL); static void _logos_method$_ungrouped$SBAwayDateView$updateLabels(SBAwayDateView*, SEL); 

#line 41 "/OnGitHub/FeiIOS/BlurredNotificationCenter/BlurredNotificationCenter/Custom-Lock.xm"


static void _logos_method$_ungrouped$SBAwayDateView$updateClock(SBAwayDateView* self, SEL _cmd) {
	NSLog(@"qhk: BlurredNC updateClock");
	_logos_orig$_ungrouped$SBAwayDateView$updateClock(self, _cmd);
	if(clockActive)
	{
		TPLCDTextView *timeLabel = MSHookIvar<TPLCDTextView *>(self, "_timeLabel");
		[timeLabel setText:@"timeLabelText"];
		[timeLabel setTextColor: ColorForIndex(timeLabelColor)];
	}
}



static void _logos_method$_ungrouped$SBAwayDateView$updateLabels(SBAwayDateView* self, SEL _cmd) {
	NSLog(@"qhk: BlurredNC updateLabel");
	_logos_orig$_ungrouped$SBAwayDateView$updateLabels(self, _cmd);
	if(dateActive)
	{
		TPLCDTextView *dateLabel = MSHookIvar<TPLCDTextView *>(self, "_titleLabel");
		[dateLabel setText:@"dateLabelText"];
		[dateLabel setTextColor: ColorForIndex(dateLabelColor)];		
	}
}




static void LoadSettings()
{ 



	






	timeLabelColor	= 1; 
	






	dateLabelColor =  4; 
}

static void SettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	LoadSettings();
}

static __attribute__((constructor)) void _logosLocalCtor_e2ef524f()
{
	NSLog(@"qhk: BlurredNC ctor");
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	{{Class _logos_class$_ungrouped$SBAwayDateView = objc_getClass("SBAwayDateView"); MSHookMessageEx(_logos_class$_ungrouped$SBAwayDateView, @selector(updateClock), (IMP)&_logos_method$_ungrouped$SBAwayDateView$updateClock, (IMP*)&_logos_orig$_ungrouped$SBAwayDateView$updateClock);MSHookMessageEx(_logos_class$_ungrouped$SBAwayDateView, @selector(updateLabels), (IMP)&_logos_method$_ungrouped$SBAwayDateView$updateLabels, (IMP*)&_logos_orig$_ungrouped$SBAwayDateView$updateLabels);}}
	LoadSettings();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, SettingsChanged, CFSTR("com.njnu.kai.blurrednotificationcenter/setting_updated"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	[pool drain];
}
