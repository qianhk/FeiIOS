//
// Created by kai on 2017/8/15.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "PostData.h"

@implementation Comment

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = text;
    }
    return self;
}

+ (Comment *)constructWithText:(NSString *)text {
    return [[Comment alloc] initWithText:text];
}

@end

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

    Post *post = [[Post alloc] initWithNickname:@"KaiKai1妈妈说名字长一点躲在草丛里不容易被发现" avatarUrl:@"http://3p.pic.ttdtweb.com/alimusicmanage-live/image_backend/06695/9e4ae_1466833843992.jpg" text:@"这是一条纯内容啊啊啊啊啊"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai2" avatarUrl:@"http://am.zdmimg.com/201610/01/57ef7c02d00ef.jpg_e600.jpg" text:@"这是一条带有图片的内容啊"];
    post.imageUrl = @"http://am.zdmimg.com/201609/16/57dbf617cbaf2.jpg_e600.jpg";
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai3" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf7ce5dc1c.jpg_e600.jpg" text:@"这是一条带有图片的内容啊，而且文字比较长，估计至少要2行以上了"];
    post.imageUrl = @"http://am.zdmimg.com/201609/16/57dbf73b256a0.jpg_e600.jpg";
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai4" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf56e9e779.jpg_e600.jpg" text:@"这是一条纯文本，而且文字比较长，估计至少要3行以上了，为了凑长度，拼了，再加些文字，该有三行了吧"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai5" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf56e9e779.jpg_e600.jpg" text:@"这是一条纯文本，而且有1条评论"];
    post.commentList = @[[Comment constructWithText:@"这是一条文本评论"]];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai6" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf56e9e779.jpg_e600.jpg" text:@"这是有图的内容，啊啊，而且还有2条评论"];
    post.imageUrl = @"http://am.zdmimg.com/201609/16/57dbf6a9efaf6.jpg_e600.jpg";
    post.commentList = @[[Comment constructWithText:@"这是一条文本评论"], [Comment constructWithText:@"这是另一条文本评论"]];
    [array addObject:post];




    post = [[Post alloc] initWithNickname:@"KaiKai21这个用户的昵称真的是好长啊果然长长的昵称" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf57ee68a9.jpg_e600.jpg" text:@"第二批：这是一条纯内容啊啊啊啊啊"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai22" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf5bb103db.jpg_e600.jpg" text:@"第二批：这是一条带有图片的内容啊"];
    post.imageUrl = @"http://am.zdmimg.com/201609/16/57dbf74eb5c08.jpg_e600.jpg";
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai23" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf5e519d9d.jpg_e600.jpg" text:@"第二批：这是一条带有图片的内容啊，而且文字比较长，估计至少要2行以上了"];
    post.imageUrl = @"http://am.zdmimg.com/201609/16/57dbf72f9319f.jpg_e600.jpg";
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai24" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf6051c600.jpg_e600.jpg" text:@"第二批：这是一条纯文本，而且文字比较长，估计至少要3行以上了，为了凑长度，拼了，再加些文字，该有三行了吧"];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai25" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf56e9e779.jpg_e600.jpg" text:@"这是一条纯文本，而且有1条评论"];
    post.commentList = @[[Comment constructWithText:@"这是一条文本评论2"]];
    [array addObject:post];

    post = [[Post alloc] initWithNickname:@"KaiKai26" avatarUrl:@"http://am.zdmimg.com/201609/16/57dbf56e9e779.jpg_e600.jpg" text:@"这是有图的内容，啊啊，而且还有2条评论"];
    post.imageUrl = @"http://am.zdmimg.com/201609/16/57dbf6740e49d.jpg_e600.jpg";
    post.commentList = @[[Comment constructWithText:@"这是一条文本评论21"], [Comment constructWithText:@"这是一条文本评论22"]];
    [array addObject:post];

    return array;
}

@end
