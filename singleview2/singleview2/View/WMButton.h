//
// Created by kai on 2017/12/29.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WMButton : UIButton

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;
- (UIColor *)backgroundColorForState:(UIControlState)state;

@end