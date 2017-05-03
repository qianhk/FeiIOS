//
// Created by kai on 17/5/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Calculator : NSObject

@property(nonatomic, assign) BOOL isEqual;
@property(nonatomic, assign) int result;

- (Calculator *)calculator:(int(^)(int result))calculator;

- (Calculator *)equal:(BOOL(^)(int result))operation;

@end