//
// Created by kai on 2017/5/24.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "StickyHeaderView.h"
#import "StickyHeaderInfo.h"
#import "UIColor+String.h"
#import "Person.h"

@interface StickyHeaderView ()

@property(nonatomic, assign) CGFloat leftPadding;
@property(nonatomic, strong) NSMutableArray<StickyHeaderInfo *> *infoList;
@property(nonatomic, strong) UIView *leftHolderView;

@property(nonatomic, strong) NSMutableArray<UILabel *> *viewPool;

@property(nonatomic, assign) CGFloat lastOffsetX;

@end

@implementation StickyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.viewPool = [NSMutableArray array];
        self.infoList = [NSMutableArray array];
    }

    return self;
}


- (void)updateDataWidth:(CGFloat)leftPadding data:(NSArray<StickyHeaderInfo *> *)infoList {
    self.leftPadding = leftPadding;

    NSArray<__kindof UIView *> *subviews = [self subviews];
    for (int idx = subviews.count - 1; idx >= 0; --idx) {
        UIView *childView = subviews[idx];
        if (childView != _leftHolderView) {
            [_viewPool addObject:(UILabel *) childView];
        }
        [childView removeFromSuperview];
    }

    [self.infoList removeAllObjects];
    int infoSize = infoList.count;
    if (infoSize == 0) {
        return;
    }

    if (infoSize > 40) {
        [self.infoList addObjectsFromArray:[infoList subarrayWithRange:NSMakeRange(0, 40)]];
    } else {
        [self.infoList addObjectsFromArray:infoList];
    }

    int x = self.leftPadding;
    for (StickyHeaderInfo *info in self.infoList) {
        UILabel *textView = [self getLabelView];
        textView.text = info.title;
        x += info.marginLeft;
        info.wholeTx = x;
        info.tx = x;
    }

    if (self.leftHolderView == nil) {
        self.leftHolderView = [self getLeftHolderView];
    }
    [self addSubview:self.leftHolderView];

    [self updateViewTranslationX];
}

- (void)translationWhole:(CGFloat)offsetX {
    CGFloat dx = offsetX - self.lastOffsetX;

    for (StickyHeaderInfo *info in self.infoList) {
        info.wholeTx -= dx;
        info.tx -= dx;
    }

    [self updateViewTranslationX];
}

- (void)updateViewTranslationX {

    for (int idx = 0; idx < self.infoList.count; ++idx) {
        self.subviews[idx].center = CGPointMake(self.infoList[idx].tx + 37.f / 2, 17.f / 2);
    }

    if (self.infoList.count > 0) {
        StickyHeaderInfo *info = self.infoList[0];
        CGRect rect = self.leftHolderView.frame;
        self.leftHolderView.frame = CGRectMake(info.tx - rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
    }

}


- (UILabel *)getLabelView {
    if (self.viewPool.count == 0) {
        UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 37, 17)];
        textView.textColor = [Person stickyGrayColor];
        textView.font = [UIFont systemFontOfSize:12];
        textView.textAlignment = NSTextAlignmentCenter;
        textView.layer.borderWidth = 1;
        textView.layer.cornerRadius = 17.f / 2;
        textView.layer.borderColor = [Person stickyGrayColor].CGColor;
        [self addSubview:textView];
        return textView;
    } else {
        UILabel *textView = [self.viewPool lastObject];
        [self.viewPool removeLastObject];
        [self addSubview:textView];
        return textView;
    }
}

- (UIView *)getLeftHolderView {
    UIView *holderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.leftPadding, 17)];
    holderView.backgroundColor = [UIColor whiteColor];
    return holderView;
}

@end