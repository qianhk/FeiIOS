//
// Created by KaiKai on 17/2/18.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "UIColor+String.h"

static NSDictionary<NSString *, UIColor *> *sColorMap;

@implementation UIColor (String)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:1];
            green = [self colorComponentFrom:colorString start:1 length:1];
            blue = [self colorComponentFrom:colorString start:2 length:1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom:colorString start:0 length:1];
            red = [self colorComponentFrom:colorString start:1 length:1];
            green = [self colorComponentFrom:colorString start:2 length:1];
            blue = [self colorComponentFrom:colorString start:3 length:1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:2];
            green = [self colorComponentFrom:colorString start:2 length:2];
            blue = [self colorComponentFrom:colorString start:4 length:2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom:colorString start:0 length:2];
            red = [self colorComponentFrom:colorString start:2 length:2];
            green = [self colorComponentFrom:colorString start:4 length:2];
            blue = [self colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            [NSException raise:@"Invalid color value" format:@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithColorName:(NSString *)colorName {
    UIColor *color;
    if (!sColorMap) {
        [self prepareColorName];
    }
    color = sColorMap[colorName];
    if (!color) {
        color = [UIColor clearColor];
    }
    return color;
}

+ (UIColor *)colorWithString:(NSString *)string {
    if (string && string.length > 0) {
        if ([string characterAtIndex:0] == '#') {
            return [self colorWithHexString:string];
        } else {
            return [self colorWithColorName:string];
        }
    } else {
        return [UIColor clearColor];
    }
}

+ (void)prepareColorName {
    sColorMap = @{
            @"Orange": [UIColor orangeColor], @"Red": [UIColor redColor], @"Green": [UIColor greenColor], @"Blue": [UIColor blueColor], @"Cyan": [UIColor cyanColor]
    };
//    @property(class, nonatomic, readonly) UIColor *blackColor;      // 0.0 white
//    @property(class, nonatomic, readonly) UIColor *darkGrayColor;   // 0.333 white
//    @property(class, nonatomic, readonly) UIColor *lightGrayColor;  // 0.667 white
//    @property(class, nonatomic, readonly) UIColor *whiteColor;      // 1.0 white
//    @property(class, nonatomic, readonly) UIColor *grayColor;       // 0.5 white
//    @property(class, nonatomic, readonly) UIColor *redColor;        // 1.0, 0.0, 0.0 RGB
//    @property(class, nonatomic, readonly) UIColor *greenColor;      // 0.0, 1.0, 0.0 RGB
//    @property(class, nonatomic, readonly) UIColor *blueColor;       // 0.0, 0.0, 1.0 RGB
//    @property(class, nonatomic, readonly) UIColor *cyanColor;       // 0.0, 1.0, 1.0 RGB
//    @property(class, nonatomic, readonly) UIColor *yellowColor;     // 1.0, 1.0, 0.0 RGB
//    @property(class, nonatomic, readonly) UIColor *magentaColor;    // 1.0, 0.0, 1.0 RGB
//    @property(class, nonatomic, readonly) UIColor *orangeColor;     // 1.0, 0.5, 0.0 RGB
//    @property(class, nonatomic, readonly) UIColor *purpleColor;     // 0.5, 0.0, 0.5 RGB
//    @property(class, nonatomic, readonly) UIColor *brownColor;      // 0.6, 0.4, 0.2 RGB
//    @property(class, nonatomic, readonly) UIColor *clearColor;      // 0.0 white, 0.0 alpha
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *)gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withWidth:(CGFloat)width andHeight:(CGFloat)height forDirection:(BOOL)vertical {
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();

    NSArray *colors = @[(id) c1.CGColor, (id) c2.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef) colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(vertical ? 0 : size.width, vertical ? size.height : 0), 0);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();

    return [UIColor colorWithPatternImage:image];
}

@end