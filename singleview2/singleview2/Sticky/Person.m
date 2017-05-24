//
// Created by kai on 2017/5/24.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "Person.h"
#import "UIColor+String.h"

@interface Person ()

@end

@implementation Person

+ (instancetype)constructYear:(NSString *)year name:(NSString *)name avatarId:(NSString *)avatarId {
    Person *person = [[Person alloc] init];
    person.year = year;
    person.name = name;
    person.avatarId = avatarId;
    return person;
}

+ (UIColor *)stickyGrayColor {
    return [UIColor colorWithHexString:@"#B5B5B5"];
}

@end