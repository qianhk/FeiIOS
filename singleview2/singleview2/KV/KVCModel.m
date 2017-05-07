//
// Created by kai on 2017/5/7.
// Copyright (c) 2017 njnu. All rights reserved.
//

#import "KVCModel.h"

@interface KVCModel ()


@end

@implementation KVCModel

- (nullable id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"您访问的key:[%@]不存在", key);
    return nil; // default throw NSUnknownKeyException [super valueForUndefinedKey:key];
}

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    NSLog(@"您设置的key：[%@]不存在, value为: %@", key, value);
    // default throw NSUnknownKeyException  [super setValue:value forUndefinedKey:key];
}

- (void)setNilValueForKey:(NSString *)key {
    [super setNilValueForKey:key];
}


@end