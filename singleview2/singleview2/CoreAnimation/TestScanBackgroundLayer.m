//
//  TestScanBackgroundLayer.m
//  singleview2
//
//  Created by k on 2019/2/27.
//  Copyright © 2019 Njnu. All rights reserved.
//

#import "TestScanBackgroundLayer.h"

#define CORNERLENGTH 15

@interface TestScanBackgroundLayer () <CAAnimationDelegate>

@property (strong, nonatomic) CALayer *lineLayer;

@property (nonatomic) CGRect focusRect;
@property (copy, nonatomic) void (^completion)(void);
@end


@implementation TestScanBackgroundLayer

@dynamic focusRect;

- (instancetype)initWithBounds:(CGRect)bounds BackgroundColor:(UIColor *)backgroundColor focusRect:(CGRect)focusRect {
    if (self = [super init]) {
        self.anchorPoint = CGPointZero;
        self.position = CGPointZero;
        self.bounds = bounds;
        self.animateDurationWhenFocusChange = 0.4;
        self.contentsScale = [UIScreen mainScreen].scale;
        self.needsDisplayOnBoundsChange = true;
        self.focusRect = focusRect;
        self.lineLayer = [[CALayer alloc] init];
        self.lineLayer.frame = CGRectMake(focusRect.origin.x, focusRect.origin.y, focusRect.size.width, 1);
        self.lineLayer.backgroundColor = [UIColor magentaColor].CGColor;
        [self addSublayer:self.lineLayer];
        [self setNeedsDisplay];
        [self startAnimate];
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"focusRect"]) {
        return true;
    }
    return [super needsDisplayForKey:key];
}

- (id <CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"focusRect"]) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:event];
        anim.fromValue = [[self presentationLayer] valueForKey:event];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        anim.delegate = self;
        anim.duration = self.animateDurationWhenFocusChange;
        [anim setValue:@"leoStateChageAnimation" forKey:@"lhCodeKey"];
        return anim;
    }
    return [super actionForKey:event];
}

- (void)animationDidStart:(CAAnimation *)anim {
    if ([[anim valueForKey:@"lhCodeKey"] isEqualToString:@"leoStateChageAnimation"]) {
        [self stopAnimate];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:@"lhCodeKey"] isEqualToString:@"leoStateChageAnimation"]) {
        [self startAnimate];
        if (self.completion) {
            self.completion();
            self.completion = nil;
        }
    }
}

- (void)updateFocus:(CGRect)focusRect Completion:(void (^)(void))completion {
    self.focusRect = focusRect;
    self.completion = completion;
}

- (void)drawInContext:(CGContextRef)ctx {
    UIBezierPath *focusPath = [self createBezierPathWithBounds:self.bounds focusRect:self.focusRect];
    CGContextAddPath(ctx, focusPath.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor);
    CGContextEOFillPath(ctx);

    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextSetLineWidth(ctx, 2.0);


    CGContextMoveToPoint(ctx, self.focusRect.origin.x + CORNERLENGTH, self.focusRect.origin.y);
    CGContextAddLineToPoint(ctx, self.focusRect.origin.x, self.focusRect.origin.y);
    CGContextAddLineToPoint(ctx, self.focusRect.origin.x, self.focusRect.origin.y + CORNERLENGTH);
    CGContextStrokePath(ctx);

    CGContextMoveToPoint(ctx, self.focusRect.origin.x + self.focusRect.size.width - CORNERLENGTH, self.focusRect.origin.y);
    CGContextAddLineToPoint(ctx, self.focusRect.origin.x + self.focusRect.size.width, self.focusRect.origin.y);
    CGContextAddLineToPoint(ctx, self.focusRect.origin.x + self.focusRect.size.width, self.focusRect.origin.y + CORNERLENGTH);
    CGContextStrokePath(ctx);

    CGContextMoveToPoint(ctx, self.focusRect.origin.x + self.focusRect.size.width, self.focusRect.origin.y + self.focusRect.size.height - CORNERLENGTH);
    CGContextAddLineToPoint(ctx, self.focusRect.origin.x + self.focusRect.size.width, self.focusRect.origin.y + self.focusRect.size.height);
    CGContextAddLineToPoint(ctx, self.focusRect.origin.x + self.focusRect.size.width - CORNERLENGTH, self.focusRect.origin.y + self.focusRect.size.height);
    CGContextStrokePath(ctx);

    CGContextMoveToPoint(ctx, self.focusRect.origin.x, self.focusRect.origin.y - CORNERLENGTH + self.focusRect.size.height);
    CGContextAddLineToPoint(ctx, self.focusRect.origin.x, self.focusRect.origin.y + self.focusRect.size.height);
    CGContextAddLineToPoint(ctx, self.focusRect.origin.x + CORNERLENGTH, self.focusRect.origin.y + self.focusRect.size.height);
    CGContextStrokePath(ctx);

    UIBezierPath *beziper = [UIBezierPath bezierPathWithRect:self.focusRect];
    CGContextAddPath(ctx, beziper.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextStrokePath(ctx);
}

- (UIBezierPath *)createBezierPathWithBounds:(CGRect)bounds focusRect:(CGRect)focusRect {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:bounds];
    UIBezierPath *focusPath = [UIBezierPath bezierPathWithRect:focusRect];
    [bezierPath appendPath:focusPath];
    return bezierPath;
}

- (void)startAnimate {
    [CATransaction begin];
    [CATransaction setValue:(id) kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    self.lineLayer.frame = CGRectMake(self.focusRect.origin.x, self.focusRect.origin.y, self.focusRect.size.width, 1);
    self.lineLayer.hidden = false;
    [CATransaction commit];

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.toValue = @(self.focusRect.origin.y + self.focusRect.size.height);
    animation.duration = 1.5;
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.lineLayer addAnimation:animation forKey:@"linePositionAnimation"];
}

- (void)stopAnimate {
    [CATransaction begin];
    [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.lineLayer.hidden = true;
    [CATransaction commit];
    [self.lineLayer removeAllAnimations];
}

@end

