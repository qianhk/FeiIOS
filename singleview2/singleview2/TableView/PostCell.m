//
//  PostCell.m
//  singleview2
//
//  Created by 钱红凯 on 2017/8/15.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import "PostCell.h"
#import "PostData.h"

@interface PostCell()
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIView *commentLayout;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentLayoutContentImageViewDistanceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentLabelTopDistanceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentLabelBottomDistanceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentLayoutBottomDistanceConstraint;

@end

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat width = _avatarImageView.frame.size.width;
    self.avatarImageView.layer.cornerRadius = width / 2;
    self.avatarImageView.layer.masksToBounds = YES;
}

- (void)configWithModel:(Post *)post {

    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:post.avatarUrl]];
    self.avatarImageView.image = [UIImage imageWithData:imageData];
    self.nicknameLabel.text = post.nickname;
    self.contentLabel.text = post.text;

    if (post.imageUrl.length > 0) {
        self.contentImageView.hidden = NO;
        self.commentLayoutContentImageViewDistanceConstraint.priority = 999;
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:post.imageUrl]];
        self.contentImageView.image = [UIImage imageWithData:imageData];
    } else {
        self.contentImageView.hidden = YES;
        self.contentImageView.image = nil;
        self.commentLayoutContentImageViewDistanceConstraint.priority = 800;
    }

    NSMutableString *commentStr = [[NSMutableString alloc] init];
    int commentCount = post.commentList.count;
    for (int idx = 0; idx < commentCount; ++idx) {
        if (idx != 0) {
            [commentStr appendString:@"\n"];
        }
        [commentStr appendString:post.commentList[idx].text];
    }
    self.commentLabel.text = [commentStr description];
    self.commentLabel.hidden = commentCount <= 0;
    self.commentLabelTopDistanceConstraint.constant = commentCount <= 0 ? 0 : 8;
    self.commentLabelBottomDistanceConstraint.constant = commentCount <= 0 ? 0 : 8;
    self.commentLayoutBottomDistanceConstraint.constant = commentCount <= 0 ? 0 : 8;
}

@end
