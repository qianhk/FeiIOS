//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "CalculatorMaker.h"


@implementation CalculatorMaker

- (CalculatorMaker *(^)(int))add {
    return ^CalculatorMaker *(int value) {
        _result += value;
        return self;
    };
}

- (CalculatorMaker *(^)(int))sub {
    return ^CalculatorMaker *(int value) {
        _result -= value;
        return self;
    };
}

- (CalculatorMaker *(^)(int))muilt {
    return ^CalculatorMaker *(int value) {
        _result *= value;
        return self;
    };
}

- (CalculatorMaker *(^)(int))divide {
    return ^CalculatorMaker *(int value) {
        _result /= value;
        return self;
    };
}

@end