//
// Created by kai on 2017/8/22.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "CodeTextTableViewCell.h"

@interface CodeTextTableViewCell ()


@end

@implementation CodeTextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //对于代码创建的，此时self.bounds宽度是320，高度44（试了iphone5和iphone7），此时size也是不能用的
        self.codeTextLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.codeTextLabel];
        self.codeTextLabel.font = [UIFont systemFontOfSize:16.f];
        self.codeTextLabel.textColor = [UIColor blackColor];
    }

    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.codeTextLabel.frame = CGRectMake(0, 0, self.bounds.size.width, [CodeTextTableViewCell heightOfCell]);
}

- (void)configWithText:(NSString *)text {
    self.codeTextLabel.text = [NSString stringWithFormat:@"code-cell %@", text];
}

+ (float)heightOfCell {
    return 40.f;
}

@end
