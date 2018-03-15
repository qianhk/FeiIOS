//
//  LabelUIViewController.m
//  singleview2
//
//  Created by kai on 2018/3/14.
//  Copyright © 2018年 Njnu. All rights reserved.
//

#import "LabelUIViewController.h"
#import "CustomLabel.h"

@interface LabelUIViewController () {
    CGFloat fontSize;
}

@property (weak, nonatomic) IBOutlet CustomLabel *textLabel;

@end

@implementation LabelUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
