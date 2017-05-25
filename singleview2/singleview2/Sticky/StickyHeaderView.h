//
// Created by kai on 2017/5/24.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StickyHeaderInfo;


@interface StickyHeaderView : UIView

- (void)updateDataWidth:(CGFloat)leftPadding data:(NSArray<StickyHeaderInfo *> *)data;

- (void)translationWhole:(CGFloat)offsetX;

@end