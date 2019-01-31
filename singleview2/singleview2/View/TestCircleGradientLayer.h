//
// Created by kai on 2019-01-31.
// Copyright (c) 2019 Njnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCircleGradientLayer : CALayer

- (instancetype)initGraintCircleWithBounds:(CGRect)bounds position:(CGPoint)position fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor lineWidth:(CGFloat)lineWidth;

@end