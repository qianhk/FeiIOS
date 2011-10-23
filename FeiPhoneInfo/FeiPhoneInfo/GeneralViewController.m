//
//  GeneralInfoController.m
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <sys/sysctl.h>

#include "IOPowerSources.h"
#include "IOPSKeys.h"

//#include <IOKit/ps/IOPowerSources.h>
//#include <IOKit/ps/IOPSKeys.h>

#import "GeneralViewController.h"

#import "UIDevice-IOKitExtensions.h"
#import "UIDevice-Hardware.h"

//#if TARGET_IPHONE_SIMULATOR
//
//#elif TARGET_OS_IPHONE

//#pragma comment(lib, "libIOKit.A.dylib")
//#pragma comment(lib, "libIOKit.dylib")


//#endif

extern NSString *CTSettingCopyMyPhoneNumber();

@interface GeneralViewController()

- (NSString*)doDeviceNumberString;
- (NSDictionary*)batteryLevel;

@end

@implementation GeneralViewController

const NSString* KTTUDID = @"UDID";
const NSString* KTTModel = @"Model";
const NSString* KTTName = @"Name";
//const NSString* KTTLocalizedModel = @"Localized Model";
//const NSString* KTTSystemName = @"System Name";
const NSString* KTTSystemVersion = @"System Version";
const NSString* KTTDevicePlatform = @"Device Platform";
const NSString* KTTBatteryState = @"Battery State";
const NSString* KTTBatteryLevel = @"Battery Level";
const NSString* KTTIMEI = @"IMEI";
const NSString* KTTSerialNo = @"Serial Number";
const NSString* KTTBacklightLevel = @"Backlight level";
const NSString* KTTPhoneNumber = @"Phone Number";

//const NSString* KTTUserInterfaceIdiom = @"UserInterfaceIdiom";
//const NSString* KTTOrientation = @"Orientation";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
	{
		arrBatteryState = [[NSArray alloc] initWithObjects: NSLocalizedString(@"Unknow", @""), NSLocalizedString(@"Unplugged", @""), NSLocalizedString(@"Charging", @""), NSLocalizedString(@"Full", @""), nil];
		arrOrientation = [[NSArray alloc] initWithObjects: @"Unknow", @"Portrait", @"PortraitUpsideDown", @"LandscapeLeft", @"LandscapeRight", @"FaceUp", @"FaceDown", nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{	
	[arrBatteryState release];
	[arrOrientation release];
	[lastBacklightLevel release];
	
	[super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//	[[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(batteryLevelDidChange:)
//												 name:UIDeviceBatteryLevelDidChangeNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(batteryStateDidChange:)
												 name:UIDeviceBatteryStateDidChangeNotification object:nil];

	UIDevice* device = [UIDevice currentDevice];
	device.batteryMonitoringEnabled = YES;
	
    NSString* udid = [device uniqueIdentifier];
	[_arrKey addObject:KTTUDID];
	[_dic setObject:udid forKey:KTTUDID];
	
	[_arrKey addObject:KTTModel];
	[_dic setObject:[device platformString] forKey:KTTModel];
	
	[_arrKey addObject:KTTName];
	[_dic setObject:[device name] forKey:KTTName];
	
//	[_arrKey addObject:KTTLocalizedModel];
//	[_dic setObject:[device localizedModel] forKey:KTTLocalizedModel];
//	
//	[_arrKey addObject:KTTSystemName];
//	[_dic setObject:[device systemName] forKey:KTTSystemName];
	NSMutableString* systemNameAndVersion = [NSMutableString stringWithString:[device systemName]];
	[systemNameAndVersion appendFormat:@" %@", [device systemVersion]];
	[_arrKey addObject:KTTSystemVersion];
	[_dic setObject:systemNameAndVersion forKey:KTTSystemVersion];
	
	NSString* devicePlatform = [self performSelector:@selector(doDevicePlatform) withObject:nil];
	[_arrKey addObject:KTTDevicePlatform];
	[_dic setObject:devicePlatform forKey:KTTDevicePlatform];

	[_arrKey addObject:KTTBatteryState];
	[_dic setObject:[arrBatteryState objectAtIndex:[device batteryState]] forKey:KTTBatteryState];
	
	[_arrKey addObject:KTTBatteryLevel];
//	float batteryLevel = [device batteryLevel];
//	_lastBatteryLevel = (NSInteger)[self batteryLevel];

	NSDictionary *dic = [self batteryLevel];
	int no1 = [[dic objectForKey:@"no1"] intValue];
	int no2 = [[dic objectForKey:@"no2"] intValue];
	_lastBatteryLevel = no1;
	if (no1 < 0)
	{
		[_dic setObject:NSLocalizedString(@"Unknow", @"") forKey:KTTBatteryLevel];
	}
	else
	{
		[_dic setObject:[NSString stringWithFormat:@"%d%% [min=%d, max=%d]", no1 * 100 / no2, no1, no2] forKey:KTTBatteryLevel];
	}

	
//	[_arrKey addObject:KTTUserInterfaceIdiom];
//	if ([device userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//	{
//		[_dic setObject:@"iPhone and iPod touch style" forKey:KTTUserInterfaceIdiom];
//	}
//	else
//	{
//		[_dic setObject:@"iPad style UI" forKey:KTTUserInterfaceIdiom];
//	}
//	
//	[_arrKey addObject:KTTOrientation];
//	[_dic setObject:[arrOrientation objectAtIndex:[device orientation]] forKey:KTTOrientation];
	
	[_arrKey addObject:KTTIMEI];
	NSString* imei = [device imei];
	[_dic setObject:(imei == nil) ? NSLocalizedString(@"No Sim Card", @"") : imei forKey:KTTIMEI];
	
	[_arrKey addObject:KTTPhoneNumber];
	NSString* phoneNumber = CTSettingCopyMyPhoneNumber();
	[_dic setObject:(phoneNumber == nil) ? NSLocalizedString(@"Unknow", @"") : phoneNumber forKey:KTTPhoneNumber];
	
	[_arrKey addObject:KTTSerialNo];
	[_dic setObject:[device serialnumber] forKey:KTTSerialNo];
	
	[_arrKey addObject:KTTBacklightLevel];
	[lastBacklightLevel release];
	lastBacklightLevel = [[device backlightlevel] copy];
	[_dic setObject:(lastBacklightLevel == nil) ? NSLocalizedString(@"Unknow", @"") : lastBacklightLevel forKey:KTTBacklightLevel];

	
	[self.tableView reloadData];
	
	_timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerCome) userInfo:nil repeats:YES];
	
#if TARGET_IPHONE_SIMULATOR
	NSLog(@"TARGET_IPHONE_SIMULATOR");
#elif TARGET_OS_IPHONE
	NSLog(@"TARGET_OS_IPHONE");
#endif
}

