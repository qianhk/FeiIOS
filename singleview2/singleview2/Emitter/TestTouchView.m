//
// Created by kai on 2018/11/9.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import "TestTouchView.h"

@interface TestTouchView ()


@end

@implementation TestTouchView


- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    NSLog(@"lookTouch at testTouchView view.tag=%ld", self.tag);
    return [super hitTest:point withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"lookTouch at testTouchView touchesBegan view.tag=%ld", self.tag);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"lookTouch at testTouchView touchesEnded view.tag=%ld", self.tag);
    [super touchesEnded:touches withEvent:event];
}


@end
