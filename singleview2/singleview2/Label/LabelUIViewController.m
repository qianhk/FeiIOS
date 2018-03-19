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

    self.textLabel6.text = @"中文Label好人一生平安\nabc\ndef";

    self.textLabel.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:80 andHeight:1 forDirection:NO];
    self.textLabel1.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:120 andHeight:1 forDirection:NO];
    self.textLabel2.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:160 andHeight:1 forDirection:NO];
    self.textLabel3.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:200 andHeight:1 forDirection:NO];
    self.textLabel4.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:1 andHeight:20 forDirection:YES];
    self.textLabel5.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:1 andHeight:37 forDirection:YES];
    self.textLabel6.textColor = [UIColor gradientFromColor:[UIColor redColor] toColor:[UIColor blueColor] withWidth:1 andHeight:20 forDirection:YES];
}

- (IBAction)sizeChanged:(UISlider *)sender {
    self.textLabel.font = [UIFont systemFontOfSize:sender.value];
    fontSize = sender.value;
}

- (IBAction)boldChanged:(UISlider *)sender {
    CGFloat stepValue = 1;

    NSInteger value = floorf((sender.value + stepValue / 2) / stepValue) * stepValue;
    NSArray *array = @[@"PingFangSC-Semibold", @"PingFangSC-Medium", @"PingFangSC-Regular", @"PingFangSC-Light", @"PingFangSC-Ultralight"];

    sender.value = value;
    self.textLabel.font = [UIFont fontWithName:(NSString *) array[value] size:fontSize];
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
