//
//  NameAndColorCellTableViewCell.m
//  singleview2
//
//  Created by 钱红凯 on 17/2/15.
//  Copyright © 2017年 TTPod. All rights reserved.
//

#import "NameAndColorCell.h"

@interface NameAndColorCell()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;

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

- (void)setColor:(NSString *)color {
    _color = [color copy];
    _colorLabel.text = _color;
}

@end
