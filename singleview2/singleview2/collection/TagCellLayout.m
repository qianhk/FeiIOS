//
// Created by kai on 17/3/8.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "TagCellLayout.h"

@interface TagCellLayout () {
    NSMutableDictionary *_layoutInfo;
    CGFloat _maxHeight;
}

@end

@implementation TagCellLayout {

}

- (void)prepareLayout {
    NSLog(@"lookLayout prepareLayout");
    _layoutInfo = [NSMutableDictionary dictionary];
    _maxHeight = 0.f;
    [self getLayoutInfoInOrder];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@"lookLayout layoutAttributesForElementsInRect");
    NSMutableArray *allAttributes = [NSMutableArray array];
    [_layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }];
    return allAttributes;
}

- (CGSize)collectionViewContentSize {
    NSLog(@"lookLayout collectionViewContentSize maxHeight=%.2f", _maxHeight);
    return CGSizeMake(self.collectionView.frame.size.width, _maxHeight);
}

- (void)getLayoutInfoInOrder {
    CGFloat validRowWidth = self.collectionView.bounds.size.width;

    NSIndexPath *indexPath;
    NSInteger numberOfSection = [self.collectionView numberOfSections];

    CGFloat originY = 0.f;
    for (NSInteger section = 0; section < numberOfSection; section++) {
        NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:section];

        CGFloat originX = 0.f;

        CGFloat lastItemHeight = 0.f;
        for (NSInteger item = 0; item < numberOfItem; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];

            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

            CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            lastItemHeight = itemSize.height;
            if (item == 0) {
                _maxHeight += lastItemHeight;
            }

            if (originX + itemSize.width > validRowWidth) {
                originX = 0.f;
                originY += lastItemHeight + _lineSpacing;
                _maxHeight += _lineSpacing + lastItemHeight;
            }
            itemAttributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
            _layoutInfo[indexPath] = itemAttributes;
            originX += itemSize.width + _itemSpacing;

        }
        originY += lastItemHeight + _lineSpacing;
    }
}

@end