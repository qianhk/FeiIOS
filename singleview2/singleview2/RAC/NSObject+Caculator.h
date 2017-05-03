//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CaculatorMaker;


@interface NSObject (Calculate)

+ (int)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMaker;

@end