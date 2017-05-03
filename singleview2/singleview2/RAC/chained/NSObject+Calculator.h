//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalculatorMaker;


@interface NSObject (Calculator)

+ (int)makeCalculator:(void(^)(CalculatorMaker *make))calculatorMaker;

@end