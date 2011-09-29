//
//  GeneralInfoController.m
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <sys/sysctl.h>

#import "GeneralViewController.h"

@implementation GeneralViewController

const NSString* KTTUDID = @"UDID";
const NSString* KTTModel = @"Model";
const NSString* KTTName = @"Name";
const NSString* KTTLocalizedModel = @"Localized Model";
const NSString* KTTSystemName = @"System Name";
const NSString* KTTSystemVersion = @"System Version";
const NSString* KTTDevicePlatform = @"Device Platform";
const NSString* KTTBatteryState = @"Battery State";
const NSString* KTTBatteryLevel = @"Battery Level";
const NSString* KTTUserInterfaceIdiom = @"UserInterfaceIdiom";
const NSString* KTTOrientation = @"Orientation";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
	{
		arrBatteryState = [[NSArray alloc] initWithObjects: @"Unknow", @"Unplugged", @"Charging", @"Full", nil];
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
	
	[super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	UIDevice* device = [UIDevice currentDevice];
    NSString* udid = [device uniqueIdentifier];
	[_arrKey addObject:KTTUDID];
	[_dic setObject:udid forKey:KTTUDID];
	
	[_arrKey addObject:KTTModel];
	[_dic setObject:[device model] forKey:KTTModel];
	
	[_arrKey addObject:KTTName];
	[_dic setObject:[device name] forKey:KTTName];
	
	[_arrKey addObject:KTTLocalizedModel];
	[_dic setObject:[device localizedModel] forKey:KTTLocalizedModel];
	
	[_arrKey addObject:KTTSystemName];
	[_dic setObject:[device systemName] forKey:KTTSystemName];
	
	[_arrKey addObject:KTTSystemVersion];
	[_dic setObject:[device systemVersion] forKey:KTTSystemVersion];
	
	NSString* devicePlatform = [self performSelector:@selector(doDevicePlatform) withObject:nil];
	[_arrKey addObject:KTTDevicePlatform];
	[_dic setObject:devicePlatform forKey:KTTDevicePlatform];

	[_arrKey addObject:KTTBatteryState];
	[_dic setObject:[arrBatteryState objectAtIndex:[device batteryState]] forKey:KTTBatteryState];
	
	[_arrKey addObject:KTTBatteryLevel];
	float batteryLevel = [device batteryLevel];
	if (batteryLevel < 0.0)
	{
		[_dic setObject:@"Unknow" forKey:KTTBatteryLevel];
	}
	else
	{
		[_dic setObject:[NSString stringWithFormat:@"%.2f", batteryLevel] forKey:KTTBatteryLevel];
	}

	
	[_arrKey addObject:KTTUserInterfaceIdiom];
	if ([device userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
	{
		[_dic setObject:@"iPhone and iPod touch style" forKey:KTTUserInterfaceIdiom];
	}
	else
	{
		[_dic setObject:@"iPad style UI" forKey:KTTUserInterfaceIdiom];
	}
	
	[_arrKey addObject:KTTOrientation];
	[_dic setObject:[arrOrientation objectAtIndex:[device orientation]] forKey:KTTOrientation];
}

- (NSString*) doDevicePlatform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    NSString* text = [_arrKey objectAtIndex:row];
	cell.textLabel.text = text;
	cell.detailTextLabel.text = [_dic objectForKey:text];
    
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

@end
