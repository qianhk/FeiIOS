//
// Created by kai on 2017/12/26.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "UICollectionViewLeftFlowLayout.h"

@interface UICollectionViewLeftFlowLayout ()


@end

@implementation UICollectionViewLeftFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }

    return self;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *answer = [super layoutAttributesForElementsInRect:rect];
    NSLog(@"lookFlow cvContentSize=%@ count=%d", NSStringFromCGSize(self.collectionViewContentSize), answer.count);
    UIEdgeInsets sectionInset = self.sectionInset;
    NSInteger lastSection = -1;
    CGFloat minItemSpacing = self.minimumInteritemSpacing;
    for (NSUInteger idx = 0; idx < [answer count]; ++idx) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[idx];
        NSIndexPath *indexPath = currentLayoutAttributes.indexPath;
        NSLog(@"lookFlow idx=%d section=%d pos=%@", idx, indexPath.section, NSStringFromCGPoint(currentLayoutAttributes.frame.origin));

        CGRect curFrame = currentLayoutAttributes.frame;
        if (lastSection != indexPath.section) {
            //换section了
            lastSection = indexPath.section;
            curFrame.origin.x = sectionInset.left;
        } else {
            UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[idx - 1];
            CGFloat prevMaxX = CGRectGetMaxX(prevLayoutAttributes.frame);
            if (CGRectGetMinX(curFrame) < prevMaxX + minItemSpacing - 1.f) {
                //换行了
                curFrame.origin.x = sectionInset.left;
            } else {
//                if (prevMaxX + self.maximumInteritemSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
                curFrame.origin.x = prevMaxX + self.maximumInteritemSpacing;
//                }
            }
        }
        currentLayoutAttributes.frame = curFrame;
    }
    return answer;
}

- (NSArray *)layoutAttributesForElementsInRect2:(CGRect)rect {
    // 获取系统帮我们计算好的Attributes
    NSArray *answer = [super layoutAttributesForElementsInRect:rect];

    // 遍历结果
    for (int i = 1; i < [answer count]; ++i) {

        // 获取cell的Attribute，根据上一个cell获取最大的x，定义为origin
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];

        //此处根据个人需求，我的需求里面有head cell两类，我只需要调整cell，所以head直接过滤
        if ([currentLayoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            continue;
        }

        NSInteger preX = CGRectGetMaxX(prevLayoutAttributes.frame);
        NSInteger preY = CGRectGetMaxY(prevLayoutAttributes.frame);
        NSInteger curY = CGRectGetMaxY(currentLayoutAttributes.frame);

        // 设置cell最大间距
        NSInteger maximumSpacing = 0;

        // 如果当前cell和precell在同一行
        if (preY == curY) {
            //满足则给当前cell的frame属性赋值
            //不满足的cell会根据系统布局换行
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = preX + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return answer;
}


@end
