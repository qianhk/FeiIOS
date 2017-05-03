//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "NSObject+Caculator.h"
#import "CaculatorMaker.h"


@implementation NSObject (Calculate)

+ (int)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMaker {

    CaculatorMaker *maker = [CaculatorMaker new];
    caculatorMaker(maker);
    return maker.result;
}


@end
