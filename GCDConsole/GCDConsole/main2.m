//
//  main2.m
//  GCDConsole
//
//  Created by kai on 12-3-8.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <Foundation/Foundation.h>

static void CalculateSumOfArray1(int *array, int length)
{
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_group_t group = dispatch_group_create();
	
	__block int sum1 = 0;
	__block int sum2 = 0;
	__block const int len = length;
	
	void (^task1Block)(void) = ^(void)
	{
		for (int i = 0; i < len / 2; ++i)
		{
			sum1 += array[i];
		}
	};
	
	dispatch_block_t task2Block = ^(void)
	{
		for (int i = len / 2; i < len; ++i)
		{
			sum2 += array[i];
		}
	};
	
	NSDate* date1 = [NSDate date];
	
	dispatch_group_async(group, queue, task1Block);
	dispatch_group_async(group, queue, task2Block);
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	
	dispatch_release(group);
	dispatch_release(queue);
	
	NSDate* date2 = [NSDate date];
	NSLog(@"The sum1 is: %d. times=%.2f \n", sum1 + sum2, [date2 timeIntervalSinceDate:date1]);
}

static void CalculateSumOfArray2(int *array, int length)
{
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	__block int sum = 0;
	__block int *pArray = array;
	
	NSDate* date1 = [NSDate date];
	dispatch_apply(length, queue, ^(size_t i) {
		sum += pArray[i];
//		NSLog(@"CalculateSumOfArray2 thread is: %@", [NSThread currentThread]);
	});
	
	dispatch_release(queue);
	
	NSDate* date2 = [NSDate date];
	NSLog(@"The sum2 is: %d. times=%.2f \n", sum, [date2 timeIntervalSinceDate:date1]);
}

static void CalculateSumOfArray0(int *array, int length)
{
	NSDate* date1 = [NSDate date];
	int sum = 0;
	for (int i = 0; i < length; ++i)
	{
		sum += array[i];
	}
	NSDate* date2 = [NSDate date];
	NSLog(@"The sum0 is: %d. times=%.2f \n", sum, [date2 timeIntervalSinceDate:date1]);
}

int main2(int argc, const char * argv[]);
int main2(int argc, const char * argv[])
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	const int len = 1 * 10000 * 10000;
	int *p = (int *)malloc(len * sizeof(*p));
	for (int i = 0; i < len; ++i)
	{
		p[i] = i + 1;
	}
	
	CalculateSumOfArray0(p, len);
	CalculateSumOfArray1(p, len);
	CalculateSumOfArray2(p, len);
	
	[pool drain];
	
	return 0;
}





