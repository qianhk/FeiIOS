//
// Created by kai on 2017/8/15.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Comment : NSObject

@property (nonatomic, strong) NSString *text;

- (instancetype)initWithText:(NSString *)text;

+ (Comment *)constructWithText:(NSString *)text;

@end

@interface Post : NSObject

@property (nonatomic, strong) NSString *nickname;

@property (nonatomic, strong) NSString *avatarUrl;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) NSArray<Comment *> *commentList;

+ (NSArray<Post *> *)makeData;

- (instancetype)initWithNickname:(NSString *)nickname avatarUrl:(NSString *)avatarUrl text:(NSString *)text;

@end

