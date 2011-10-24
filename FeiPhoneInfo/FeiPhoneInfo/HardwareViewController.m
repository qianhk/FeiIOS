//
//  HardwareViewController.m
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-28.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <sys/sysctl.h>
#import <mach/mach_host.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

#import "HardwareViewController.h"
#import "UIDevice-Hardware.h"
#import "UIDevice-Reachability.h"

const NSString* KTTMemorySize = @"Total Memory";
const NSString* KTTNCPU = @"hw.ncpu";
const NSString* KTTCPUFrequency = @"Cpu frequency";
const NSString* KTTMemorySize_Wire = @"wire Memory";
const NSString* KTTMemorySize_Active = @"active Memory";
const NSString* KTTMemorySize_Inactive = @"inactive Memory";
const NSString* KTTMemorySize_Free = @"free Memory";
const NSString* KTTMemoryUser = @"User Memory";
const NSString* KTTMemoryPageSize = @"PageSize";
const NSString* KTTBusFrequency = @"Bus Frequency";
const NSString* KTTTotalDiskSpace = @"Total DiskSpace";
const NSString* KTTFreeDiskSpace = @"Free DiskSpace";
const NSString* KTTMacAddress = @"Mac Address";
const NSString* KTTReachabilityStatus = @"Reachability Status";
const NSString* KTTLocalIP = @"Local IP";
const NSString* KTTNetIP = @"Net IP";

@interface HardwareViewController()

- (void)printmacinfo;

@end

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

