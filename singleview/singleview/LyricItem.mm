//
//  LyricItem.m
//  singleview
//
//  Created by kai on 12-2-27.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import "LyricItem.h"

@implementation LyricItem

@synthesize timestamp;
@synthesize text;

- (void)dealloc
{
	[text release];
	
	[super dealloc];
}

//- (void)setTime:(NSInteger)time text:(NSString *)lyricText
//{
//	timestamp = time;
//	
//	self.text = lyricText;
//}

- (NSComparisonResult)compare:(LyricItem *)another
{
	NSInteger diff = timestamp - another.timestamp;
	return (diff < 0) ? NSOrderedAscending : ((diff > 0) ? NSOrderedDescending : NSOrderedSame);
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeInteger:timestamp forKey:@"LyricItem_Timestamp"];
	[aCoder encodeObject:text forKey:@"LyricItem_Text"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ([super init])
	{
		timestamp = [aDecoder decodeIntForKey:@"LyricItem_Timestamp"];
		text = [[aDecoder decodeObjectForKey:@"LyricItem_Text"] copy];
	}
	
	return self;
}

@end



@implementation LyricData

@synthesize timeOffset;
@synthesize count;
@synthesize duration;

- (NSInteger)count
{
	return [lyricItemArray count];
}

- (id)init
{
	self = [super init];
	if (self)
	{
		timeOffset = 0;
		lyricItemArray = [[NSMutableArray alloc] init];
		for (int idx = 110; idx < 115; ++idx)
		{
			LyricItem* item = [[LyricItem alloc] init];
			item.timestamp = idx;
			item.text = [NSString stringWithFormat:@"text%d", idx];
			[lyricItemArray addObject:item];
			[item release];
		}
		
		duration = 8888;
		timeOffset = 666;
	}
	
	return  self;
}

- (void)dealloc
{
	while(!_timesQueue.empty())
	{
		_timesQueue.pop();
	}
	[lyricItemArray release];
	
	[super dealloc];
}

/*
 //Encode
 const unsigned    size    = myVector.size();
 [aCoder encodeValueOfObjCType:@encode(unsigned) at:&size];
 for(Vector<unsigned int>::iterator it = myVector.begin();
 it!=myVector.end(); ++it) {
 unsigned int value = *it;
 [aCoder encodeValueOfObjCType:@encode(unsigned int) at:&value];
 }
 
 //Decode
 unsigned size;
 [aCoder decodeValueOfObjCType:@encode(unsigned) at:&size];
 myVector.reserve(size);
 for(int i =0; i < size; ++i) {
 unsigned int value;
 [aCoder decodeValueOfObjCType:@encode(unsigned int) at:&value];
 myVector.push_back(value);
 }
 */
 
 
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeInteger:duration forKey:@"LyricData_Duration"];
	[aCoder encodeInteger:timeOffset forKey:@"LyricData_TimeOffset"];
	[aCoder encodeObject:lyricItemArray forKey:@"LyricData_Array"];
//	[aCoder encodeArrayOfObjCType:<#(const char *)#> count:<#(NSUInteger)#> at:<#(const void *)#>
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ([super init])
	{
		duration = [aDecoder decodeIntForKey:@"LyricData_Duration"];
		timeOffset = [aDecoder decodeIntForKey:@"LyricData_TimeOffset"];
		lyricItemArray = [[aDecoder decodeObjectForKey:@"LyricData_Array"] copy];
	}
	
	return self;
}

- (NSString *)description
{
	NSUInteger arrCount = [self count];
	NSMutableString* tmpStr = [[[NSMutableString alloc] init] autorelease];
	[tmpStr appendFormat:@"LyricData : Count = %d\n", arrCount];
	
	for (NSUInteger idx = 0; idx < arrCount; ++idx)
	{
		LyricItem* item = [lyricItemArray objectAtIndex:idx];
		[tmpStr appendFormat:@"%d %d %@\n", idx, item.timestamp, item.text];
	}
	
	return tmpStr;
}

@end

