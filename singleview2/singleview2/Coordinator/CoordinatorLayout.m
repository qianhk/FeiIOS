//
// Created by kai on 2017/11/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "CoordinatorLayout.h"

@interface CoordinatorLayout () <UIScrollViewDelegate> {

    CGFloat headHeight;
    CGFloat minHeadY;

    CGFloat _contentOffsetY;
}

@property (nonatomic, assign) NSInteger curIndex;

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
        [self doRemoveScrollViewDelegate:_contentView];
        [self removeObserverForView:_contentView];
    }
    _contentView = contentView;
    [self addSubview:_contentView];
    if ([contentView isKindOfClass:UITableView.class]) {
        [self settingTableView:(UITableView *) contentView];
    } else if ([_contentView isKindOfClass:UIScrollView.class]) {
        [self doAddScrollViewDelegate:(UIScrollView *) _contentView];
        NSArray<__kindof UIView *> *array = contentView.subviews;
        for (int idx = 0; idx < array.count; ++idx) {
            UIView *subView = array[idx];
            if ([subView isKindOfClass:UITableView.class]) {
                [self settingTableView:(UITableView *) subView];
            }
        }
    }
    [self sendSubviewToBack:_contentView];
    _contentOffsetY = 0;
}

- (void)settingTableView:(UITableView *)tableView {
    UIEdgeInsets inset = tableView.contentInset;
    inset.top += _headerView.frame.size.height;
    tableView.contentInset = inset;
    tableView.scrollIndicatorInsets = inset;
    tableView.contentOffset = CGPointMake(0, _contentOffsetY ?: -inset.top);
    tableView.scrollsToTop = NO;

    [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
}

- (void)removeObserverForView:(UIView *)view {
    if ([view isKindOfClass:UITableView.class]) {
        [self doRemoveObserveForTableView:(UITableView *) view];
    } else if ([view isKindOfClass:UIScrollView.class]) {
        NSArray<__kindof UIView *> *array = view.subviews;
        for (int idx = 0; idx < array.count; ++idx) {
            UIView *subView = array[idx];
            if ([subView isKindOfClass:UITableView.class]) {
                [self doRemoveObserveForTableView:(UITableView *) view];
            }
        }
    }
}

- (void)doRemoveObserveForTableView:(UITableView *)view {
    @try {
        [view removeObserver:self forKeyPath:@"contentOffset"];
    } @catch (NSException *exception) {
        NSLog(@"removeObserverForView error: %@", exception);
    } @finally {
    }
}

- (void)doAddScrollViewDelegate:(UIScrollView *)scrollView {
    scrollView.delegate = self;
}

- (void)doRemoveScrollViewDelegate:(UIView *)view {
    if (![view isKindOfClass:UITableView.class] && [view isKindOfClass:UIScrollView.class]) {
        UIScrollView *scrollView = (UIScrollView *) view;
        scrollView.delegate = nil;
    }
}

- (void)dealloc {
    [self doRemoveScrollViewDelegate:_contentView];
    [self removeObserverForView:_contentView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UITableView *tableView;
    if ([_contentView isKindOfClass:UITableView.class]) {
        tableView = (UITableView *) _contentView;
    } else {
        tableView = _contentView.subviews[self.curIndex];
    }
//    NSLog(@"CoordinatorLayout observe sOffsetY=%.1f", scrollView.contentOffset.y);
    if (!_headerView || ![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }

    CGFloat disY = _contentOffsetY - tableView.contentOffset.y;
    if (disY == 0) {
        return;
    }
    _contentOffsetY = tableView.contentOffset.y;
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

    NSLog(@"CoordinatorLayout observe offsetY=%.1f sOffsetY=%.1f disY=%.1f hH=%.1f", _contentOffsetY, tableView.contentOffset.y, disY, headHeight);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger curIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.curIndex = curIndex;
}

@end
