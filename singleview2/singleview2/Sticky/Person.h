//
// Created by kai on 2017/5/24.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject

@property(nonatomic, strong) NSString *year;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *avatarId;

+ (instancetype)constructYear:(NSString *)year name:(NSString *)name avatarId:(NSString *)avatarId;

@property(class, nonatomic, readonly) UIColor *stickyGrayColor;

@end