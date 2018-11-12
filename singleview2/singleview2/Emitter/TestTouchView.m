//
// Created by kai on 2018/11/9.
// Copyright (c) 2018 Njnu. All rights reserved.
//

#import "TestTouchView.h"

@interface TestTouchView ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation TestTouchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notifyTapGestureRecognizer:)];
        _tapGestureRecognizer.numberOfTapsRequired = 1;
        _tapGestureRecognizer.numberOfTouchesRequired = 1;
//        [self addGestureRecognizer:_tapGestureRecognizer];
//        _tapGestureRecognizer.delaysTouchesBegan = YES;
        
//        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(notifyPanGestureRecognizer:)];
//        [self addGestureRecognizer:panGesture];
//        panGesture.delaysTouchesBegan = YES;
    }

    return self;
}

- (void)notifyPanGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
    CGPoint point = [recognizer translationInView:self];
    NSLog(@"lookTouch Pan Gesture view.tag=%ld point=%@", self.tag, NSStringFromCGPoint(point));
    
    //平移一共两种移动方式
    //第一种移动方法:每次移动都是从原来的位置移动
    recognizer.view.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    
    //第二种移动方式:以上次的位置为标准(移动方式 第二次移动加上第一次移动量)
//    recognizer.view.transform = CGAffineTransformTranslate(recognizer.view.transform, point.x, point.y);
//    [recognizer setTranslation:CGPointZero inView:recognizer.view];
}

- (void)notifyTapGestureRecognizer:(UITapGestureRecognizer *)recognizer {
    NSLog(@"lookTouch at testTouchView Tap Gesture view.tag=%ld", recognizer.view.tag);
}

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    NSLog(@"lookTouch hitTest at testTouchView view.tag=%ld", self.tag);
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

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"lookTouch at testTouchView touchesCancelled view.tag=%ld", self.tag);
    [super touchesCancelled:touches withEvent:event];
}


@end
