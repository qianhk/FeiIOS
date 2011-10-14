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
+ (NSString *)md5:(NSString *)str;

// Calculate HMAC SHA1
+ (NSString *)hmacSHA1:(NSString *)text secret:(NSString *)secret;

+ (NSString *)sha1:(NSString *)text;

// BASE64 encode
+ (NSString *)base64Encode:(const unsigned char *)data length:(NSUInteger)length;

// BASE64 encode string
+ (NSString *)base64EncodeString:(NSString *)string;

// BASE64 encode data
+ (NSString *)base64EncodeData:(NSData *)data;


// BASE64 decode
+ (NSData *)base64Decode:(NSString *)string;

// BASE64 decode string
+ (NSString *)base64DecodeString:(NSString *)string;


@end
