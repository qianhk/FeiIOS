//
//  EncodingConvertTests.h
//  EncodingConvertTests
//
//  Created by hongkai.qian on 11-9-30.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface EncodingConvertTests : SenTestCase

- (void)testConvertChineseToUnicode;
- (void)testConvertUnicodeToUTF8;
- (void)testConvertUnicodeToGBK;

- (void)testConvertUnicodeToChinese;
- (void)testConvertUTF8ToUnicode;
- (void)testConvertGBKToUnicode;

- (void)testBase64Encode;
- (void)testBase64Decode;

- (void)testMD5;
- (void)testSHA1;
- (void)testHMacSHA1;

@end
