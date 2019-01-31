//
// Created by kai on 2019-01-31.
// Copyright (c) 2019 Njnu. All rights reserved.
//

#import "TestCircleGradientLayer.h"

@interface TestCircleGradientLayer ()


@end

@implementation TestCircleGradientLayer

- (instancetype)initGraintCircleWithBounds:(CGRect)bounds position:(CGPoint)position fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor lineWidth:(CGFloat)lineWidth {

    self = [super init];
    if (!self) {
        return nil;
    }

    self.bounds = bounds;
    self.position = position;
    NSArray *colors = [self graintFromColor:fromColor toColor:toColor count:4];
    for (int i = 0; i < colors.count - 1; i++) {
        CAGradientLayer *graint = [CAGradientLayer layer];
        graint.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds) / 2, CGRectGetHeight(bounds) / 2);
        NSValue *valuePoint = [[self positionArrayWithMainBounds:self.bounds] objectAtIndex:i];
        graint.position = valuePoint.CGPointValue;
        UIColor *fromColor = colors[i];
        UIColor *toColor = colors[i + 1];
        NSArray *colors = @[(id) fromColor.CGColor, (id) toColor.CGColor];
        NSNumber *stopOne = @0.0F;
        NSNumber *stopTwo = @1.0F;
        NSArray *locations = @[stopOne, stopTwo];
        graint.colors = colors;
        graint.locations = locations;
        graint.startPoint = ((NSValue *) [self startPoints][i]).CGPointValue;
        graint.endPoint = ((NSValue *) [self endPoints][i]).CGPointValue;
        [self addSublayer:graint];
    }

    //Set mask
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.bounds) - 2 * lineWidth, CGRectGetHeight(self.bounds) - 2 * lineWidth);
    shapelayer.bounds = rect;
    shapelayer.position = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    shapelayer.strokeColor = [UIColor blueColor].CGColor;
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CGRectGetWidth(rect) / 2].CGPath;
    shapelayer.lineWidth = lineWidth;
    shapelayer.lineCap = kCALineCapRound;
    shapelayer.strokeStart = 0.015;
    shapelayer.strokeEnd = 0.985;
    [self setMask:shapelayer];

    return self;
}

- (NSArray *)positionArrayWithMainBounds:(CGRect)bounds {
    CGPoint first = CGPointMake(CGRectGetWidth(bounds) / 4 * 3, CGRectGetHeight(bounds) / 4 * 1);
    CGPoint second = CGPointMake(CGRectGetWidth(bounds) / 4 * 3, CGRectGetHeight(bounds) / 4 * 3);
    CGPoint thrid = CGPointMake(CGRectGetWidth(bounds) / 4 * 1, CGRectGetHeight(bounds) / 4 * 3);
    CGPoint fourth = CGPointMake(CGRectGetWidth(bounds) / 4 * 1, CGRectGetHeight(bounds) / 4 * 1);
    return @[[NSValue valueWithCGPoint:first],
            [NSValue valueWithCGPoint:second],
            [NSValue valueWithCGPoint:thrid],
            [NSValue valueWithCGPoint:fourth]];
}

- (NSArray *)startPoints {
    return @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
            [NSValue valueWithCGPoint:CGPointMake(1, 0)],
            [NSValue valueWithCGPoint:CGPointMake(1, 1)],
            [NSValue valueWithCGPoint:CGPointMake(0, 1)]];
}

- (NSArray *)endPoints {
    return @[[NSValue valueWithCGPoint:CGPointMake(1, 1)],
            [NSValue valueWithCGPoint:CGPointMake(0, 1)],
            [NSValue valueWithCGPoint:CGPointMake(0, 0)],
            [NSValue valueWithCGPoint:CGPointMake(1, 0)]];
}

- (NSArray *)graintFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor count:(NSInteger)count {
    CGFloat fromR = 0.0, fromG = 0.0, fromB = 0.0, fromAlpha = 0.0;
    [fromColor getRed:&fromR green:&fromG blue:&fromB alpha:&fromAlpha];
    CGFloat toR = 0.0, toG = 0.0, toB = 0.0, toAlpha = 0.0;
    [toColor getRed:&toR green:&toG blue:&toB alpha:&toAlpha];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i <= count; i++) {
        CGFloat oneR = fromR + (toR - fromR) / count * i;
        CGFloat oneG = fromG + (toG - fromG) / count * i;
        CGFloat oneB = fromB + (toB - fromB) / count * i;
        CGFloat oneAlpha = fromAlpha + (toAlpha - fromAlpha) / count * i;
        UIColor *onecolor = [UIColor colorWithRed:oneR green:oneG blue:oneB alpha:oneAlpha];
        [result addObject:onecolor];
    }
//        [result addObject:[self midColorWithFromColor:fromColor toColor:toColor progress:0.0]];
//        [result addObject:[self midColorWithFromColor:fromColor toColor:toColor progress:0.2]];
//        [result addObject:[self midColorWithFromColor:fromColor toColor:toColor progress:0.4]];
//        [result addObject:[self midColorWithFromColor:fromColor toColor:toColor progress:0.6]];
//        [result addObject:[self midColorWithFromColor:fromColor toColor:toColor progress:1.0]];

    return result;
}

- (UIColor *)midColorWithFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    CGFloat fromR = 0.0, fromG = 0.0, fromB = 0.0, fromAlpha = 0.0;
    [fromColor getRed:&fromR green:&fromG blue:&fromB alpha:&fromAlpha];
    CGFloat toR = 0.0, toG = 0.0, toB = 0.0, toAlpha = 0.0;
    [toColor getRed:&toR green:&toG blue:&toB alpha:&toAlpha];
    CGFloat oneR = fromR + (toR - fromR) * progress;
    CGFloat oneG = fromG + (toG - fromG) * progress;
    CGFloat oneB = fromB + (toB - fromB) * progress;
    CGFloat oneAlpha = fromAlpha + (toAlpha - fromAlpha) * progress;
    UIColor *onecolor = [UIColor colorWithRed:oneR green:oneG blue:oneB alpha:oneAlpha];
    return onecolor;
}

@end