//
// Created by kai on 2017/11/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "CoordinatorLayout.h"

@interface CoordinatorLayout () <UIScrollViewDelegate> {

    CGFloat mHeadHeight;
    CGFloat mMinHeadY;

    CGFloat mContentOffsetY;
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
    mHeadHeight = CGRectGetHeight(self.headerView.frame);
    mMinHeadY = -mHeadHeight + 20;
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
    mContentOffsetY = 0;
}

- (void)settingTableView:(UITableView *)tableView {
    UIEdgeInsets inset = tableView.contentInset;
    inset.top += _headerView.frame.size.height;
    tableView.contentInset = inset;
    tableView.scrollIndicatorInsets = inset;
    tableView.contentOffset = CGPointMake(0, mContentOffsetY ?: -inset.top);
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

    CGFloat disY = mContentOffsetY - tableView.contentOffset.y;
    if (disY == 0) {
        return;
    }
    mContentOffsetY = tableView.contentOffset.y;
    if (disY > 0 && mContentOffsetY > -CGRectGetMaxY(self.headerView.frame)) {
        return;
    }
    CGRect headRect = self.headerView.frame;

    if (mContentOffsetY > -mHeadHeight) {
        headRect.size.height = mHeadHeight;
        headRect.origin.y += disY;
        headRect.origin.y = MAX(CGRectGetMinY(headRect), mMinHeadY);
        headRect.origin.y = MIN(CGRectGetMinY(headRect), 0);
    } else {
        headRect.origin.y = 0;
        headRect.size.height = mHeadHeight;
    }

    CGRect headViewRect = headRect;
    self.headerView.frame = headViewRect;

    CGFloat percent = 1;
    if (mMinHeadY != 0) {
        percent = MAX(0, CGRectGetMinY(headRect) / mMinHeadY);
        percent = MIN(1, percent);
    }

    NSLog(@"CoordinatorLayout observe offsetY=%.1f sOffsetY=%.1f disY=%.1f hH=%.1f", mContentOffsetY, tableView.contentOffset.y, disY, mHeadHeight);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger curIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.curIndex = curIndex;

    UIScrollView *curScrollView = self.contentView.subviews[curIndex];
    if (![curScrollView isKindOfClass:UIScrollView.class]) {
        return;
    }
    mContentOffsetY = curScrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self viewControllersAutoFitToScrollToIndex:self.curIndex - 1];
    [self viewControllersAutoFitToScrollToIndex:self.curIndex + 1];
}


- (void)viewControllersAutoFitToScrollToIndex:(NSInteger)index {
    NSArray<__kindof UIView *> *contentSubViewList = self.contentView.subviews;
    NSUInteger subviewCount = contentSubViewList.count;
    if (index < 0 || index >= subviewCount) {
        return;
    }
    NSInteger minIndex = 0;
    NSInteger maxIndex;
    if (index < self.curIndex) {
        minIndex = index;
        maxIndex = self.curIndex - 1;
    } else {
        minIndex = self.curIndex + 1;
        maxIndex = index;
    }
    UIScrollView *scrollView;
    for (NSInteger idx = minIndex; idx <= maxIndex; idx++) {
        scrollView = contentSubViewList[idx];
        if (![scrollView isKindOfClass:UIScrollView.class]) {
            continue;
        }
        CGFloat minY = MIN(CGRectGetMaxY(self.headerView.frame), mHeadHeight);
        if (scrollView.contentOffset.y < -minY) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -minY);
        }
    }
}

@end
