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

@end
