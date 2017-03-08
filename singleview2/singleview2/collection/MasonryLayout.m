//
// Created by kai on 17/3/7.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "MasonryLayout.h"


@interface MasonryLayout () {
    NSUInteger _numberOfColumns; //列数

    NSMutableDictionary *_layoutInfo;    //储存每个cell的UICollectionViewLayoutAttributes
    NSMutableDictionary *_lastYValueForColumn; //储存每一列当前最大y坐标

    LayoutStyle _style;
}

@end

@implementation MasonryLayout

- (instancetype)initWithLayoutStyle:(LayoutStyle)style {
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)prepareLayout {
    _numberOfColumns = 3;
//    NSLog(@"lookLayout prepareLayout");
    _lastYValueForColumn = [NSMutableDictionary dictionary];
    _layoutInfo = [NSMutableDictionary dictionary];

    switch (_style) {
        case LayoutStyleInOrder: {
            [self getLayoutInfoInOrder];
        }
            break;
        case LayoutStyleRegular: {
            [self getLayoutInfoRegular];
        }
            break;
        default:
            break;
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSLog(@"lookLayout layoutAttributesForElementsInRect");
    NSMutableArray *allAttributes = [NSMutableArray array];
    [_layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }];
    return allAttributes;
}

- (CGSize)collectionViewContentSize {
    NSUInteger currentColumns = 0;
    CGFloat maxHeight = 0;
    do {
        CGFloat height = [_lastYValueForColumn[@(currentColumns)] doubleValue];
        if (height > maxHeight) {
            maxHeight = height;
        }
        currentColumns++;
    } while (currentColumns < _numberOfColumns);
//    NSLog(@"lookLayout collectionViewContentSize maxHeight=%d", maxHeight);
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight);
}

#pragma mark -- private function

- (void)getLayoutInfoInOrder {
    NSUInteger currentColumn = 0;
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - MasonryCollectionViewSpaceWidth * (_numberOfColumns + 1)) / _numberOfColumns;

    NSIndexPath *indexPath;
    NSInteger numberOfSection = [self.collectionView numberOfSections];

    for (NSInteger section = 0; section < numberOfSection; section++) {
        NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:section];

        for (NSInteger item = 0; item < numberOfItem; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];

            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

            CGFloat originX = MasonryCollectionViewSpaceWidth + (itemWidth + MasonryCollectionViewSpaceWidth) * currentColumn;
            CGFloat originY = [_lastYValueForColumn[@(currentColumn)] doubleValue];
            if (originY == 0.0) {
                originY = MasonryCollectionViewSpaceWidth;
            }

            CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];

            itemAttributes.frame = CGRectMake(originX, originY, itemWidth, itemHeight);
            _layoutInfo[indexPath] = itemAttributes;
            _lastYValueForColumn[@(currentColumn)] = @(originY + itemHeight + MasonryCollectionViewSpaceWidth);

            currentColumn++;
            if (currentColumn == _numberOfColumns) {
                currentColumn = 0;
            }

        }

    }
}

- (void)getLayoutInfoRegular {
    NSUInteger currentColumn = 0;
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - MasonryCollectionViewSpaceWidth * (_numberOfColumns + 1)) / _numberOfColumns;

    NSIndexPath *indexPath;
    NSInteger numberOfSection = [self.collectionView numberOfSections];

    for (NSInteger section = 0; section < numberOfSection; section++) {
        NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:section];

        for (NSInteger item = 0; item < numberOfItem; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];

            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

            currentColumn = [self getMiniHeightColumn];
            CGFloat originX = MasonryCollectionViewSpaceWidth + (itemWidth + MasonryCollectionViewSpaceWidth) * currentColumn;
            CGFloat originY = [_lastYValueForColumn[@(currentColumn)] doubleValue];
            if (originY == 0.0) {
                originY = MasonryCollectionViewSpaceWidth;
            }

            CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];

            itemAttributes.frame = CGRectMake(originX, originY, itemWidth, itemHeight);
            _layoutInfo[indexPath] = itemAttributes;
            _lastYValueForColumn[@(currentColumn)] = @(originY + itemHeight + MasonryCollectionViewSpaceWidth);

        }

    }
}

- (NSUInteger)getMiniHeightColumn {
    NSInteger miniHeightColumn = 0;
    CGFloat miniHeight = [_lastYValueForColumn[@(miniHeightColumn)] doubleValue];
    for (NSUInteger column = 0; column < _numberOfColumns; column++) {
        CGFloat height = [_lastYValueForColumn[@(column)] doubleValue];
        if (height < miniHeight) {
            miniHeight = height;
            miniHeightColumn = column;
        }
    }
    return miniHeightColumn;
}

@end