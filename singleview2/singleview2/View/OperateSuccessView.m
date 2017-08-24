//
// Created by kai on 2017/8/24.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>
#import "OperateSuccessView.h"

@interface OperateSuccessView ()

@property (nonatomic, strong) UIImageView *contentView;
@property (nonatomic, strong) UIView *tapView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation OperateSuccessView

+ (void)show:(UIWindow *)window {

    OperateSuccessView *view = [OperateSuccessView new];
    view.alpha = 0;
    view.frame = window.bounds;
    [window addSubview:view];
    [UIView animateWithDuration:.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        view.alpha = 1;
    }                completion:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMe)];
        [self.tapView addGestureRecognizer:tap];

        [self setNeedsUpdateConstraints];
    }
    return self;
}


- (void)updateConstraints {

    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(310);
    }];

    [self.tapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];

    [super updateConstraints];
}

- (UIImageView *)contentView {

    if (!_contentView) {
        _contentView = [[UIImageView alloc] init];
        _contentView.userInteractionEnabled = YES;
        UIImage *backgroundImage = [UIImage imageNamed:@"operate_result_png"];
        _contentView.image = [backgroundImage stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    }
    [self addSubview:_contentView];

    return _contentView;
}

- (UIView *)tapView {
    if (!_tapView) {
        _tapView = [UIView new];
        _tapView.userInteractionEnabled = YES;
        [self addSubview:_tapView];
    }
    return _tapView;
}

- (void)dismissMe {
    [UIView animateWithDuration:.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.alpha = 0;
    }                completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end