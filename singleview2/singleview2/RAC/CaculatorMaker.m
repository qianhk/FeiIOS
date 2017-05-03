//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "CaculatorMaker.h"


@implementation CaculatorMaker

- (CaculatorMaker *(^)(int))add {
    return ^CaculatorMaker *(int value) {
        _result += value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))sub {
    return ^CaculatorMaker *(int value) {
        _result -= value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))muilt {
    return ^CaculatorMaker *(int value) {
        _result *= value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))divide {
    return ^CaculatorMaker *(int value) {
        _result /= value;
        return self;
    };
}

@end