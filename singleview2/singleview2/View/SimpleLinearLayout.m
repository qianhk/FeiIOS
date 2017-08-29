//
// Created by kai on 2017/8/28.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "SimpleLinearLayout.h"
#import "KaiLayoutExt.h"

@interface SimpleLinearLayout ()


@end

@implementation SimpleLinearLayout

- (void)layoutSubviews {
    [super layoutSubviews];
    NSArray<__kindof UIView *> *array = self.subviews;
    if (array.count == 0) {
        return;
    }

    CGFloat height = self.bounds.size.height;
    CGFloat left = 0;
    CGFloat widthWithoutFirst = 0;
    __kindof UIView *firstView = array[0];
    CGFloat firstWidth = firstView.frame.size.width;
    if (self.firstUseMostSpace) {
        if ([firstView isKindOfClass:UILabel.class]) {
            UILabel *label = firstView;
            CGSize size = [label sizeThatFits:CGSizeMake(self.bounds.size.width, 0)];
            firstWidth = size.width;
        }
        for (int idx = 1; idx < array.count; ++idx) {
            UIView *view = array[idx];
            if (!view.hidden) {
                widthWithoutFirst += view.extMarginLeft;
                widthWithoutFirst += view.frame.size.width;
                widthWithoutFirst += view.extMarginRight;
            }
        }
        CGFloat maxFirstWidth = self.bounds.size.width - widthWithoutFirst - firstView.extMarginLeft - firstView.extMarginRight;
        if (firstWidth > maxFirstWidth) {
            firstWidth = maxFirstWidth;
        }
    }
    CGFloat viewWidth;
    for (int idx = 0; idx < array.count; ++idx) {
        __kindof UIView *view = array[idx];
        if (!view.hidden) {
            left += view.extMarginLeft;
            if (idx == 0) {
                viewWidth = firstWidth;
            } else {
                viewWidth = view.frame.size.width;
            }
            view.frame = CGRectMake(left, (height - view.frame.size.height) / 2, viewWidth, view.frame.size.height);
            left += viewWidth;
            left += view.extMarginRight;
        }
    }
}


@end