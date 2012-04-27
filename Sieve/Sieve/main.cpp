//
//  main.cpp
//  Sieve
//
//  Created by kai on 12-4-23.
//  Copyright (c) 2012年 Kai. All rights reserved.
//

#include <iostream>
#include <bitset>
#include <ctime>

using namespace std;

int main (int argc, const char * argv[])
{
	const int N = 20000000;
	clock_t cstart = clock();
	
	bitset< N + 1> b;
	int count = 0;
	int i;
	for (i = 2; i <= N; ++i)
	{
		b.set(i);
	}
	i = 2;
	while (i * i <= N)
	{
		if (b.test(i))
		{
			++count;
			int k = 2 * i;
			while (k <= N)
			{
				b.reset(k);
				k += i;
			}
		}
		++i;
	}
	while (i <= N)
	{
		if (b.test(i))
		{
			++count;
		}
		++i;
	}
	clock_t cend = clock();
	double millis = 1000.0 * (cend - cstart) / CLOCKS_PER_SEC;
	cout << count << " primes\n" << millis << " milliSeconds\n";
    return 0;
}