- (void)dealloc
{
	[_lastFreeDiskSpace release];
	[_lastFreeDiskSpaceStr release];
	[_lastMemoryWire release];
	[_lastMemoryActive release];
	[_lastMemoryInactive release];
	[_lastMemoryFree release];
	[_lastUserMemoryStr release];
	[reachable release];
	
	[super dealloc];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

//#include <stdio.h>
//#include <stdlib.h>
//#include <ifaddrs.h>
//#include <string.h>
//#include <stdbool.h>
//#include <arpa/inet.h>
//#include <sys/types.h>
//#include <sys/socket.h>
//#include <net/if.h>
//#include <net/if_dl.h>
//#include <arpa/inet.h>
//#include <ifaddrs.h>
//
//#if !defined(IFT_ETHER)
//#define IFT_ETHER 0x6/* Ethernet CSMACD */
//#endif
//
//
//- (void)printmacinfo
//{
//	bool success;
//	struct ifaddrs *addrs;
//	const struct ifaddrs *cursor;
//	const struct sockaddr_dl *dlAddr;
//	const uint8_t *base;
//	
//	success = getifaddrs(&addrs) == 0;
//	if (success)
//	{
//		cursor = addrs;
//		NSInteger idx = 0;
//		while (cursor != NULL)
//		{
//			++idx;
//			NSString* macTitle = nil;
//			if ((cursor->ifa_flags & IFF_LOOPBACK) == 0 )
//			{
//				char* ifaname = (char *)cursor->ifa_name;
//				char* addr = inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr);
//				printf("%s ", ifaname);
//				printf("%s\n", addr);
////				NSString* tmpstr1 = [NSString stringWithCString:ifaname encoding:NSUTF8StringEncoding];
////				NSString* tmpstr2 = [NSString stringWithCString:addr encoding:NSUTF8StringEncoding];
////				NSString *tmpStr = [NSString stringWithFormat:@"%@ %@", tmpstr1, tmpstr2];
//				
//				macTitle = [NSString stringWithFormat:@"%d %s %s", idx, ifaname, addr];
//				
//				[_arrKey addObject:macTitle];
//			}
//			if ( (cursor->ifa_addr->sa_family == AF_LINK)
//				&& (((const struct sockaddr_dl *) cursor->ifa_addr)->sdl_type ==IFT_ETHER)
//				)
//			{
//				dlAddr = (const struct sockaddr_dl *) cursor->ifa_addr;
//				// fprintf(stderr, " sdl_nlen = %d\n", dlAddr->sdl_nlen);
//				// fprintf(stderr, " sdl_alen = %d\n", dlAddr->sdl_alen);
//				base = (const uint8_t *) &dlAddr->sdl_data[dlAddr->sdl_nlen];
//				printf(" MAC address ");
//				NSMutableString* tmpString = [[[NSMutableString alloc] initWithString:@"Mac:"] autorelease];
//				for (int i = 0; i < dlAddr->sdl_alen; i++)
//				{
//					if (i != 0)
//					{
//						printf(":");
//						[tmpString appendString:@":"];
//					}
//					printf("%02x", base[i]);
//					[tmpString appendFormat:@"%02X", base[i]];
//				} 
//				printf("\n");
//				[_dic setObject:tmpString forKey:macTitle];
//			}
//			else if (macTitle != nil)
//			{
//				[_dic setObject:@"" forKey:macTitle];
//			}
//			cursor = cursor->ifa_next;
//		}
//	}
//}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIDevice* device = [UIDevice currentDevice];
	
	[_arrKey addObject:KTTMemorySize];
//	int memorySize = 0;
//	size_t length = sizeof(memorySize);
//	int nR = sysctlbyname("hw.memsize", &memorySize, &length, NULL, 0);
//	NSString* description = [NSString stringWithFormat:@"%d len=%lu nR=%d", memorySize, length, nR];
//	[_dic setObject:description forKey:KTTMemorySize];
	float totalMemory = [device totalMemory] / 1024 / 1024;
	[_dic setObject:[NSString stringWithFormat:@"%.2f MB", totalMemory] forKey:KTTMemorySize];
	
//	[_arrKey addObject:KTTNCPU];
//	int numCpus = 0;
//	length = sizeof(numCpus);
//	nR = sysctlbyname("hw.ncpu", &numCpus, &length, NULL, 0);
//	description = [NSString stringWithFormat:@"%d len=%lu nR=%d", numCpus, length, nR];
//	[_dic setObject:description forKey:KTTNCPU];
//	
	[_arrKey addObject:KTTCPUFrequency];
//	long cpuFrequency = 0;
//	length = sizeof(cpuFrequency);
//	nR = sysctlbyname("hw.cpufrequency", &cpuFrequency, &length, NULL, 0);
//	description = [NSString stringWithFormat:@"%d len=%lu nR=%d", cpuFrequency, length, nR];
	float cpuFrequency = 0.0f;
	if ([device platformType] == UIDevice4iPhone)
	{
		cpuFrequency = 800.0f;
	}
	else
	{
		cpuFrequency = [device cpuFrequency] / 1000000;
	}
	[_dic setObject:[NSString stringWithFormat:@"%.2f MHz", cpuFrequency] forKey:KTTCPUFrequency];
	
	[_arrKey addObject:KTTBusFrequency];
	float busFrequency = [device busFrequency] / 1000000;
	[_dic setObject:[NSString stringWithFormat:@"%.2f MHz", busFrequency] forKey:KTTBusFrequency];
	
	[_arrKey addObject:KTTMacAddress];
	[_dic setObject:[device macaddress] forKey:KTTMacAddress];
	
	
	reachable = [[Reachability reachabilityWithHostName:@"www.baidu.com"] retain];
	NSString* reachableStatus = nil;
	NetworkStatus netstatus = [reachable currentReachabilityStatus];
    switch (netstatus)
	{
		case NotReachable:
			// 没有网络连接
			reachableStatus = NSLocalizedString(@"No Network", "");
			break;
		case ReachableViaWWAN:
			// 使用3G网络
			reachableStatus = @"GPRS/3G";
			break;
		case ReachableViaWiFi:
			// 使用WiFi网络
			reachableStatus = @"WIFI";
			break;
    }
	[_arrKey addObject:KTTReachabilityStatus];
	[_dic setObject:reachableStatus forKey:KTTReachabilityStatus];
	
	[_arrKey addObject:KTTLocalIP];
	NSString* localIp = nil;
	if (netstatus != NotReachable)
	{
		localIp = [device localIPAddress];
	}
	[_dic setObject:(localIp == nil) ? NSLocalizedString(@"no IP", "") : localIp forKey:KTTLocalIP];
	
	[_arrKey addObject:KTTNetIP];
	NSString* netIp = nil;
	if (localIp != nil)
	{
		netIp = NSLocalizedString(@"Loading...", "");
//		[self performSelector:@selector(getNetIP) withObject:nil afterDelay:0];
		[NSThread detachNewThreadSelector:@selector(getNetIPThread) toTarget:self withObject:nil];
	}
	[_dic setObject:(netIp == nil) ? NSLocalizedString(@"no IP", "") : netIp forKey:KTTNetIP];
	
	
	
	[_arrKey addObject:KTTTotalDiskSpace];
	float totalDiskSpace = [[device totalDiskSpace] floatValue] / 1024 / 1024 / 1024;
	[_dic setObject:[NSString stringWithFormat:@"%.2f GB", totalDiskSpace] forKey:KTTTotalDiskSpace];
	
	[_arrKey addObject:KTTFreeDiskSpace];
	_lastFreeDiskSpace = [[device freeDiskSpace] retain];
	float freeDiskSpace = [_lastFreeDiskSpace floatValue] / 1024 / 1024 / 1024;
	_lastFreeDiskSpaceStr = [[NSString stringWithFormat:@"%.2f GB", freeDiskSpace] retain];
	[_dic setObject:_lastFreeDiskSpaceStr forKey:KTTFreeDiskSpace];
	
	[_arrKey addObject:KTTMemoryUser];
	float userMemory = [device userMemory] / 1024 / 1024;
	_lastUserMemoryStr = [[NSString stringWithFormat:@"%.2f MB", userMemory] retain];
	[_dic setObject:_lastUserMemoryStr forKey:KTTMemoryUser];
	
//	[_arrKey addObject:KTTBusFrequency];
//	[_dic setObject:[NSString stringWithFormat:@"%lu", [device busFrequency]] forKey:KTTBusFrequency];
	
	[_arrKey addObject:KTTMemoryPageSize];
	pageSize = 0;
	size_t length = sizeof(pageSize);
	sysctlbyname("hw.pagesize", &pageSize, &length, NULL, 0);
	[_dic setObject:[NSString stringWithFormat:@"%d B", pageSize] forKey:KTTMemoryPageSize];
//	
//	int pagesize2;
//	int mib[6];	
//	mib[0] = CTL_HW;
//	mib[1] = HW_PAGESIZE;
//	length = sizeof(pagesize2);
//	if (sysctl(mib, 2, &pagesize2, &length, NULL, 0) < 0)
//	{
//		NSLog(@"getting page size");
//	}
//	description = [NSString stringWithFormat:@"%d %d len=%lu nR=%d", pageSize, pagesize2, length, nR];
//	[_dic setObject:description forKey:KTTMemoryPageSize];
	
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
		float wired = vmstat.wire_count / total * 100;
		float active = vmstat.active_count / total * 100;
		float inactive = vmstat.inactive_count / total * 100;
		float free = vmstat.free_count / total * 100;
//		NSString *str = [NSString stringWithFormat:@"%d %d %d %d %.2f %.2f %.2f %.2f %.0f %.0f"
//						 , vmstat.wire_count, vmstat.active_count, vmstat.inactive_count, vmstat.free_count
//						 , wired, active, inactive, free
//						 , total, total * pageSize
//						 ];
		float tmpMemorySize = vmstat.wire_count * pageSize / 1024 / 1024;
		_lastMemoryWire = [[NSString stringWithFormat:@"%.2f MB (%d%%)", tmpMemorySize, (int)wired] retain];
		[_dic setObject:_lastMemoryWire forKey:KTTMemorySize_Wire];
		
		[_arrKey addObject:KTTMemorySize_Active];
		tmpMemorySize = vmstat.active_count * pageSize / 1024 / 1024;
		_lastMemoryActive = [[NSString stringWithFormat:@"%.2f MB (%d%%)", tmpMemorySize, (int)active] retain];
		[_dic setObject:_lastMemoryActive forKey:KTTMemorySize_Active];
		
		[_arrKey addObject:KTTMemorySize_Inactive];
		tmpMemorySize = vmstat.inactive_count * pageSize / 1024 / 1024;
		_lastMemoryInactive = [[NSString stringWithFormat:@"%.2f MB (%d%%)", tmpMemorySize, (int)inactive] retain];
		[_dic setObject:_lastMemoryInactive forKey:KTTMemorySize_Inactive];
		
		[_arrKey addObject:KTTMemorySize_Free];
		tmpMemorySize = vmstat.free_count * pageSize / 1024 / 1024;
		_lastMemoryFree = [[NSString stringWithFormat:@"%.2f MB (%d%%)", tmpMemorySize, (int)free] retain];
		[_dic setObject:_lastMemoryFree forKey:KTTMemorySize_Free];
	}
	
