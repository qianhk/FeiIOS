//
// Created by kai on 17/2/27.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "ContentCell.h"


@implementation ContentCell {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.label.opaque = NO;
        self.label.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [[self class] defaultFont];
        [self.contentView addSubview:self.label];
    }

    return self;
}

- (NSString *)text {
    return self.label.text;
}


- (void)setText:(NSString *)text {
    self.label.text = text;
//    CGRect newLabelFrame = self.label.frame;
//    CGRect newContentFrame = self.contentView.frame;
//    CGSize textSize = [[self class] sizeForContentSize:text forMaxWidth:_maxWidth];
//    newLabelFrame.size = textSize;
//    newContentFrame.size = textSize;
//    self.label.frame = newLabelFrame;
//    self.contentView.frame = newContentFrame;
}


+ (UIFont *)defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

+ (CGSize)sizeForContentSize:(NSString *)str forMaxWidth:(CGFloat)maxWidth {
    CGSize maxSize = CGSizeMake(maxWidth, 1000);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributes = @{ NSFontAttributeName: [self defaultFont], NSParagraphStyleAttributeName: style};
    CGRect rect = [str boundingRectWithSize:maxSize options:options attributes:attributes context:nil];
    return rect.size;
}

@end