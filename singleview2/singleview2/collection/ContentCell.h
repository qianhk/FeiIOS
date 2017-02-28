//
// Created by kai on 17/2/27.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ContentCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) CGFloat  maxWidth;

+ (CGSize)sizeForContentSize:(NSString *)str forMaxWidth:(CGFloat)maxWidth;

@end