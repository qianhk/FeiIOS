//
//  EncodingConvert.m
//  EncodingConvert
//
//  Created by KaiKai on 11-10-3.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import "EncodingConvert.h"

@interface NSString()

- (NSInteger)intValueWithUChar:(unichar)c;

@end

@implementation NSString(HEX)

- (NSInteger)intValueWithUChar:(unichar)c
{
	NSInteger nValue = 0;
	
	if (c >= '0' && c <= '9')
	{
		nValue = c - '0';
	}
	else if (c >= 'A' && c <= 'F')
	{
		nValue = c - 'A' + 10;
	}
	else if (c >= 'a' && c <= 'f')
	{
		nValue = c - 'a' + 10;
	}
	
	return nValue;
}

- (NSInteger)hexIntegerValue
{
	if (self == nil || self.length == 0)
	{
		return 0;
	}
//	static NSArray arrValue = NSArray arrayWithObjects:<#(id), ...#>, nil
	
	NSInteger nHexValue = 0;
	NSInteger len = self.length;
	NSInteger idx = len - 1;
	NSInteger radio = 1;
	for (; idx >= 0; --idx)
	{
		nHexValue += radio * [self intValueWithUChar:[self characterAtIndex:idx]];
		radio *= 16;
	}
	
	return nHexValue;
}

@end

@implementation EncodingConvert

- (id)init
{
    self = [super init];
    if (self)
	{
        // Initialization code here.
    }
    
    return self;
}

+ (NSString *)convertChineseToUnicode:(NSString *)aChinese
{
	if (aChinese == nil)
	{
		return nil;
	}
	
	NSMutableString* str = [[[NSMutableString alloc] init] autorelease];
	NSUInteger len = [aChinese length];
	NSUInteger idx = 0;
	for (; idx < len; ++idx)
	{
		unichar c = [aChinese characterAtIndex:idx];
		[str appendFormat:@"\\u%04x", c];
	}
	
	return str;
}

+ (NSString *)convertUnicodeToUTF8:(NSString *)aUnicode
{
	if (aUnicode == nil)
	{
		return nil;
	}
	
	NSMutableString* str = [[[NSMutableString alloc] init] autorelease];
	const char* cstr = [aUnicode UTF8String];
	unsigned int len = (unsigned int)strlen(cstr);
	unsigned int idx = 0;
	for (; idx < len; ++idx)
	{
		unsigned char c = *(cstr++);
		[str appendFormat:@"%%%02X", c];
	}
	
	return str;
}

+ (NSString *)convertUnicodeToGBK:(NSString *)aUnicode
{
	if (aUnicode == nil)
	{
		return nil;
	}
	
	NSMutableString* str = [[[NSMutableString alloc] init] autorelease];
	NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	const char* cstr = [aUnicode cStringUsingEncoding:gbkEncoding];
	unsigned int len = (unsigned int)strlen(cstr);
	unsigned int idx = 0;
	for (; idx < len; ++idx)
	{
		unsigned char c = *(cstr++);
		[str appendFormat:@"%%%02X", c];
	}
	
	return str;
}

+ (NSString *)convertUnicodeToChinese:(NSString *)aUnicode
{
	if (aUnicode == nil)
	{
		return nil;
	}
	
	NSString* separateStr = @"\\u";
	NSRange range = [aUnicode rangeOfString:separateStr];
	if (range.length <= 0)
	{
		separateStr = @"\\x";
	}
	NSArray* arr = [aUnicode componentsSeparatedByString:separateStr];
	NSUInteger count = [arr count];
	NSUInteger idx = 0;
	
	NSMutableString* str = [[[NSMutableString alloc] init] autorelease];
	for (; idx < count; ++idx)
	{
		NSString* arrStr = [arr objectAtIndex:idx];
		if ([arrStr length] == 0)
		{
			continue;
		}
		NSInteger nV = [arrStr hexIntegerValue];
		[str appendFormat:@"%C", nV];
	}
	
	return str;
}

+ (NSString *)convertUTF8ToUnicode:(NSString *)aUTF8
{
	if (aUTF8 == nil)
	{
		return nil;
	}
	
	NSArray* arr = [aUTF8 componentsSeparatedByString:@"%"];
	NSUInteger count = [arr count];
	NSUInteger idx = 0;
	NSUInteger idxCStr = 0;
	char* cstr = new char[count + 1];
	for (; idx < count; ++idx)
	{
		NSString* arrStr = [arr objectAtIndex:idx];
		if ([arrStr length] == 0)
		{
			continue;
		}
		NSInteger nV = [arrStr hexIntegerValue];
		*(cstr + idxCStr++) = nV;
	}
	*(cstr + idxCStr) = 0;
	NSString* unicodeStr = [NSString stringWithUTF8String:cstr];
	delete cstr;
	return unicodeStr;
}

+ (NSString *)convertGBKToUnicode:(NSString *)aGBK
{
	if (aGBK == nil)
	{
		return nil;
	}
	
	NSArray* arr = [aGBK componentsSeparatedByString:@"%"];
	NSUInteger count = [arr count];
	NSUInteger idx = 0;
	NSUInteger idxCStr = 0;
	char* cstr = new char[count + 1];
	for (; idx < count; ++idx)
	{
		NSString* arrStr = [arr objectAtIndex:idx];
		if ([arrStr length] == 0)
		{
			continue;
		}
		NSInteger nV = [arrStr hexIntegerValue];
		*(cstr + idxCStr++) = nV;
	}
	*(cstr + idxCStr) = 0;
	NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString* unicodeStr = [NSString stringWithCString:cstr encoding:gbkEncoding];
	delete cstr;
	return unicodeStr;

}

@end
