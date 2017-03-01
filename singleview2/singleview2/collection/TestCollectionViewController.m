//
// Created by kai on 17/2/27.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "ContentCell.h"

@interface TestCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation TestCollectionViewController {

}

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {

    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor whiteColor];

    self.sections = @[
            @{@"header": @"First Section", @"content": @"first content ha ha empty "},
            @{@"header": @"second Section", @"content": @"second content"},
            @{@"header": @"Section 3", @"content": @"content 3"},
            @{@"header": @"Section 4", @"content": @"content 第第第第第第第第第第第第4 try"},
            @{@"header": @"Section 5", @"content": @"content 第6 word"},
            @{@"header": @"Section 666666", @"content": @"content 666666 origin world"},
    ];

    [self.collectionView registerClass:[ContentCell class] forCellWithReuseIdentifier:@"CONTENT"];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self worldsInSection:indexPath.section];
    CGSize result = [ContentCell sizeForContentSize:words[indexPath.row] forMaxWidth:collectionView.bounds.size.width];
    return result;
}


@end