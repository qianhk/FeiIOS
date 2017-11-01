//
// Created by kai on 2017/8/7.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "ArtistData.h"

@interface Artist () {

    NSString *_innerName;

}
@end

@implementation Artist

- (void)setName:(NSString *)name {
    _name = [name mutableCopy];
    _innerName = [_name copy];
}

- (void)setBoolValue:(BOOL)boolValue {
    _boolValue = boolValue;
}

//- (void)setBoolValue:(NSString *)boolValue {
//    _boolValue = boolValue;
//}

- (void)setLongValue:(long)longValue {
    _longValue = longValue;
}

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    NSLog(@"您设置的key：[%@]不存在, value为: %@", key, value);
    // default throw NSUnknownKeyException  [super setValue:value forUndefinedKey:key];
}

- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"setNilValueForKey %@", key);
    if ([key isEqualToString:@"age"]) {
    } else {
        [super setNilValueForKey:key]; //'NSInvalidArgumentException'
    }
}

- (void)setValue:(nullable id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"boolValue"]) {
        [super setValue:@([value boolValue]) forKey:key];
    } else if ([key isEqualToString:@"longValue"]) {
        [super setValue:@([value longLongValue]) forKey:key];
    } else {
        [super setValue:value forKey:key];
    }
}


@end


@implementation Work


@end
