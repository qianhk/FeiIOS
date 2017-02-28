//
// Created by kai on 17/2/28.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "HeaderCell.h"


@implementation HeaderCell {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label.backgroundColor = [UIColor colorWithRed:9.0 green:0.9 blue:0.8 alpha:1.0];
        self.label.textColor = [UIColor blackColor];
    }

    return self;
}

+ (UIFont *)defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

@end