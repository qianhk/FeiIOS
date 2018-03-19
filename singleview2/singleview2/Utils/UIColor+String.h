//
// Created by KaiKai on 17/2/18.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (String)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithColorName:(NSString *)colorName;
+ (UIColor *)colorWithString:(NSString *)string;

+ (UIColor *)gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withWidth:(CGFloat)width andHeight:(CGFloat)height forDirection:(BOOL)vertical;

@end