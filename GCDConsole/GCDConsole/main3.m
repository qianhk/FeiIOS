//
//  main2.m
//  GCDConsole
//
//  Created by kai on 12-3-8.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <Foundation/Foundation.h>

static void CalculateSumOfArray1(int length)
{
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_group_t group = dispatch_group_create();
	
	__block int sum1 = 0;
	__block int sum2 = 0;
	__block const int len = length;
	
	void (^task1Block)(void) = ^(void)
	{
		int halflen = len / 2;
		for (int i = 0; i < halflen; ++i)
		{
			++sum1;
		}
	};
	
	dispatch_block_t task2Block = ^(void)
	{
		for (int i = len / 2; i < len; ++i)
		{
			++sum2;
		}
	};
	
	NSDate* date1 = [NSDate date];
	
	dispatch_group_async(group, queue, task1Block);
	dispatch_group_async(group, queue, task2Block);
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	
	NSDate* date2 = [NSDate date];
	NSLog(@"The sum1 is: %d. times=%.2f \n", sum1 + sum2, [date2 timeIntervalSinceDate:date1]);
	
	
	dispatch_release(group);
	dispatch_release(queue);
}

static void CalculateSumOfArray2(int length)
{
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	__block int sum = 0;
	
	NSDate* date1 = [NSDate date];
	dispatch_apply(length, queue, ^(size_t i) {
		++sum;
	});
	
	NSDate* date2 = [NSDate date];
	NSLog(@"The sum2 is: %d. times=%.2f \n", sum, [date2 timeIntervalSinceDate:date1]);
	
	dispatch_release(queue);
}

static void CalculateSumOfArray0(int length)
{
	NSDate* date1 = [NSDate date];
	int sum = 0;
	for (int i = 0; i < length; ++i)
	{
		++sum;
	}
	NSDate* date2 = [NSDate date];
	NSLog(@"The sum0 is: %d. times=%.2f \n", sum, [date2 timeIntervalSinceDate:date1]);
}

int main(int argc, const char * argv[])
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	const int len = 2 * 10000 * 10000;
	
	CalculateSumOfArray0(len);
	CalculateSumOfArray1(len);
	CalculateSumOfArray2(len);
	
	[pool drain];
	
	return 0;
}





