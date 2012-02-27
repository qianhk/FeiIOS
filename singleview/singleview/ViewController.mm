//
//  ViewController.m
//  singleview
//
//  Created by hongkai.qian on 12-2-9.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import <objc/runtime.h>
#include <notify.h>

#import "ViewController.h"
#import "LyricItem.h"


#define KTTMessagePort "com.ttpod.ttdesktop.port2"

static CFMessagePortRef messagePort = NULL;

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)dealloc
{
	if (messagePort != NULL)
	{
		CFRelease(messagePort);
	}
	
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 72, 37)];
	[btn1 setTitle:@"上一首" forState:UIControlStateNormal];
	[btn1 addTarget:self action:@selector(btn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
//	btn1
	[self.view addSubview:btn1];
	[btn1 release];
	
	UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[btn2 setFrame:CGRectMake(110, 10, 72, 37)];
	[btn2 setTitle:@"下一首" forState:UIControlStateNormal];
	[btn2 addTarget:self action:@selector(btn1Clicked:) forControlEvents:UIControlEventTouchDown];
	//	btn2
	[self.view addSubview:btn2];
	
	messagePort = CFMessagePortCreateRemote(kCFAllocatorDefault, CFSTR(KTTMessagePort));
	if (messagePort != NULL)
	{
		BOOL sucess = CFMessagePortIsValid(messagePort);
		NSLog(@"CFMessagePortCreateRemote result: 0x%08X %d", (int)messagePort, sucess);
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	CFRelease(messagePort);
	messagePort = NULL;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)btn1Clicked:(id)sender
{
//	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"BtnClicked" message:@"you clicked button" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
//	[alert show];
//	[alert release];
	if (_statusBar == nil)
	{
		_statusBar = [[KaiStatusBar alloc] initWithFrame:CGRectZero];
		[_statusBar showWithStatusMessage:@"测试这，测试那……"];
	}
	else
	{
		[_statusBar hide];
		[_statusBar release];
		_statusBar = nil;
	}
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
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)tttClicked:(id)sender
{
//	UIButton* aaa = (UIButton *)sender;
//	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"ttttttt" message:@"you clicked button" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
//	[alert show];
//	[alert release];
	
	
//	NSFileManager *fileManager = [NSFileManager defaultManager];  
//	NSDirectoryEnumerator *dirnum = [[NSFileManager defaultManager] enumeratorAtPath: @"/private/"];  
//	NSString *nextItem = nil;  
//	while( (nextItem = [dirnum nextObject]))
//	{  
//		if ([[nextItem pathExtension] isEqualToString: @"db"] 
//			|| [[nextItem pathExtension] isEqualToString: @"sqlitedb"])
//		{  
//	         if ([fileManager isReadableFileAtPath:nextItem])
//			 {  
//	             NSLog(@"kai:file can read. %@", nextItem);
//	         }
//	     }
//	}
	
//	NSString* filePath = @"/private/var/mobile/Media/general_storage/textfile.txt";
//	NSString* data = @"I am 凯凯";
//	NSError* error = nil;
//	BOOL sucess = [data writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
//	NSLog(@"kai write %d, %@", sucess, error);
	
//	id xxxx = objc_getClass("SBWiFiManager");
//	[[xxxx sharedInstance] setWiFiEnabled:NO];
	
	uint32_t r = notify_post("com.ttpod.kaisubstrate.eventname");
	NSLog(@"kai_eventname:r=%d", r);
}

- (IBAction)wifi_off:(id)sender
{
	uint32_t r = notify_post("com.ttpod.kaisubstrate.wifi_off");
	NSLog(@"kai_wifi_off:r=%d", r);
}

- (IBAction)wifi_on:(id)sender
{
	uint32_t r = notify_post("com.ttpod.kaisubstrate.wifi_on");
	NSLog(@"kai_wifi_on:r=%d", r);
}

- (IBAction)nsnumberused:(id)sender
{
	NSNumber* number = [NSNumber numberWithLongLong:6789];
	long long value = [number longLongValue];
	NSLog(@"singleview: long long value is %lld", value);
}

- (IBAction)btnPortClicked:(id)sender
{
	if (messagePort == NULL) return;
	
	UIButton* btn = (UIButton *)sender;
	CFDataRef data = NULL;
	SInt32 rPort = 0;
	switch (btn.tag)
	{
		case 1001:
		{
			char message[256] = "kai";
			data = CFDataCreate(NULL, (UInt8 *)message, strlen(message) + 1);
			if (data != NULL)
			{
				rPort = CFMessagePortSendRequest(messagePort, btn.tag, data, 0.0, 0.0, NULL, NULL);
				CFRelease(data);
				NSLog(@"qhk: CFMessagePortSendRequest result: %ld", rPort);
			}
			else
			{
				NSLog(@"qhk: create data error");
			}
		}
			break;
			
		case 1002:
		{
			
			rPort = CFMessagePortSendRequest(messagePort, btn.tag, NULL, 0.0, 0.0, NULL, NULL);
			NSLog(@"qhk: CFMessagePortSendRequest result: %ld", rPort);
		}
			break;
			
		case 1003:
		{
			int count = 100;
			for (int idx = 0; idx < count; ++idx)
			{
				rPort = CFMessagePortSendRequest(messagePort, btn.tag, NULL, 0.0, 0.0, NULL, NULL);
				if (rPort != 0)
				{
					NSLog(@"qhk: CFMessagePortSendRequest result: %ld", rPort);
					break;
				}
				[NSThread sleepForTimeInterval:0.075];
			}
		}
			break;
			
		case 1004:
		{
			char message[200 * 1024] = "kai 200 * 1024";
			data = CFDataCreate(NULL, (UInt8 *)message, 200 * 1024);
			if (data != NULL)
			{
				rPort = CFMessagePortSendRequest(messagePort, btn.tag, data, 0.0, 0.0, NULL, NULL);
				CFRelease(data);
				NSLog(@"qhk: CFMessagePortSendRequest result: %ld", rPort);
			}
			else
			{
				NSLog(@"qhk: create data error");
			}
		}
			break;
			
		default:
			break;
	}
}

- (IBAction)btnNSCoderClicked:(id)sender
{
	LyricData* oriLyricData = [[LyricData alloc] init];
	NSLog(@"Ori LyricData: %@", oriLyricData);
	
	NSData* oriData = [NSKeyedArchiver archivedDataWithRootObject:oriLyricData];
	NSLog(@"oriData len=%d %@", [oriData length], oriData);
	
	
	LyricData* afterLyricData = [NSKeyedUnarchiver unarchiveObjectWithData:oriData];
	NSLog(@"after LyricData: %@", afterLyricData);
}
@end
