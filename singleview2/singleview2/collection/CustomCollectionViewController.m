//
// Created by kai on 17/2/27.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "MasonryLayout.h"
#import "TestScanBackgroundLayer.h"

@interface CustomCollectionViewController () <UICollectionViewDelegateFlowLayout, MasonryLayoutDelegate>

@property(nonatomic, copy) NSArray<NSString *> *dataList;

@end

@implementation CustomCollectionViewController {

}

- (instancetype)init {
    MasonryLayout *layout = [[MasonryLayout alloc] initWithLayoutStyle:LayoutStyleInOrder];
    layout.delegate = self;
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.dataList = @[@"100*150", @"100*50", @"100*100", @"100*80", @"100*60", @"100*120", @"100*30", @"100*80", @"100*60"];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CONTENT"];

    NSLog(@"lookLayout viewDidLoad");
    
    TestScanBackgroundLayer *layer = [[TestScanBackgroundLayer alloc] initWithBounds:CGRectMake(0, 0, 300, 160) BackgroundColor:[UIColor yellowColor] focusRect:CGRectMake(50, 20, 200, 120)];
    self.collectionView.backgroundColor = [[UIColor alloc] initWithRed:1 green:0.5 blue:0 alpha:0.3];
    [self.collectionView.layer addSublayer:layer];
    layer.frame = CGRectMake(20, 400, layer.bounds.size.width, layer.bounds.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataList count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CONTENT" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}

#pragma mark -- MasonryLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MasonryLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *itemData = self.dataList[indexPath.row];
    NSRange range = [itemData rangeOfString:@"*"];
    NSString *widthStr = [itemData substringToIndex:range.location];
    NSString *heightStr = [itemData substringFromIndex:range.location + 1];
//    NSLog(@"lookSize width=%@ height=%@", widthStr, heightStr);
    return [heightStr floatValue];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *itemData = self.dataList[indexPath.row];
//    NSRange range = [itemData rangeOfString:@"*"];
//    NSString *widthStr = [itemData substringToIndex:range.location];
//    NSString *heightStr = [itemData substringFromIndex:range.location + 1];
////    NSLog(@"lookSize width=%@ height=%@", widthStr, heightStr);
//    return CGSizeMake([widthStr floatValue], [heightStr floatValue]);
//}


@end
