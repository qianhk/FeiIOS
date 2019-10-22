//
// Created by kai on 2019/10/21.
// Copyright (c) 2019 Njnu. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "TestCoreTextView1.h"

@interface TestCoreTextView1 ()


@end

@implementation TestCoreTextView1

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGRect bounds = self.bounds;
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 步骤 2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 步骤 3
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectInset(bounds, 10, 20));

    // 步骤 4
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"Hello Hello凯👀!"];
    CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 16, NULL);
    [attString addAttribute:(id) kCTFontAttributeName value:(__bridge id) font range:NSMakeRange(0, 5)];

    font = CTFontCreateWithName((CFStringRef) @"ArialMT", 16, NULL);
    [attString addAttribute:(id) kCTFontAttributeName value:(__bridge id) font range:NSMakeRange(6, 5)];

    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"👀 空心字" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:32]}]];

//    long number = 2;
//    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"空心字" attributes:@{NSStrokeWidthAttributeName: @(1), NSStrokeColorAttributeName: [UIColor orangeColor], NSFontAttributeName: [UIFont systemFontOfSize:32]}]]; //stroke width 为正数时，foregroundcolor无效，不使用

    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"空心字" attributes:@{NSStrokeWidthAttributeName: @(-1), NSStrokeColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:32], NSForegroundColorAttributeName: [UIColor greenColor]}]];

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    // 步骤 5
    CTFrameDraw(frame, context);



    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1.0);
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    CGContextAddRect(context, CGRectMake(10, 420, 100, 100));
    CGContextStrokePath(context);
    
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1.0);
    CGContextSetLineWidth(context, 15.0);
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    CGContextAddRect(context, CGRectMake(130, 420, 100, 100));
    CGContextStrokePath(context);
    
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1.0);
    CGContextSetLineWidth(context, 20.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextAddRect(context, CGRectMake(260, 420, 100, 100));
    CGContextStrokePath(context);
    
    

    // 步骤 6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

@end
