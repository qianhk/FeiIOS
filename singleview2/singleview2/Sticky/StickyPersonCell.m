//
// Created by kai on 2017/5/24.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "StickyPersonCell.h"
#import "Person.h"
#import "UIColor+String.h"

@interface StickyPersonCell ()

@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *avatarImageView;

@end

@implementation StickyPersonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.lineView.backgroundColor = [Person stickyGrayColor];
    }

    return self;
}

- (void)updateData:(Person *)person {
    self.nameLabel.text = person.name;
    UIImage *image = [UIImage imageNamed:person.avatarId];
    self.avatarImageView.image = image;
//    self.avatarImageView.superview.alpha = 0.2f;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(0, 8.5f, 118, 0.5f);
//        _lineView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.frame = CGRectMake(0, 17, 114, 170);
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.backgroundColor = [UIColor colorWithHexString:@"#2000"];
        _avatarImageView.clipsToBounds = YES;
        [self.contentView addSubview:_avatarImageView];
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.frame = CGRectMake(0, 17 + 170 + 6, 114, 16);
        _nameLabel.textColor = [Person stickyGrayColor];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}


@end
