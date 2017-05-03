//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorMaker : NSObject

@property(nonatomic, assign) int result;

- (CalculatorMaker *(^)(int))add;

- (CalculatorMaker *(^)(int))sub;

- (CalculatorMaker *(^)(int))muilt;

- (CalculatorMaker *(^)(int))divide;

@end