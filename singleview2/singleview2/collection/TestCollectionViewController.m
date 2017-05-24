//
// Created by kai on 17/2/27.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "ContentCell.h"
#import "HeaderCell.h"
#import "TagCellLayout.h"

@interface TestCollectionViewController () <UICollectionViewDelegateTagCellLayout>

@end

@implementation TestCollectionViewController {

}

- (instancetype)init {
    TagCellLayout *flowLayout = [[TagCellLayout alloc] init];
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        flowLayout.delegate = self;
        flowLayout.itemSpacing = 10;
        flowLayout.lineSpacing = 10;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"CollectionView";
    self.collectionView.backgroundColor = [UIColor whiteColor];

    self.sections = @[
            @{@"header": @"First Section", @"content": @"第一行就超长都放不下第第第第第第哈后来好啊那个1 first content ha ha empty longlong1long2long3long4 row, long row again"}
            , @{@"header": @"second Section", @"content": @"second content"}
            , @{@"header": @"Section 3", @"content": @"content 3"}
            , @{@"header": @"Section 4", @"content": @"新section 自己单独一行都放不下第第第第第第哈后来好啊那个4 try it, try2 again 第几行？ 6 7 8 9 a b c dd ee ff"}
            , @{@"header": @"Section 5", @"content": @"content 第6 word"}
            , @{@"header": @"Section 666666", @"content": @"content 666666 origin world"}
    ];

    [self.collectionView registerClass:[ContentCell class] forCellWithReuseIdentifier:@"CONTENT"];
//    [self.collectionView registerClass:[HeaderCell class] forCellWithReuseIdentifier:@"HEADER"];
    [self.collectionView registerClass:[HeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];

}

- (NSArray *)worldsInSection:(NSInteger)section {
    NSString *content = self.sections[section][@"content"];
    NSCharacterSet *space = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *words = [content componentsSeparatedByCharactersInSet:space];
    return words;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self worldsInSection:section] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self worldsInSection:indexPath.section];

    ContentCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CONTENT" forIndexPath:indexPath];
    cell.maxWidth = collectionView.bounds.size.width;
    cell.text = words[indexPath.row];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self worldsInSection:indexPath.section];
    CGSize result = [ContentCell sizeForContentSize:words[indexPath.row] forMaxWidth:100000];
    return result;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        __kindof HeaderCell *cell = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        cell.maxWidth = collectionView.bounds.size.width;
        cell.text = self.sections[indexPath.section][@"header"];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self worldsInSection:indexPath.section];
    NSString *str = words[indexPath.row];
    NSLog(@"lookLayout didSelectItemAtIndexPath , section=%d row=%d text=%@", indexPath.section, indexPath.row, str);
}

- (void)collectionView:(UICollectionView *)collectionView preparedLayout:(CGSize)size {
    NSLog(@"lookLayout preparedLayout size=%@", NSStringFromCGSize(size));
}

@end
