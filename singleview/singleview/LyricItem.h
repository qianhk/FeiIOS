//
//  LyricItem.h
//  singleview
//
//  Created by kai on 12-2-27.
//  Copyright (c) 2012年 TTPod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <queue>

@interface LyricItem : NSObject<NSCoding>
{
	NSInteger timetamp;
	NSString* text;
}

@property (nonatomic, retain) NSString* text;
@property (nonatomic) NSInteger timestamp;

//- (void)setTime:(NSInteger)time text:(NSString *)lyricText;

@end


@interface LyricData : NSObject<NSCoding>
{
	NSInteger duration;
	NSInteger timeOffset;
	NSMutableArray* lyricItemArray;
	
	std::queue<NSInteger> _timesQueue;
}

@property (nonatomic) NSInteger duration;
@property (nonatomic) NSInteger timeOffset;
@property (nonatomic) NSInteger count;

@end