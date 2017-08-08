//
//  ArtistTableViewCell.m
//  singleview2
//
//  Created by 钱红凯 on 2017/8/8.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import "ArtistTableViewCell.h"

@implementation ArtistTableViewCell

//此方法不会被调用
- (instancetype)init {
    self = [super init];
    if (self) {
    }

    return self;
}


// 对于从xib加载，先调用initWithCoder 再调用awakeFromNib
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

//对于通过代码创建cell，只会调用initWithStyle:reuseIdentifier:
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