//	int result;
//	mib[0] = CTL_HW;
//	mib[1] = HW_CPU_FREQ;
//	length = sizeof(result);
//	if (sysctl(mib, 2, &result, &length, NULL, 0) < 0)
//	{
////		perror("getting cpu frequency");
//	}
//	printf("CPU Frequency = %u hz\n", result);
//	
//	int result2;
//	mib[0] = CTL_HW;
//	mib[1] = HW_BUS_FREQ;
//	length = sizeof(result2);
//	if (sysctl(mib, 2, &result2, &length, NULL, 0) < 0)
//	{
////		perror("getting bus frequency");
//	}
////	printf("Bus Frequency = %u hz\n", result);
//	[_arrKey addObject:KTTMemorySize_Active];
//	NSString *tmpStr = [NSString stringWithFormat:@"%d %d", result, result2];
//	[_dic setObject:tmpStr forKey:KTTMemorySize_Active];
//	
//	[self printmacinfo];
	
	[self.tableView reloadData];
	
	_timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(timerCome) userInfo:nil repeats:YES];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged) name:kReachabilityChangedNotification object:nil];
	
	[reachable startNotifier];
	
//	[device scheduleReachabilityWatcher:self];
}

- (void)reachabilityChanged
{
	NSString* reachableStatus = nil;
	NetworkStatus netstatus = [reachable currentReachabilityStatus];
    switch (netstatus)
	{
		case NotReachable:
			// 没有网络连接
			reachableStatus = NSLocalizedString(@"No Network", "");
			break;
		case ReachableViaWWAN:
			// 使用3G网络
			reachableStatus = @"GPRS/3G";
			break;
		case ReachableViaWiFi:
			// 使用WiFi网络
			reachableStatus = @"WIFI";
			break;
    }
	[_dic setObject:reachableStatus forKey:KTTReachabilityStatus];
	
	NSString* localIp = nil;
	if (netstatus != NotReachable)
	{
		localIp = [[UIDevice currentDevice] localIPAddress];
	}
	[_dic setObject:(localIp == nil) ? NSLocalizedString(@"no IP", "") : localIp forKey:KTTLocalIP];
	
	NSString* netIp = nil;
	if (localIp != nil)
	{
		netIp = NSLocalizedString(@"Loading...", "");
		[NSThread detachNewThreadSelector:@selector(getNetIPThread) toTarget:self withObject:nil];
	}
	[_dic setObject:(netIp == nil) ? NSLocalizedString(@"no IP", "") : netIp forKey:KTTNetIP];
	
	[self.tableView reloadData];
}

