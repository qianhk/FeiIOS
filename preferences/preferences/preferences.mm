#line 1 "/OnGit/FeiIOS/preferences/preferences/preferences.xm"






#import <objc/runtime.h>

static BOOL enableContactSwitch = YES;

@interface PSControlTableCell

@property(retain) UIControl *control;	

@end;

UITableView* findFirstTableView(NSArray* subviews)
{
	for (id subview in subviews)
	{
		if ([subview class] == [UITableView class])
		{
			return subview;
		}
	}
	return nil;
}

@interface PSSpecifier

@property(assign, nonatomic) id target;	
@property(assign, nonatomic) Class detailControllerClass;	
@property(assign, nonatomic) int cellType;	
@property(assign, nonatomic) Class editPaneClass;	
@property(retain, nonatomic) id userInfo;	
@property(retain, nonatomic) NSDictionary *titleDictionary;	
@property(retain, nonatomic) NSDictionary *shortTitleDictionary;	
@property(retain, nonatomic) NSArray *values;	
@property(retain, nonatomic) NSString *name;	
@property(retain, nonatomic) NSString *identifier;	
@property(retain) NSMutableDictionary *properties;	

@end;

@interface PreferencesTableCell
@property(retain, nonatomic) PSSpecifier *specifier;	
@property(retain) id target;	
@property(assign) SEL action;	
@end;

#include <substrate.h>
@class PSControlTableCell; @class UIViewController; 
static void (*_logos_orig$_ungrouped$PSControlTableCell$refreshCellContentsWithSpecifier$)(PSControlTableCell*, SEL, id); static void _logos_method$_ungrouped$PSControlTableCell$refreshCellContentsWithSpecifier$(PSControlTableCell*, SEL, id); 

#line 51 "/OnGit/FeiIOS/preferences/preferences/preferences.xm"



static void _logos_method$_ungrouped$PSControlTableCell$refreshCellContentsWithSpecifier$(PSControlTableCell* self, SEL _cmd, id spe) {
	_logos_orig$_ungrouped$PSControlTableCell$refreshCellContentsWithSpecifier$(self, _cmd, spe);
	
	PSSpecifier* specifier = (PSSpecifier *)spe;
	if ([NSStringFromClass([specifier.target class]) isEqualToString:@"AASettingsSyncController"])
	{
		NSDictionary* userInfo = specifier.userInfo;
		NSString* syncClassKey = [userInfo objectForKey:@"AccountSettingsSyncDataclassKey"];

		{
			UISwitch* contactSwitch = [specifier.properties objectForKey:@"control"];
			if ([contactSwitch class] == [UISwitch class])
			{

				if (!enableContactSwitch)
				{
					contactSwitch.on = YES;
					contactSwitch.enabled = NO;
				}
			}
		}
	}
}





























































static __attribute__((constructor)) void _logosLocalCtor_3988c7f8()
{
	@autoreleasepool
	{
		enableContactSwitch = ![[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/kaipreferences (1).plist"];
		NSLog(@"qhk preferences: startup enableContactSwitch=%d 6", enableContactSwitch);
		{{Class _logos_class$_ungrouped$PSControlTableCell = objc_getClass("PSControlTableCell"); MSHookMessageEx(_logos_class$_ungrouped$PSControlTableCell, @selector(refreshCellContentsWithSpecifier:), (IMP)&_logos_method$_ungrouped$PSControlTableCell$refreshCellContentsWithSpecifier$, (IMP*)&_logos_orig$_ungrouped$PSControlTableCell$refreshCellContentsWithSpecifier$);}}
		
		
	}
}
