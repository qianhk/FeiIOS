//
// Created by kai on 17/3/8.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UICollectionViewDelegateTagCellLayout <UICollectionViewDelegate>
@optional

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface TagCellLayout : UICollectionViewLayout

@property (nonatomic) CGFloat lineSpacing;
@property (nonatomic) CGFloat itemSpacing;
@property (nonatomic, weak) id<UICollectionViewDelegateTagCellLayout> delegate;

@end