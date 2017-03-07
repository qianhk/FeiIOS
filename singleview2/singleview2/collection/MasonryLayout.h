//
// Created by kai on 17/3/7.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MasonryCollectionViewSpaceWidth     10

typedef NS_ENUM(NSInteger, LayoutStyle) {
    LayoutStyleInOrder      = 0,    //顺序排列cell
    LayoutStyleRegular      = 1,    //整齐排列cell
};

@protocol  MasonryLayoutDelegate;

@interface MasonryLayout : UICollectionViewLayout

@property (nonatomic, weak) id<MasonryLayoutDelegate> delegate;

- (instancetype)initWithLayoutStyle:(LayoutStyle)style;

@end

@protocol MasonryLayoutDelegate <NSObject>

//返回indexPath位置cell的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MasonryLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end