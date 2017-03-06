//
// Created by kai on 17/3/5.
// Copyright (c) 2017 njnu. All rights reserved.
//

#import "MyDrawerView.h"


@implementation MyDrawerView {

}

- (void)drawRect:(CGRect)rect {
    CGContextRef pContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(pContext, 2.0);
    CGContextSetStrokeColorWithColor(pContext, [UIColor magentaColor].CGColor);

    CGContextMoveToPoint(pContext, 10, 10);
    CGContextAddLineToPoint(pContext, 100, 100);
    CGContextStrokePath(pContext);
}


@end