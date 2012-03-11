//
//  ViewController.m
//  ipaPng2Png
//
//  Created by 红凯 钱 on 12-3-11.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize _slider;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[ipaPngDir release];
	[normalPngDir release];
	
	[_slider release];
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSFileManager* fileManager = [NSFileManager defaultManager];
	ipaPngDir = [[documentsDirectory stringByAppendingPathComponent:@"ipaPng"] retain];
	normalPngDir = [[documentsDirectory stringByAppendingPathComponent:@"normalPng"] retain];
	[fileManager createDirectoryAtPath:ipaPngDir withIntermediateDirectories:YES attributes:nil error:nil];
	[fileManager createDirectoryAtPath:normalPngDir withIntermediateDirectories:YES attributes:nil error:nil];
}

- (void)viewDidUnload
{
	[self set_slider:nil];
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
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)btnConvertIpaPng2Png:(id)sender
{
	dispatch_block_t block = ^{
		NSFileManager* fileManager = [NSFileManager defaultManager];
		NSDirectoryEnumerator* direnum = [fileManager enumeratorAtPath:ipaPngDir];
		NSArray* allObjects = [direnum allObjects];
		dispatch_sync(dispatch_get_main_queue(), ^{
			_slider.minimumValue = 0;
			_slider.maximumValue = [allObjects count];
			[_slider setValue:0 animated:YES];
		});
		
		for (NSString* filePath in allObjects)
		{
			if ([filePath hasSuffix:@".png"])
			{
				NSString* fileFullPath = [ipaPngDir stringByAppendingPathComponent:filePath];
				BOOL isDirectory = NO;
				[fileManager fileExistsAtPath:fileFullPath isDirectory:&isDirectory];
				if (!isDirectory)
				{
					NSData * pngData =UIImagePNGRepresentation([UIImage imageWithContentsOfFile:fileFullPath]);
					[pngData writeToFile:[normalPngDir stringByAppendingPathComponent:filePath] atomically:YES];
				}
			}
			[NSThread sleepForTimeInterval:2];
			dispatch_async(dispatch_get_main_queue(), ^{
				[_slider setValue:(_slider.value + 1) animated:YES];
			});
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			UIButton* senderBtn = (UIButton *)sender;
			senderBtn.enabled = YES;
			[senderBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
		});
	};
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
	UIButton* senderBtn = (UIButton *)sender;
	senderBtn.enabled = NO;
	[senderBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
@end
