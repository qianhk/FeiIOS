//
//  EncodingConvert.h
//  EncodingConvert
//
//  Created by KaiKai on 11-10-3.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(HEX)
- (NSInteger)hexIntegerValue;
@end

@interface EncodingConvert : NSObject

+ (NSString *)convertChineseToUnicode:(NSString *)aChinese;
+ (NSString *)convertUnicodeToUTF8:(NSString *)aUnicode;
+ (NSString *)convertUnicodeToGBK:(NSString *)aUnicode;

+ (NSString *)convertUnicodeToChinese:(NSString *)aUnicode;
+ (NSString *)convertUTF8ToUnicode:(NSString *)aUTF8;
+ (NSString *)convertGBKToUnicode:(NSString *)aGBK;

// Calculate MD5
+ (NSString *MD5(NSString *str);

// Calculate HMAC SHA1
+ (NSString *HmacSHA1(NSString *text, NSString *secret);

// BASE64 encode
+ (NSString *BASE64Encode(const unsigned char *data, NSUInteger length, NSUInteger lineLength = 0);

// BASE64 decode
+ NSData *BASE64Decode(NSString *string);

// BASE64 encode data
+ NS_INLINE NSString *BASE64EncodeData(NSData *data, NSUInteger lineLength = 0)
{
	return BASE64Encode((const unsigned char *)data.bytes, data.length, lineLength);
}

// BASE64 encode string
+ NS_INLINE NSString *BASE64EncodeString(NSString *string, NSUInteger lineLength = 0)
{
	return BASE64EncodeData([string dataUsingEncoding:NSUTF8StringEncoding], lineLength);
}

// BASE64 decode string
+ NS_INLINE NSString *BASE64DecodeString(NSString *string)
{
	NSData *data = BASE64Decode(string);
	return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}


@end