- (void)timerCome
{
//	double batteryLevel = (NSInteger)[self batteryLevel];
//	if (batteryLevel != _lastBatteryLevel)
//	{
//		_lastBatteryLevel = batteryLevel;
//		if (batteryLevel < 0)
//		{
//			[_dic setObject:NSLocalizedString(@"Unknow", @"") forKey:KTTBatteryLevel];
//		}
//		else
//		{
//			[_dic setObject:[NSString stringWithFormat:@"%.4f%%", _lastBatteryLevel] forKey:KTTBatteryLevel];
//		}
//		
//		[self.tableView reloadData];
//	}
	
	BOOL needRedraw = NO;
	
	NSDictionary *dic = [self batteryLevel];
	int no1 = [[dic objectForKey:@"no1"] intValue];
	int no2 = [[dic objectForKey:@"no2"] intValue];
	if (no1 != _lastBatteryLevel)
	{
		needRedraw = YES;
		_lastBatteryLevel = no1;
		if (no1 < 0)
		{
			[_dic setObject:NSLocalizedString(@"Unknow", @"") forKey:KTTBatteryLevel];
		}
		else
		{
			[_dic setObject:[NSString stringWithFormat:@"%d%% [min=%d, max=%d]", no1 * 100 / no2, no1, no2] forKey:KTTBatteryLevel];
		}
	}
	
	NSString* backlightLevel = [[UIDevice currentDevice] backlightlevel];
	if ((lastBacklightLevel == nil && backlightLevel == nil) || [backlightLevel isEqualToString:lastBacklightLevel])
	{
	}
	else
	{
		needRedraw = YES;
		[lastBacklightLevel release];
		lastBacklightLevel = [backlightLevel copy];
		[_dic setObject:(lastBacklightLevel == nil) ? NSLocalizedString(@"Unknow", @"") : lastBacklightLevel forKey:KTTBacklightLevel];
	}
	
	if (needRedraw)
	{
		[self.tableView reloadData];
	}
}
			  
