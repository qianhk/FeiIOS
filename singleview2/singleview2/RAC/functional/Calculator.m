//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "Calculator.h"


@implementation Calculator

- (Calculator *)calculator:(int(^)(int result))calculator {
    self.result = calculator(self.result);
    return self;
}

- (Calculator *)equal:(BOOL(^)(int result))operation {
    self.isEqual = operation(self.result);
    return self;
}

@end