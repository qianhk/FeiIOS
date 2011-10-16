//
//  EncodingConvertTests.m
//  EncodingConvertTests
//
//  Created by hongkai.qian on 11-9-30.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import "EncodingConvertTests.h"
#import "EncodingConvert.h"

@implementation EncodingConvertTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
//    STFail(@"Unit tests are not implemented yet in EncodingConvertTests");
}

- (void)testConvertChineseToUnicode
{
	NSString* testStr = @"好人";
	NSString* destStr = @"\\u597d\\u4eba";
	
	NSString* calcStr = [EncodingConvert convertChineseToUnicode:testStr];
	STAssertTrue([destStr isEqualToString:calcStr], @"ConvertChineseToUnicode failed");
}

- (void)testConvertUnicodeToUTF8
{
	NSString* testStr = @"好人";
	NSString* destStr = @"%E5%A5%BD%E4%BA%BA";
	
	NSString* calcStr = [EncodingConvert convertUnicodeToUTF8:testStr];
	STAssertTrue([destStr isEqualToString:calcStr], @"convertUnicodeToUTF8 failed");
}

- (void)testConvertUnicodeToGBK
{
	NSString* testStr = @"好人";
	NSString* destStr = @"%BA%C3%C8%CB";
	
	NSString* calcStr = [EncodingConvert convertUnicodeToGBK:testStr];
	STAssertTrue([destStr isEqualToString:calcStr], @"convertUnicodeToGBK failed");
}

- (void)testConvertUnicodeToChinese
{
	NSString* testStr = @"\\u597d\\u4eba";
	NSString* destStr = @"好人";
	
	NSString* calcStr = [EncodingConvert convertUnicodeToChinese:testStr];
	STAssertTrue([destStr isEqualToString:calcStr], @"ConvertUnicodeToChinese failed");
	
	testStr = @"\\x597d\\x4eba";
	destStr = @"好人";
	
	calcStr = [EncodingConvert convertUnicodeToChinese:testStr];
	STAssertTrue([destStr isEqualToString:calcStr], @"ConvertUnicodeToChinese failed");
}

- (void)testConvertUTF8ToUnicode
{
	NSString* testStr = @"%E5%A5%BD%E4%BA%BA";
	NSString* destStr = @"好人";
	
	NSString* calcStr = [EncodingConvert convertUTF8ToUnicode:testStr];
	STAssertTrue([destStr isEqualToString:calcStr], @"ConvertUTF8ToUnicode failed");
}

- (void)testConvertGBKToUnicode
{
	NSString* testStr = @"%BA%C3%C8%CB";
	NSString* destStr = @"好人";
	
	NSString* calcStr = [EncodingConvert convertGBKToUnicode:testStr];
	STAssertTrue([destStr isEqualToString:calcStr], @"ConvertGBKToUnicode failed");
}

- (void)testBase64Encode
{
	NSString* testStr = @"abcd";
	NSString* expectStr = @"YWJjZA==";
	NSString* resultStr = [EncodingConvert base64EncodeString:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
	
	testStr = @"abc";
	expectStr = @"YWJj";
	resultStr = [EncodingConvert base64EncodeString:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");	
	
	testStr = @"乔布斯";
	expectStr = @"5LmU5biD5pav";
	resultStr = [EncodingConvert base64EncodeString:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
}

- (void)testBase64Decode
{
	NSString* testStr = @"YWJjZA==";
	NSString* expectStr = @"abcd";
	NSString* resultStr = [EncodingConvert base64DecodeString:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
	
	testStr = @"YWJj";
	expectStr = @"abc";
	resultStr = [EncodingConvert base64DecodeString:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");	
	
	testStr = @"5LmU5biD5pav";
	expectStr = @"乔布斯";
	resultStr = [EncodingConvert base64DecodeString:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
	
	testStr = @"YWJjZA=";
	expectStr = @"abcd";
	resultStr = [EncodingConvert base64DecodeString:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
	
	
	testStr = @"YWJjZA";
	expectStr = @"abcd";
	resultStr = [EncodingConvert base64DecodeString:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
}

- (void)testMD5
{
	NSString* testStr = @"abc";
	NSString* expectStr = @"900150983CD24FB0D6963F7D28E17F72";
	NSString* resultStr = [EncodingConvert md5:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
	
	testStr = @"乔布斯";
	expectStr = @"2B3D41DD4B7911DC0FE683D1A0D977EF";
	resultStr = [EncodingConvert md5:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
}

- (void)testSHA1
{
	NSString* testStr = @"abc";
	NSString* expectStr = @"A9993E364706816ABA3E25717850C26C9CD0D89D";
	NSString* resultStr = [EncodingConvert sha1:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
		
	testStr = @"dog";
	expectStr = @"E49512524F47B4138D850C9D9D85972927281DA0";
	resultStr = [EncodingConvert sha1:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
	
	testStr = @"乔布斯";
	expectStr = @"87EAC549E692A8AAB11DB6BDF1259D264D29033E";
	resultStr = [EncodingConvert sha1:testStr];
	STAssertTrue([resultStr isEqualToString:expectStr], @"");
}


- (void)testHMacSHA1
{
//	NSString* testStr = @"abc";
//	NSString* expectStr = @"a9993e364706816aba3e25717850c26c9cd0d89d";
//	NSString* resultStr = [EncodingConvert hmacSHA1:testStr secret:testStr];
//	STAssertTrue([resultStr isEqualToString:expectStr], @"");
//	
//	NSString* expectStr2 = @"900150983cd24fb0d6963f7d28e17f72";
//	STAssertTrue([resultStr isEqualToString:expectStr2], @"");
//	
//	testStr = @"dog";
//	expectStr = @"e49512524f47b4138d850c9d9d85972927281da0";
//	resultStr = [EncodingConvert hmacSHA1:testStr secret:@""];
//	STAssertTrue([resultStr isEqualToString:expectStr], @"");
//	
//	testStr = @"乔布斯";
//	expectStr = @"7b7250b3389a3fb240d8b9fdee95f53207a6f269";
//	resultStr = [EncodingConvert hmacSHA1:testStr secret:@""];
//	STAssertTrue([resultStr isEqualToString:expectStr], @"");
}

@end
