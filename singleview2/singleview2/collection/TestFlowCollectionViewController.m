//
//  TestFlowCollectionViewController.m
//  singleview2
//
//  Created by 钱红凯 on 2017/12/26.
//  Copyright © 2017年 Njnu. All rights reserved.
//

#import "TestFlowCollectionViewController.h"
#import "ContentCell.h"
#import "UICollectionViewLeftFlowLayout.h"

@interface TestFlowCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation TestFlowCollectionViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewLeftFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 20;
    flowLayout.minimumInteritemSpacing = 10;
    //        flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    flowLayout.collectionView.showsVerticalScrollIndicator = YES;
//    flowLayout.collectionView.alwaysBounceVertical = YES;
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"FlowCollectionView";
    self.collectionView.backgroundColor = [UIColor whiteColor];

    self.sections = @[
            @{@"header": @"First Section", @"content": @"A_第一行就超长都放不下第第第第第第哈后来好啊那个1 first content ha ha empty longlong1long2long3long4 row, long row again again2 "}
            , @{@"header": @"second Section", @"content": @"B_second content"}
            , @{@"header": @"Section 3", @"content": @"C_content 3"}
            , @{@"header": @"Section 4", @"content": @"D_新section 自己单独一行都放不下第第第第第第哈后来好啊那个4 try it, try2 again 第几行？ 6 7 8 9 a b c dd ee ff"}
            , @{@"header": @"Section 5", @"content": @"E_content 第6 word"}
            , @{@"header": @"Section 666666", @"content": @"F_content 666666 origin world"}
            , @{@"header": @"Section 666666", @"content": @"G_content 666666 origin world"}
            , @{@"header": @"Section 666666", @"content": @"H_content 666666 origin world"}
            , @{@"header": @"Section 666666", @"content": @"I_content 666666 origin world"}
            , @{@"header": @"Section 666666", @"content": @"J_content 666666 origin world"}
            , @{@"header": @"Section 666666", @"content": @"K_content 666666 origin world"}
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

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0.f;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self worldsInSection:indexPath.section];
    CGSize result = [ContentCell sizeForContentSize:words[indexPath.row] forMaxWidth:100000];
    return result;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self worldsInSection:indexPath.section];
    NSString *str = words[indexPath.row];
    NSLog(@"lookLayout didSelectItemAtIndexPath , section=%d row=%d text=%@", indexPath.section, indexPath.row, str);
}

- (void)collectionView:(UICollectionView *)collectionView preparedLayout:(CGSize)size {
    NSLog(@"lookLayout preparedLayout size=%@", NSStringFromCGSize(size));
}

- (void)dealloc {
    NSLog(@"dealloc vc=%@", NSStringFromClass(self.class)); //output  dealloc vc=TestGetClassInfoViewController
}
@end
