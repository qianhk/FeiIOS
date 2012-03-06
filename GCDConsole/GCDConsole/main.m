//
//  main.m
//  GCDConsole
//
//  Created by 红凯 钱 on 12-3-6.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <Foundation/Foundation.h>

static int myArray[100];
static volatile BOOL flag = NO;

static void init(void)
{
	int sum = 1;
	for (int i = 0; i < 100; ++i, ++sum)
	{
		myArray[i] = sum + 1;
	}
}

int main (int argc, const char * argv[])
{

	@autoreleasepool
	{
		init();
		NSLog(@"At MainThread: %@", [NSThread currentThread]);
	    dispatch_queue_t queue = dispatch_queue_create("com.njnu.kai.gcdtest", NULL);
		dispatch_async(queue, ^{
			int sum = 0;
			for (int i = 0; i < 100; ++i)
			{
				sum += myArray[i];
			}
			NSLog(@"The sum is: %d, At which thread: %@", sum, [NSThread currentThread]);
			flag = YES;
		});
		while (!flag);
	    
	}
    return 0;
}

