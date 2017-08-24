//
// Created by kai on 2017/8/24.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>
#import <ReactiveObjC/UIControl+RACSignalSupport.h>
#import "OperateSuccessView.h"
#import <ReactiveObjC/RACEXTScope.h>
#import <ReactiveObjC/RACSignal.h>

@interface OperateSuccessView ()

@property (nonatomic, strong) UIImageView *contentView;
@property (nonatomic, strong) UIView *contentViewWithBottomButton;
@property (nonatomic, strong) UIView *tapView;
@property (nonatomic, strong) UILabel *closeLabel;

@property (nonatomic, assign) NSInteger actionState;

@end

@implementation OperateSuccessView

+ (instancetype)show:(UIWindow *)window {

    OperateSuccessView *view = [OperateSuccessView new];
    view.alpha = 0;
    view.frame = window.bounds;
    view.titleLabel.text = @"测试大标题文字";
    view.subtitleLabel.text = @"子标题可能会有点长，看看效果先，再加长点啊，不然不够多行，最多3行文字，是的么，应该是的";
    [view.actionButton setTitle:@"打算干嘛呢" forState:UIControlStateNormal];
    [window addSubview:view];
    [UIView animateWithDuration:.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        view.alpha = 1;
    }                completion:nil];

    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        self.tapView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMe)];
        [self.closeLabel addGestureRecognizer:tap];

        [self setNeedsUpdateConstraints];
    }
    return self;
}


- (void)updateConstraints {

    [self.contentViewWithBottomButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
    }];

    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentViewWithBottomButton);
        make.centerX.equalTo(self.contentViewWithBottomButton);
        make.width.mas_equalTo(307);
//        make.height.mas_equalTo(510);
    }];

    [self.tapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];

    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(118 - 6 - 30);
    }];

    [self.subtitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(34);
        make.trailing.equalTo(self.contentView).offset(-34);
        make.top.equalTo(self.contentView.mas_top).offset(118 + 15);
    }];

    [self.actionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(15);
        make.leading.equalTo(self.contentView).offset(34);
        make.trailing.equalTo(self.contentView).offset(-34);
        make.height.mas_equalTo(35);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];

    [self.closeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentViewWithBottomButton);
        make.top.equalTo(self.contentView.mas_bottom).offset(40);
        make.bottom.equalTo(self.contentViewWithBottomButton);
    }];

    [super updateConstraints];
}

- (UIImageView *)contentView {
    if (!_contentView) {
        _contentView = [[UIImageView alloc] init];
        _contentView.userInteractionEnabled = YES;
        UIImage *backgroundImage = [UIImage imageNamed:@"operate_result_png"];
        _contentView.image = [backgroundImage stretchableImageWithLeftCapWidth:backgroundImage.size.width / 2 topCapHeight:118 + 6];
        [self.contentViewWithBottomButton addSubview:_contentView];
    }

    return _contentView;
}

- (UIView *)contentViewWithBottomButton {
    if (!_contentViewWithBottomButton) {
        _contentViewWithBottomButton = [[UIView alloc] init];
//        _contentViewWithBottomButton.backgroundColor = [UIColor greenColor];
        [self addSubview:_contentViewWithBottomButton];
    }

    return _contentViewWithBottomButton;
}

- (UIView *)tapView {
    if (!_tapView) {
        _tapView = [UIView new];
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

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
//        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.font = [UIFont systemFontOfSize:14.f];
        _subtitleLabel.textColor = [UIColor blackColor];
        _subtitleLabel.numberOfLines = 3;
        [self.contentView addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:22.f];
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)closeLabel {
    if (!_closeLabel) {
        _closeLabel = [[UILabel alloc] init];
        _closeLabel.textAlignment = NSTextAlignmentCenter;
        _closeLabel.font = [UIFont systemFontOfSize:32.f];
        _closeLabel.textColor = [UIColor orangeColor];
        _closeLabel.userInteractionEnabled = YES;
        _closeLabel.text = @"关闭";
        [self.contentViewWithBottomButton addSubview:_closeLabel];
    }
    return _closeLabel;
}

- (UIButton *)actionButton {

    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.layer.borderColor = [UIColor blueColor].CGColor;
        _actionButton.layer.borderWidth = 0.5f;
        _actionButton.layer.cornerRadius = 17.5f;
        [_actionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:15.f];

        @weakify(self)
        [[_actionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            ++self.actionState;
            if (self.actionTapped) {
                self.actionTapped(self.actionState);
            }
        }];
//
        [self.contentView addSubview:_actionButton];
    }

    return _actionButton;
}

@end