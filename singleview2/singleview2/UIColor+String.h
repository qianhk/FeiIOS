//
// Created by KaiKai on 17/2/18.
// Copyright (c) 2017 TTPod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (String)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithColorName:(NSString *)colorName;
+ (UIColor *)colorWithString:(NSString *)string;

@end