- (void)batteryLevelDidChange:(NSNotification *)notification
{
//	UIDevice* device = [UIDevice currentDevice];
//	float batteryLevel = [device batteryLevel];
//	if (batteryLevel < 0.0)
//	{
//		[_dic setObject:NSLocalizedString(@"Unknow", @"") forKey:KTTBatteryLevel];
//	}
//	else
//	{
//		double jqBatteryLevel = [self batteryLevel];
//		[_dic setObject:[NSString stringWithFormat:@"%d%% <%.4f> <%.4f>", (int)(batteryLevel * 100), batteryLevel, jqBatteryLevel] forKey:KTTBatteryLevel];
//	}
//	[self.tableView reloadData];
}


- (void)batteryStateDidChange:(NSNotification *)notification
{
	UIDevice* device = [UIDevice currentDevice];
	[_dic setObject:[arrBatteryState objectAtIndex:[device batteryState]] forKey:KTTBatteryState];
	[self.tableView reloadData];
}

- (NSString*) doDevicePlatform
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

- (void)viewDidUnload
{
	[_timer invalidate];
	
	[UIDevice currentDevice].batteryMonitoringEnabled = NO;
    
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryStateDidChangeNotification object:nil];
	
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_arrKey count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		[super configCell:cell];
    }
    UILabel *label = (UILabel *)[cell viewWithTag:6666];
	NSInteger row = [indexPath row];
	label.text = [NSString stringWithFormat:@"%d", row + 1];
    NSString* key = [_arrKey objectAtIndex:row];
	cell.textLabel.text = NSLocalizedString(key, @"");
	cell.detailTextLabel.text = [_dic objectForKey:key];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (NSString*) doDeviceNumberString
{
    NSString *platform = [self doDevicePlatform];
    if ([platform isEqualToString:@"iPhone1,1"])
    {
        return @"iPhone";
    }
    if ([platform isEqualToString:@"iPhone1,2"])
    {
        return @"iPhone3G";
    }
    if ([platform isEqualToString:@"iPhone2,1"])
    {
        return @"iPhone3GS";
    }
    if ([platform isEqualToString:@"iPhone3,1"])
    {
        return @"iPhone4";
    } 
	if ([platform isEqualToString:@"iPhone3,2"])
    {
        return @"iPhone4S";
    }
    if ([platform isEqualToString:@"iPod1,1"])
    {
        return @"iTouch";
    }
    if ([platform isEqualToString:@"iPod2,1"])
    {
        return @"iTouch2";
    }
    if ([platform isEqualToString:@"iPod3,1"])
    {
        return @"iTouch3";
    }
    if ([platform isEqualToString:@"iPod4,1"])
    {
        return @"iTouch4";
    }
    if ([platform isEqualToString:@"iPad1,1"])
    {
        return @"iPad";
    }
    if ([platform isEqualToString:@"iPad2,1"])
    {
        return @"iPad2";
    }
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])         
    {
        return @"iPhone Simulator";
    }
    
    return platform;
}

- (NSDictionary*)batteryLevel
{
//#if TARGET_IPHONE_SIMULATOR
//
//#elif TARGET_OS_IPHONE
	
	CFTypeRef blob = IOPSCopyPowerSourcesInfo();
	CFArrayRef sources = IOPSCopyPowerSourcesList(blob);
	
	CFDictionaryRef pSource = NULL;
	const void *psValue;
	
	int numOfSources = CFArrayGetCount(sources);
	if (numOfSources == 0)
	{
		NSLog(@"qhk: Error in CFArrayGetCount");
		return nil;
	}
	
	for (int i = 0 ; i < numOfSources ; i++)
	{
		pSource = IOPSGetPowerSourceDescription(blob, CFArrayGetValueAtIndex(sources, i));
		if (!pSource)
		{
			NSLog(@"qhk: Error in IOPSGetPowerSourceDescription");
			return nil;
		}
		
		psValue = (CFStringRef)CFDictionaryGetValue(pSource, CFSTR(kIOPSNameKey));
		
		int curCapacity = 0;
		int maxCapacity = 0;
//		double percent;
		
		psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSCurrentCapacityKey));
		CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &curCapacity);
		
		psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSMaxCapacityKey));
		CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &maxCapacity);
		
//		percent = ((double)curCapacity/(double)maxCapacity * 100.0f);
		
		NSNumber* no1 = [NSNumber numberWithInt:curCapacity];
		NSNumber* no2= [NSNumber numberWithInt:maxCapacity];
		
		return [NSDictionary dictionaryWithObjectsAndKeys:no1, @"no1", no2, @"no2", nil];
		
//		return percent;
//		return (NSInteger)(percent + 0.5f);
	}
//#endif
	
	return nil;
}

@end
