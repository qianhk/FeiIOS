//
// Created by kai on 2017/8/24.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OperateSuccessView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIButton *actionButton;

+ (instancetype)show:(UIWindow *)window;

- (void)dismissMe;

@property (nonatomic, strong) void (^actionTapped)(NSInteger actionState);

@end
