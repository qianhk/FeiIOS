//
//  LabelUIViewController.m
//  singleview2
//
//  Created by kai on 2018/3/14.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "LabelUIViewController.h"
#import "CustomLabel.h"
#import "UIColor+String.h"
#import "NSObject+Utils.h"

@interface LabelUIViewController () {
    CGFloat fontSize;
}

- (void)appendFormat:(NSString *)format, ...;

@property (weak, nonatomic) IBOutlet CustomLabel *textLabel;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel1;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel2;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel3;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel4;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel5;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel6;

@property (nonatomic, strong) NSMutableString *mutableString;

@end

@implementation LabelUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Class clz = object_getClass(self);
    Method method = class_getInstanceMethod(clz, @selector(appendFormat:));
    class_replaceMethod(clz, @selector(appendFormat:), _objc_msgForward, method_getTypeEncoding(method));

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"value_1" forKey:@"key_1"];
    [dict setValue:nil forKey:@"key_null"];
    // [dict setValue:@"key_null_value" forKey:nil]; //'NSInvalidArgumentException', reason: '*** -[__NSDictionaryM setObject:forKey:]: key cannot be nil'
//    [dict setValue:@"value_selector" forKey:@selector(fontSizeSelector)];
    [dict setValue:@"value_3" forKey:@"key_3"];
    NSString *testKey = @"abc";
    id value = dict[testKey];
    testKey = nil;
    value = dict[testKey];

    long n = 30;
    NSArray *list = @[@(10), @(20), @(30), @(40)];
    int which = list.count;
    for (int idx = 0; idx < list.count; ++idx) {
        NSNumber *itemValue = list[idx];
        if (n <= [itemValue longValue]) { //不能用n <= itemValue，30根itemValue的地址比较肯定小的很
            which = idx + 1;
            break;
        }
    }
    NSLog(@"which = %d", which);

    self.textLabel6.text = @"中文Label好人一生平安\nabc\ndef";

    self.textLabel.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:80 andHeight:1 forDirection:NO];
    self.textLabel1.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:120 andHeight:1 forDirection:NO];
    self.textLabel2.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:160 andHeight:1 forDirection:NO];
