//
// Created by kai on 2017/8/22.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CodeTextTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *codeTextLabel;

- (void)configWithText:(NSString *)text;

+ (float)heightOfCell;

@end