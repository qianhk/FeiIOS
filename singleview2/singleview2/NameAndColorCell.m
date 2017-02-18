//
//  NameAndColorCellTableViewCell.m
//  singleview2
//
//  Created by 钱红凯 on 17/2/15.
//  Copyright © 2017年 TTPod. All rights reserved.
//

#import "NameAndColorCell.h"
#import "UIColor+String.h"

@interface NameAndColorCell ()

@property(strong, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation NameAndColorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    _nameLabel.text = _name;
}

- (void)setColor:(NSString *)colorStr {
    _color = [colorStr copy];
//    _colorLabel.text = _color;


//    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:colorStr];
//    NSDictionary *attributes = @{
////            NSFontAttributeName : []
//    };
//    NSRange colorRange = [colorStr rangeOfString:colorStr];
//    [styledText setAttributes:attributes range:colorRange];

    NSRange range = NSMakeRange(0, colorStr.length);
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:colorStr];
    [styledText addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithString:colorStr]
                       range:range];

    _colorLabel.attributedText = styledText;
}

@end
