//
// Created by kai on 2017/5/24.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "StickyCollectionViewController.h"
#import "Person.h"
#import "StickyPersonCell.h"

@interface StickyCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) NSArray<Person *> *personList;

@end

@implementation StickyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sticky";
    self.view.backgroundColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat minInteritemSpacing = layout.minimumInteritemSpacing;
    CGFloat minLineSpacing = layout.minimumLineSpacing;
    NSLog(@"minInteritemSpacing=%.2f minLineSpacing=%.2f", minInteritemSpacing, minLineSpacing);
    layout.minimumInteritemSpacing = 0.f;
    layout.minimumLineSpacing = 0.f;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(118, 17 + 170 + 6 + 20);
//    layout.sectionInset = UIEdgeInsetsMake(-8, 12, 0, 0);

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 0);
    [self.view addSubview:_collectionView];

    self.collectionView.collectionViewLayout = layout;

    [self.collectionView registerClass:StickyPersonCell.class forCellWithReuseIdentifier:NSStringFromClass(StickyPersonCell.class)];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    [self prepareData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.personList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StickyPersonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(StickyPersonCell.class) forIndexPath:indexPath];
    [cell updateData:self.personList[indexPath.row]];
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSize();
//}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsZero;
//}


- (void)prepareData {
    NSMutableArray *personList = [NSMutableArray array];
    [personList addObject:[Person constructYear:@"2000" name:@"第一个人" avatarId:@"hotel"]];
    [personList addObject:[Person constructYear:@"2001" name:@"第二个人" avatarId:@"car1"]];
    [personList addObject:[Person constructYear:@"2002" name:@"第三个人" avatarId:@"car2"]];
    [personList addObject:[Person constructYear:@"2002" name:@"第四个人" avatarId:@"scenic"]];
    [personList addObject:[Person constructYear:@"2003" name:@"第五个人" avatarId:@"hotel"]];
    [personList addObject:[Person constructYear:@"2003" name:@"第六个人" avatarId:@"car1"]];
    [personList addObject:[Person constructYear:@"2003" name:@"第七个人" avatarId:@"car2"]];
    [personList addObject:[Person constructYear:@"2004" name:@"第八个人" avatarId:@"scenic"]];
    [personList addObject:[Person constructYear:@"2005" name:@"第九个人" avatarId:@"hotel"]];
    [personList addObject:[Person constructYear:@"2006" name:@"第十个人" avatarId:@"car1"]];
    [personList addObject:[Person constructYear:@"2006" name:@"第11个人" avatarId:@"car2"]];
    [personList addObject:[Person constructYear:@"2007" name:@"第12个人" avatarId:@"scenic"]];
    [personList addObject:[Person constructYear:@"2007" name:@"第13个人" avatarId:@"car1"]];

    self.personList = [NSArray arrayWithArray:personList];

    [self.collectionView reloadData];

//    [self.collectionView scrollsToTop];

}

@end