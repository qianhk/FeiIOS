//
// Created by kai on 2017/11/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "CoordinatorLayout.h"

@interface CoordinatorLayout () {

    CGFloat headHeight;
    CGFloat minHeadY;

    CGFloat _contentOffsetY;
}

@end

@implementation CoordinatorLayout

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize selfSize = self.bounds.size;
    CGRect headerFrame = self.headerView.frame;
    NSLog(@"CoordinatorLayout layoutSubviews header: y=%.1f h=%.1f", headerFrame.origin.y, headerFrame.size.height);
    self.contentView.frame = self.bounds;
}

- (void)setHeaderView:(UIView *)headerView {
    if (_headerView) {
        [_headerView removeFromSuperview];
    }
    _headerView = headerView;
    [self addSubview:_headerView];
    headHeight = CGRectGetHeight(self.headerView.frame);
    minHeadY = -headHeight + 20;
    [self bringSubviewToFront:_headerView];

}

- (void)setContentView:(UIView *)contentView {
    if (_contentView) {
        [_contentView removeFromSuperview];
        [self removeObserverForView:_contentView];
    }
    _contentView = contentView;
    [self addSubview:_contentView];
    if ([contentView isKindOfClass:UIScrollView.class]) {
        UIScrollView *view = (UIScrollView *) contentView;
        CGPoint point = CGPointMake(0, -_headerView.frame.size.height);
//        view.contentOffset = point;
        view.contentInset = UIEdgeInsetsMake(_headerView.frame.size.height, 0, 0, 0);
        [view addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
    }
    [self sendSubviewToBack:_contentView];
    _contentOffsetY = 0;
}

- (void)removeObserverForView:(UIView *)view {
    @try {
        [(UIScrollView *) view removeObserver:self forKeyPath:@"contentOffset"];
    } @catch (NSException *exception) {
        NSLog(@"removeObserverForView error: %@", exception);
    } @finally {
    }
}

- (void)dealloc {
    [self removeObserverForView:_contentView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIScrollView *scrollView = (UIScrollView *) _contentView;
//    NSLog(@"CoordinatorLayout observe sOffsetY=%.1f", scrollView.contentOffset.y);
    if (!_headerView || ![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }

    CGFloat disY = _contentOffsetY - scrollView.contentOffset.y;
    if (disY == 0) {
        return;
    }
    _contentOffsetY = scrollView.contentOffset.y;
    if (disY > 0 && _contentOffsetY > -CGRectGetMaxY(self.headerView.frame)) {
        return;
    }
    CGRect headRect = self.headerView.frame;

    if (_contentOffsetY > -headHeight) {
        headRect.size.height = headHeight;
        headRect.origin.y += disY;
        headRect.origin.y = MAX(CGRectGetMinY(headRect), minHeadY);
        headRect.origin.y = MIN(CGRectGetMinY(headRect), 0);
    } else {
        headRect.origin.y = 0;
        headRect.size.height = headHeight;
    }

    CGRect headViewRect = headRect;
    self.headerView.frame = headViewRect;

    CGFloat percent = 1;
    if (minHeadY != 0) {
        percent = MAX(0, CGRectGetMinY(headRect) / minHeadY);
        percent = MIN(1, percent);
    }

    NSLog(@"CoordinatorLayout observe offsetY=%.1f sOffsetY=%.1f disY=%.1f hH=%.1f", _contentOffsetY, scrollView.contentOffset.y, disY, headHeight);
}

@end
