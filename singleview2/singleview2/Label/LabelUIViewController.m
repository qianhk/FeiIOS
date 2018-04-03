//
//  LabelUIViewController.m
//  singleview2
//
//  Created by kai on 2018/3/14.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "LabelUIViewController.h"
#import "CustomLabel.h"
#import "UIColor+String.h"

@interface LabelUIViewController () {
    CGFloat fontSize;
}

@property (weak, nonatomic) IBOutlet CustomLabel *textLabel;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel1;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel2;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel3;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel4;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel5;
@property (weak, nonatomic) IBOutlet CustomLabel *textLabel6;

@end

@implementation LabelUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    NSArray *list = @[@(10),@(20),@(30),@(40)];
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
                           NSStrokeColorAttributeName : [UIColor redColor],
                           NSStrokeWidthAttributeName : @(-5),
                           };
    self.textLabel4.attributedText = [[NSAttributedString alloc] initWithString:@"中文Label好人一" attributes:dictStroke];
    
    dictStroke = @{
                           NSStrokeColorAttributeName : [UIColor redColor],
                           NSStrokeWidthAttributeName : @(5),
                           };
    self.textLabel5.attributedText = [[NSAttributedString alloc] initWithString:@"中文Label好人一" attributes:dictStroke];
    
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