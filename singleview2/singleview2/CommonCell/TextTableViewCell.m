//
//  TextTableViewCell.m
//  singleview2
//
//  Created by kai on 2017/8/7.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //对于xib创建的，此时self.bounds还是ide里的，不是真实的
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