- (void)timerCome
{
	BOOL needReload = NO;
	
	UIDevice* device = [UIDevice currentDevice];
	
	NSNumber* freeDiskSpace = [device freeDiskSpace];
	if (![freeDiskSpace isEqualToNumber:_lastFreeDiskSpace])
	{
		[_lastFreeDiskSpace release];
		_lastFreeDiskSpace = [freeDiskSpace retain];
	
		float freeDiskSpaceValue = [_lastFreeDiskSpace floatValue] / 1024 / 1024 / 1024;
		NSString* thisDiskSpaceStr = [NSString stringWithFormat:@"%.2f GB", freeDiskSpaceValue];
		if (![thisDiskSpaceStr isEqualToString:_lastFreeDiskSpaceStr])
		{
			needReload = YES;
			[_lastFreeDiskSpaceStr release];
			_lastFreeDiskSpaceStr = [thisDiskSpaceStr retain];
			[_dic setObject:_lastFreeDiskSpaceStr forKey:KTTFreeDiskSpace];
		}
	}
	
	float userMemory = [device userMemory] / 1024 / 1024;
	NSString* thisStr = [NSString stringWithFormat:@"%.2f MB", userMemory];
	if (![thisStr isEqualToString:_lastUserMemoryStr])
	{
		needReload = YES;
		[_lastUserMemoryStr release];
		_lastUserMemoryStr = [thisStr retain];
		[_dic setObject:_lastUserMemoryStr forKey:KTTMemoryUser];
	}
	
	
	mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
	vm_statistics_data_t vmstat;
	if (host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmstat, &count) != KERN_SUCCESS)
	{
		needReload = YES;
		NSLog(@"Failed to get VM statistics.");
		[_dic setObject:@"Failed to get VM statistics." forKey:KTTMemorySize_Wire];
	}
	else
	{
		float total = vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count;
		float wired = vmstat.wire_count / total * 100;
		float active = vmstat.active_count / total * 100;
		float inactive = vmstat.inactive_count / total * 100;
		float free = vmstat.free_count / total * 100;

		float tmpMemorySize = vmstat.wire_count * pageSize / 1024 / 1024;
		thisStr = [NSString stringWithFormat:@"%.2f MB (%d%%)", tmpMemorySize, (int)wired];
		if (![thisStr isEqualToString:_lastMemoryWire])
		{
			needReload = YES;
			[_lastMemoryWire release];
			_lastMemoryWire = [thisStr retain];
			[_dic setObject:_lastMemoryWire forKey:KTTMemorySize_Wire];
		}

		tmpMemorySize = vmstat.active_count * pageSize / 1024 / 1024;
		thisStr = [NSString stringWithFormat:@"%.2f MB (%d%%)", tmpMemorySize, (int)active];
		if (![thisStr isEqualToString:_lastMemoryActive])
		{
			needReload = YES;
			[_lastMemoryActive release];
			_lastMemoryActive = [thisStr retain];
			[_dic setObject:_lastMemoryActive forKey:KTTMemorySize_Active];
		}

		tmpMemorySize = vmstat.inactive_count * pageSize / 1024 / 1024;
		thisStr = [NSString stringWithFormat:@"%.2f MB (%d%%)", tmpMemorySize, (int)inactive];
		if (![thisStr isEqualToString:_lastMemoryInactive])
		{
			needReload = YES;
			[_lastMemoryInactive release];
			_lastMemoryInactive = [thisStr retain];
			[_dic setObject:_lastMemoryInactive forKey:KTTMemorySize_Inactive];
		}

		tmpMemorySize = vmstat.free_count * pageSize / 1024 / 1024;
		thisStr = [NSString stringWithFormat:@"%.2f MB (%d%%)", tmpMemorySize, (int)free];
		if (![thisStr isEqualToString:_lastMemoryFree])
		{
			needReload = YES;
			[_lastMemoryFree release];
			_lastMemoryFree = [thisStr retain];
			[_dic setObject:_lastMemoryFree forKey:KTTMemorySize_Free];
		}
	}
	
	if (needReload)
	{
		[self.tableView reloadData];
	}
}

- (void)getNetIPThread
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
	NSString* netIp = [[UIDevice currentDevice] whatismyipdotcom];
	[_dic setObject:(netIp == nil) ? NSLocalizedString(@"no IP", "") : netIp forKey:KTTNetIP];
    
    [self performSelectorOnMainThread:@selector(getNetIPFinish) withObject:nil waitUntilDone:NO];
    
    [pool release];
}

- (void)getNetIPFinish
{
	[self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	[_timer invalidate];
	[reachable stopNotifier];
//	[[UIDevice currentDevice] unscheduleReachabilityWatcher];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
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
    cell.textLabel.text = NSLocalizedString(key, "");
	cell.detailTextLabel.text = [_dic objectForKey:key];
    
    return cell;
}


@end
