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

@end