//    self.textLabel3.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:200 andHeight:1 forDirection:NO];
//    self.textLabel4.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:1 andHeight:20 forDirection:YES];
//    self.textLabel5.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:1 andHeight:37 forDirection:YES];
//    self.textLabel6.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:1 andHeight:20 forDirection:YES];

    NSDictionary *dictStroke = @{
            NSStrokeColorAttributeName: [UIColor redColor],
            NSStrokeWidthAttributeName: @(-5),
    };
    self.textLabel4.attributedText = [[NSAttributedString alloc] initWithString:@"中文Label好人一" attributes:dictStroke];

    dictStroke = @{
            NSStrokeColorAttributeName: [UIColor redColor],
            NSStrokeWidthAttributeName: @(5),
    };
    self.textLabel5.attributedText = [[NSAttributedString alloc] initWithString:@"中文Label好人一" attributes:dictStroke];

    NSString *testUrl = @"http://1.2.3.4:5678/xxx.html?id=123&text=%61%E5%87%AF%E5%87%AF%E6%B5%8B%E8%AF%95%E4%B8%AD%E6%96%87%62";
    NSString *testUrl1_1 = [testUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *testUrl1_2 = [testUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *testUrl2 = [testUrl1_1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self testPerfromSelector];

    NSNumber *nValue1 = @(12.1);
    NSNumber *nValue2 = @(12.1f);
    NSNumber *nValue3 = @(12.9f);
    NSNumber *nValue4 = @(-12.1f);
    NSInteger intValue1 = nValue1.integerValue;
    NSInteger intValue2 = nValue2.integerValue;
    NSInteger intValue3 = nValue3.integerValue;
    NSInteger intValue4 = nValue4.integerValue;
    NSUInteger uintValue1 = nValue1.unsignedIntegerValue;
    NSUInteger uintValue2 = nValue2.unsignedIntegerValue;
    NSUInteger uintValue3 = nValue3.unsignedIntegerValue;
    NSUInteger uintValue4 = nValue4.unsignedIntegerValue;
    NSLog(@"lookKai int %ld %ld %ld %ld", intValue1, intValue2, intValue3, intValue4);
    NSLog(@"lookKai uint %lu %lu %lu %lu", uintValue1, uintValue2, uintValue3, uintValue4);

    NSString *tmpStr = @"101010100011";
    for (int idx = 0; idx < tmpStr.length; ++idx) {
        unichar charAtIndex = [tmpStr characterAtIndex:idx];
        NSLog(@"lookKai unichar idx=%d isNoZero=%d", idx, charAtIndex != '0');
    }

    double testDouble = 12.3;
    [self testTypeNotSame:testDouble];
    testDouble = 12.6;
    [self testTypeNotSame:testDouble];

    NSNumber *testInteger = @(123);
    NSNumber *testFloat = @(123.4567f);
    NSLog(@"lookKai numberToString integer %@", testInteger.stringValue);
    NSLog(@"lookKai numberToString float %@", testFloat.stringValue);

    CGRect rect1 = CGRectMake(100, 100, 100, 100);
    CGRect rect2 = CGRectMake(120, 120, 100, 100);
    CGRect intersectionRect = CGRectIntersection(rect1, rect2);
    NSLog(@"inter1 %d %d %@", CGRectContainsRect(rect1, rect2), CGRectIntersectsRect(rect1, rect2), NSStringFromCGRect(intersectionRect));

    rect1 = CGRectMake(1000, 1000, 100, 100);
    intersectionRect = CGRectIntersection(rect1, rect2);
    NSLog(@"inter2 %d %d %@", CGRectContainsRect(rect1, rect2), CGRectIntersectsRect(rect1, rect2), NSStringFromCGRect(intersectionRect));
}

- (void)testTypeNotSame:(NSUInteger)number {
    NSLog(@"lookKai testTypeNotSame %lu", number);
}

- (void)testPerfromSelector {
    NSMutableString *ms = [[NSMutableString alloc] init];
    self.mutableString = ms;
    [ms appendFormat:@"first %d ", 1];
    [ms performSelector:@selector(appendString:) withObjects:@[@"second 2 "]];
//    NSInvocation *invocation = [NSInvocation invocationWithTarget:ms andSelector:@selector(appendString:) andArguments:@"second 2 ", nil];
//    [invocation invoke];
////    [ms performSelector:@selector(appendFormat:) withObjects:@[@"third %@ ", @(3)]];
//    invocation = [NSInvocation invocationWithTarget:ms andSelector:@selector(appendFormat:) andArguments:@"third %@ ", @(3), nil];
//    [invocation invoke];

    [self appendFormat:@"third %@ ", @(3), nil];

    [ms appendFormat:@"fourth %d ", 4];
    NSLog(ms);
    NSLog(@"lookInvoke %@", ms);
    self.mutableString = nil;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (sel_isEqual(aSelector, @selector(appendFormat:))) {
        return self.mutableString;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (IBAction)sizeChanged:(UISlider *)sender {
    self.textLabel.font = [UIFont systemFontOfSize:sender.value];
    fontSize = sender.value;
}

- (IBAction)boldChanged:(UISlider *)sender {
    CGFloat stepValue = 1;

    NSInteger value = floorf((sender.value + stepValue / 2) / stepValue) * stepValue;
    NSArray *array = @[@"PingFangSC-Semibold1", @"PingFangSC-Medium2", @"PingFangSC-Regular3", @"PingFangSC-Light4", @"PingFangSC-Ultralight5"];

    sender.value = value;
    UIFont *font = [UIFont fontWithName:(NSString *) array[value] size:fontSize];
    if (font == nil) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    self.textLabel.font = font;
}

- (IBAction)stokeChanged:(UISlider *)sender {
    self.textLabel.strokeWidth = sender.value;
    [self.textLabel setNeedsDisplay];
}

- (IBAction)wordGapChanged:(UISlider *)sender {
    NSDictionary *dic = @{NSKernAttributeName: @(sender.value)
    };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.textLabel.text attributes:dic];
    self.textLabel.attributedText = attributeStr;
}

@end
