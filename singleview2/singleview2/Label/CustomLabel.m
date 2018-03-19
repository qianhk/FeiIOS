//
//  CustomLabel.m
//  singleview2
//
//  Created by kai on 2018/3/14.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomLabel.h"
#import "UIColor+String.h"

@interface CustomLabel ()

@property (nonatomic, strong) NSArray *colors;

@end

@implementation CustomLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
    }

    return self;
}

- (void)initSelf {
    self.colors = @[[UIColor redColor], [UIColor blueColor]];
}

- (void)drawTextInRect:(CGRect)rect {
    UIColor *textColor = self.textColor;
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, self.strokeWidth);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = [UIColor redColor];
    [super drawTextInRect:rect];
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    [super drawTextInRect:rect];


//    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
//    CGRect textRect = (CGRect) {0, 0, textSize};
//
//    // 画文字(不做显示用, 主要作用是设置 layer 的 mask)
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self.textColor set];
//    [self.text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font} context:NULL];
//
//    // 坐标(只对设置后的画到 context 起作用, 之前画的文字不起作用)
//    CGContextTranslateCTM(context, 0.0f, rect.size.height - (rect.size.height - textSize.height) * 0.5);
//    CGContextScaleCTM(context, 1.0f, -1.0f);
//
//    CGImageRef alphaMask = CGBitmapContextCreateImage(context);
//    CGContextClearRect(context, rect); // 清除之前画的文字
//
//    // 设置mask
//    CGContextClipToMask(context, rect, alphaMask);
//
//    // 画渐变色
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) self.colors, NULL);
//    CGPoint startPoint = CGPointMake(textRect.origin.x, textRect.origin.y);
//    CGPoint endPoint = CGPointMake(textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height);
//    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
//
//    // 释放内存
//    CGColorSpaceRelease(colorSpace);
//    CGGradientRelease(gradient);
//    CFRelease(alphaMask);

}

@end
