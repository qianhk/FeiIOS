
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

//static Class classAASettingsSyncController = NSClassFromString(@"AASettingsSyncController");

#import <objc/runtime.h>

static BOOL enableContactSwitch = YES;

@interface PSControlTableCell

@property(retain) UIControl *control;	// G=0xb6fd; S=0xe40d; converted property

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

@property(assign, nonatomic) id target;	// G=0x97bd; S=0x97cd; @synthesize
@property(assign, nonatomic) Class detailControllerClass;	// G=0x979d; S=0x97ad; @synthesize
@property(assign, nonatomic) int cellType;	// G=0x977d; S=0x978d; @synthesize
@property(assign, nonatomic) Class editPaneClass;	// G=0x975d; S=0x976d; @synthesize
@property(retain, nonatomic) id userInfo;	// G=0x974d; S=0x9a9d; @synthesize=_userInfo
@property(retain, nonatomic) NSDictionary *titleDictionary;	// G=0x973d; S=0x9ac5; @synthesize=_titleDict
@property(retain, nonatomic) NSDictionary *shortTitleDictionary;	// G=0x96ad; S=0x9aed; @synthesize=_shortTitleDict
@property(retain, nonatomic) NSArray *values;	// G=0x972d; S=0x9b15; @synthesize=_values
@property(retain, nonatomic) NSString *name;	// G=0x971d; S=0x9b3d; @synthesize=_name
@property(retain, nonatomic) NSString *identifier;	// G=0x9b9d; S=0x9c1d; 
@property(retain) NSMutableDictionary *properties;	// G=0x969d; S=0xa1b1; converted property

@end;

@interface PreferencesTableCell
@property(retain, nonatomic) PSSpecifier *specifier;	// G=0x178c5; S=0x17969; @synthesize=_specifier
@property(retain) id target;	// G=0x17861; S=0x17851; converted property
@property(assign) SEL action;	// G=0x17881; S=0x17871; converted property
@end;

%hook PSControlTableCell

- (void)refreshCellContentsWithSpecifier:(id)spe
{
	%orig;
	
	PSSpecifier* specifier = (PSSpecifier *)spe;
	if ([NSStringFromClass([specifier.target class]) isEqualToString:@"AASettingsSyncController"])
	{
		NSDictionary* userInfo = specifier.userInfo;
		NSString* syncClassKey = [userInfo objectForKey:@"AccountSettingsSyncDataclassKey"];
//		if ([syncClassKey isEqualToString:@"com.apple.Dataclass.Contacts"])
		{
			UISwitch* contactSwitch = [specifier.properties objectForKey:@"control"];
			if ([contactSwitch class] == [UISwitch class])
			{
//			NSLog(@"qhk preferences: refreshCellContentsWithSpecifier %p %@ target=%@ userInfo=%@ title=%@ shortTitle=%@ values=%@ name=%@ identifier=%@ properties=%@", self, NSStringFromClass([specifier class]), specifier.target, specifier.userInfo, specifier.titleDictionary, specifier.shortTitleDictionary, specifier.values, specifier.name, specifier.identifier, specifier.properties);
				if (!enableContactSwitch)
				{
					contactSwitch.on = YES;
					contactSwitch.enabled = NO;
				}
			}
		}
	}
}

//- (void)controlChanged:(id)changed
//{
//	PreferencesTableCell* cell1 = (PreferencesTableCell  *)self;
//	NSLog(@"qhk preferences: tableCell=%@ switch=%@ target=%@ action=%@", self, changed, cell1.target, NSStringFromSelector(cell1.action));
//	
////	UITableViewCell* cell2 = (UITableViewCell  *)self;
////	UITableView* table = nil;
////	object_getInstanceVariable(cell2, "_tableView", (void **)&table);
////	NSLog(@"qhk preferences: table=%@", table);  // null
//	
//	%orig;
//}

%end

%hook UIViewController

//- (void)viewDidLoad
//{
//	%orig;
//	if ([self class] == NSClassFromString(@"AASettingsSyncController"))
//	{
//		UITableView* table = findFirstTableView(self.view.subviews);
//		NSLog(@"qhk preferences: UIViewController viewDidLoad %@ %d", table, [table numberOfSections]);
//	}
//}

//- (void)viewDidAppear:(BOOL)animated
//{
//	%log;
//	%orig;
//	if ([self class] == NSClassFromString(@"AASettingsSyncController"))
//	{
////		UITableView* table = findFirstTableView(self.view.subviews);
////		NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
////		PSControlTableCell* cell = (PSControlTableCell *)[table cellForRowAtIndexPath:indexPath];
////		UISwitch* contractSwitch = (UISwitch *)cell.control;
////		contractSwitch.enabled = NO;
////		NSArray* arrTarget = [contractSwitch actionsForTarget:cell forControlEvent:UIControlEventTouchUpInside];
////		NSLog(@"qhk preferences: UIViewController viewDidAppear %@ ", arrTarget);
//	}
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	UITableViewCell* cell = %orig;
//	NSLog(@"qhk preferences: cellForRowAtIndexPath:%@ cell=%@", indexPath, cell);
//	return cell;
//}

%end

//%hook UISwitch
//
//- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
//
//%end



%ctor
{
	@autoreleasepool
	{
		enableContactSwitch = ![[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/kaipreferences (1).plist"];
		NSLog(@"qhk preferences: startup enableContactSwitch=%d 6", enableContactSwitch);
		%init;
		
		
	}
}
