//
//  HardwareViewController.m
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-28.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <sys/sysctl.h>
#import <mach/mach_host.h>

#import "HardwareViewController.h"

const NSString* KTTMemorySize = @"hw.memsize";
const NSString* KTTNCPU = @"hw.ncpu";
const NSString* KTTCPUFrequency = @"hw.cpufrequency";
const NSString* KTTMemorySize_Wire = @"wireMemory";
const NSString* KTTMemorySize_Active = @"activeMemory";
const NSString* KTTMemorySize_Inactive = @"inactiveMemory";
const NSString* KTTMemorySize_Free = @"freeMemory";
const NSString* KTTMemoryPageSize = @"PageSize";

@implementation HardwareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[_arrKey addObject:KTTMemorySize];
	int memorySize = 0;
	size_t length = sizeof(memorySize);
	int nR = sysctlbyname("hw.memsize", &memorySize, &length, NULL, 0);
	NSString* description = [NSString stringWithFormat:@"%d len=%lu nR=%d", memorySize, length, nR];
	[_dic setObject:description forKey:KTTMemorySize];
	
	[_arrKey addObject:KTTNCPU];
	int numCpus = 0;
	length = sizeof(numCpus);
	nR = sysctlbyname("hw.ncpu", &numCpus, &length, NULL, 0);
	description = [NSString stringWithFormat:@"%d len=%lu nR=%d", numCpus, length, nR];
	[_dic setObject:description forKey:KTTNCPU];
	
	[_arrKey addObject:KTTCPUFrequency];
	long cpuFrequency = 0;
	length = sizeof(cpuFrequency);
	nR = sysctlbyname("hw.cpufrequency", &cpuFrequency, &length, NULL, 0);
	description = [NSString stringWithFormat:@"%d len=%lu nR=%d", cpuFrequency, length, nR];
	[_dic setObject:description forKey:KTTCPUFrequency];
	
	[_arrKey addObject:KTTMemoryPageSize];
	int pageSize = 0;
	length = sizeof(pageSize);
	nR = sysctlbyname("hw.pagesize", &pageSize, &length, NULL, 0);
	
	int pagesize2;
	int mib[6];	
	mib[0] = CTL_HW;
	mib[1] = HW_PAGESIZE;
	length = sizeof(pagesize2);
	if (sysctl(mib, 2, &pagesize2, &length, NULL, 0) < 0)
	{
		NSLog(@"getting page size");
	}
	description = [NSString stringWithFormat:@"%d %d len=%lu nR=%d", pageSize, pagesize2, length, nR];
	[_dic setObject:description forKey:KTTMemoryPageSize];
	
	[_arrKey addObject:KTTMemorySize_Wire];
	mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
	vm_statistics_data_t vmstat;
	if (host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmstat, &count) != KERN_SUCCESS)
	{
		NSLog(@"Failed to get VM statistics.");
		[_dic setObject:@"Failed to get VM statistics." forKey:KTTMemorySize_Wire];
	}
	else
	{
		float total = vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count;
		float wired = vmstat.wire_count / total;
		float active = vmstat.active_count / total;
		float inactive = vmstat.inactive_count / total;
		float free = vmstat.free_count / total;
		NSString *str = [NSString stringWithFormat:@"%d %d %d %d %.2f %.2f %.2f %.2f %.0f %.0f"
						 , vmstat.wire_count, vmstat.active_count, vmstat.inactive_count, vmstat.free_count
						 , wired, active, inactive, free
						 , total, total * pageSize
						 ];
		[_dic setObject:str forKey:KTTMemorySize_Wire];
	}
	
	int result;
	mib[0] = CTL_HW;
	mib[1] = HW_CPU_FREQ;
	length = sizeof(result);
	if (sysctl(mib, 2, &result, &length, NULL, 0) < 0)
	{
//		perror("getting cpu frequency");
	}
	printf("CPU Frequency = %u hz\n", result);
	
	int result2;
	mib[0] = CTL_HW;
	mib[1] = HW_BUS_FREQ;
	length = sizeof(result2);
	if (sysctl(mib, 2, &result2, &length, NULL, 0) < 0)
	{
//		perror("getting bus frequency");
	}
//	printf("Bus Frequency = %u hz\n", result);
	[_arrKey addObject:KTTMemorySize_Active];
	NSString *tmpStr = [NSString stringWithFormat:@"%d %d", result, result2];
	[_dic setObject:tmpStr forKey:KTTMemorySize_Active];
	
	[self.tableView reloadData];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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
	label.text = [NSString stringWithFormat:@"%d", [indexPath row] + 1];
	NSString* key = [_arrKey objectAtIndex:[indexPath row]];
    cell.textLabel.text = key;
	cell.detailTextLabel.text = [_dic objectForKey:key];
    
    return cell;
}


@end
