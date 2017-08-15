//
// Created by kai on 2017/8/15.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "PostData.h"

@implementation Post

- (instancetype)initWithNickname:(NSString *)nickname avatarUrl:(NSString *)avatarUrl text:(NSString *)text {
    self = [super init];
    if (self) {
        self.nickname = nickname;
        self.avatarUrl = avatarUrl;
        self.text = text;
    }
    return self;
}

+ (NSArray<Post *> *)makeData {

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:16];

    Post *post = [[Post alloc] initWithNickname:@"KaiKai1妈妈说名字长一点躲在草丛里不容易被发现" avatarUrl:@"" text:@"这是一条纯内容啊啊啊啊啊"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai2" avatarUrl:@"" text:@"这是一条带有图片的内容啊"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai3" avatarUrl:@"" text:@"这是一条带有图片的内容啊，而且文字比较长，估计至少要2行以上了"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai4" avatarUrl:@"" text:@"这是一条纯文本，而且文字比较长，估计至少要3行以上了，为了凑长度，拼了，再加些文字，该有三行了吧"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai21这个用户的昵称真的是好长啊果然长长的昵称" avatarUrl:@"" text:@"第二批：这是一条纯内容啊啊啊啊啊"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai22" avatarUrl:@"" text:@"第二批：这是一条带有图片的内容啊"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai23" avatarUrl:@"" text:@"第二批：这是一条带有图片的内容啊，而且文字比较长，估计至少要2行以上了"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai24" avatarUrl:@"" text:@"第二批：这是一条纯文本，而且文字比较长，估计至少要3行以上了，为了凑长度，拼了，再加些文字，该有三行了吧"];
    [array addObject:post];

}

@end