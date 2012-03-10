//
//  ViewController.m
//  GCDOnIOS
//
//  Created by kai on 12-3-10.
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (void)dealloc {
    [_slider release];
    [super dealloc];
}
- (IBAction)btn_GcdSourceTypeDataAddBegin:(id)sender
{
	[_slider setValue:0 animated:YES];
	
	dispatch_block_t block = ^{
		dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
		dispatch_source_set_event_handler(source, ^{
			_slider.value += dispatch_source_get_data(source);
			NSLog(@"silder value is :%.0f", _slider.value);
		});
		dispatch_resume(source);
		dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		dispatch_apply(100, globalQueue, ^(size_t index) {
			dispatch_source_merge_data(source, 1);
//			NSLog(@"%@", [NSThread currentThread]);
			[NSThread sleepForTimeInterval:0.5];
		});
		dispatch_release(globalQueue);
		dispatch_release(source);
	};
	
	dispatch_queue_t queue = dispatch_queue_create("com.njnu.kai.gcconios", 0);
	dispatch_async(queue, block);
	dispatch_release(queue);
}

- (IBAction)btn_SourceSetTimer:(id)sender
{
	[_slider setValue:0 animated:YES];
	dispatch_block_t block = ^{
		dispatch_semaphore_t sem = dispatch_semaphore_create(0);
		dispatch_source_t timesource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
		dispatch_source_set_event_handler(timesource, ^{
			_slider.value += 1;
			NSLog(@"silder value is :%.0f %lu", _slider.value, dispatch_source_get_data(timesource));
			if (_slider.value >= 100)
			{
				dispatch_semaphore_signal(sem);
			}
		});
		dispatch_resume(timesource);
		dispatch_time_t startTime = dispatch_time(0, 0);
		dispatch_source_set_timer(timesource, startTime, 50 * 1000 * 1000, 1 * 1000 * 1000 * 1000);
		dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//		dispatch_source_cancel(timesource);
		dispatch_release(timesource);
		dispatch_release(sem);
	};
	
//	dispatch_queue_t queue = dispatch_queue_create("com.njnu.kai.gcconios", 0);
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, block);
	dispatch_release(queue);
}
@end
