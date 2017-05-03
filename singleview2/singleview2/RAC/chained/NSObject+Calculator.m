//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "NSObject+Calculator.h"
#import "CalculatorMaker.h"


@implementation NSObject (Calculator)

+ (int)makeCalculator:(void(^)(CalculatorMaker *make))calculatorMaker {

    CalculatorMaker *maker = [CalculatorMaker new];
    calculatorMaker(maker);
    return maker.result;
}


@end
