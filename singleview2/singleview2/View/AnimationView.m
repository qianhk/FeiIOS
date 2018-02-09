//
// Created by kai on 2018/2/9.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import "AnimationView.h"

@interface AnimationView ()


@end

@implementation AnimationView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    point = [self convertPoint:point toView:self.superview];
    if ([self.layer.presentationLayer hitTest:point] != nil) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}

@end