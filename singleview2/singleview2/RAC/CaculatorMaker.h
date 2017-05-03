//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CaculatorMaker : NSObject

@property(nonatomic, assign) int result;

- (CaculatorMaker *(^)(int))add;

- (CaculatorMaker *(^)(int))sub;

- (CaculatorMaker *(^)(int))muilt;

- (CaculatorMaker *(^)(int))divide;

@end