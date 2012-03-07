//
//  main.m
//  GCDConsole
//
//  Created by kai on 12-3-6.
//  Copyright (c) 2012年 SDS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INTRIN_RDTSC(tick) __asm__("rdtsc" : "=A"(tick))

#define ELEMENT_COUNT 1024 * 1024

extern long cmpxchg_64(register long cmpData, register long *loadReg, register volatile long *pMem);
//extern long cmpxchg_64(register long cmpData, register long *loadReg, register volatile long *pMem);

static int array1[ELEMENT_COUNT];
static int array2[ELEMENT_COUNT];

static void init(void)
{
	for (int i = 0; i < ELEMENT_COUNT; ++i)
	{
		array1[i] = rand() % 100;
		array2[i] = i;
	}
	array2[ELEMENT_COUNT / 2] = ELEMENT_COUNT;
}

static volatile long counter = 0;

static void WriteCounter(dispatch_semaphore_t sem)
{
	register long oldValue = counter;
	long newValue = oldValue + 1;
	while (!cmpxchg_64(oldValue, &newValue, &counter))
	{
		oldValue = newValue;
		newValue = oldValue + 1;
	}
	
	if (newValue == 4)
	{
		dispatch_semaphore_signal(sem);
	}
}

int main (int argc, const char * argv[])
{

	@autoreleasepool
	{
		init();
		__block dispatch_semaphore_t sem = dispatch_semaphore_create(0);
		__block int sum;
		__block int maxNum;
		dispatch_block_t task1 = ^(void){
			int s = 0;
			for (int i = 1; i < ELEMENT_COUNT; ++i)
			{
				s += array1[i];
			}
			sum = s;
			WriteCounter(sem);
		};
		
		dispatch_block_t task2 = ^(void){
			int s = sum;
			for (int i = 0; i < ELEMENT_COUNT; ++i)
			{
				array1[i] -= s;
			}
			WriteCounter(sem);
		};
		
		dispatch_block_t task3 = ^(void){
			int max = array2[0];
			for (int i = 1; i < ELEMENT_COUNT; ++i)
			{
				if (max < array2[i])
				{
					max = array2[i];
				}
			}
			maxNum = max;
			WriteCounter(sem);
		};
		
		dispatch_block_t task4 = ^(void){
			int max = maxNum;
			for (int i = 0; i < ELEMENT_COUNT; ++i)
			{
				array2[i] *= max;
			}
			WriteCounter(sem);
		};
		
		unsigned long long beginTicks, endTicks;
		INTRIN_RDTSC(beginTicks);
		task1();
		task2();
		task3();
		task4();
		INTRIN_RDTSC(endTicks);
		
	    dispatch_release(sem);
		
		printf("The ticks used for serial execution is: %llu\n", endTicks - beginTicks);
		
		
		sem = dispatch_semaphore_create(0);
		counter = 0;
		INTRIN_RDTSC(beginTicks);
		dispatch_queue_t queue1 = dispatch_queue_create("firstjob", nil);
		dispatch_queue_t queue2 = dispatch_queue_create("secondjob", nil);
		
		dispatch_async(queue1, task1);
		dispatch_async(queue1, task2);
		
		dispatch_async(queue2, task3);
		dispatch_async(queue2, task4);
		
		dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
		INTRIN_RDTSC(endTicks);
		
		printf("The ticks used for parallel execution is: %llu\n", endTicks - beginTicks);
		
		dispatch_release(queue1);
		dispatch_release(queue2);
		dispatch_release(sem);
	}
    return 0;
}

