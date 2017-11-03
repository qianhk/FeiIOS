//
// Created by kai on 2017/11/3.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "CoordinatorLayoutTestTabViewController.h"

#import "CoordinatorLayout.h"

@interface CoordinatorLayoutTestTabViewController () <UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) CoordinatorLayout *coordinatorLayout;
@property (nonatomic, strong) NSMutableArray *listData;

@end

@implementation CoordinatorLayoutTestTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test Tab Layout";
    self.view.backgroundColor = [UIColor whiteColor];

    self.listData = [NSMutableArray new];
    for (int idx = 0; idx < 20; ++idx) {
        [self.listData addObject:[NSString stringWithFormat:@"Label idx=%d", idx]];
    }

    CGRect selfBounds = self.view.bounds;

    _coordinatorLayout = [CoordinatorLayout new];
    _coordinatorLayout.tag = 100;
    _coordinatorLayout.backgroundColor = [UIColor blueColor];
    _coordinatorLayout.frame = CGRectMake(0, 64, selfBounds.size.width, selfBounds.size.height - 64);
    [self.view addSubview:_coordinatorLayout];
    _coordinatorLayout.headerView = [self makeHeaderView];
    _coordinatorLayout.headerView.tag = 101;
    _coordinatorLayout.contentView = [self makeScrollContentView];
    _coordinatorLayout.contentView.tag = 102;
}

- (UIView *)makeHeaderView {

    CGFloat viewWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat viewHeight = 180.f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, viewWidth, viewHeight)];
    headerView.tag = 10;
    headerView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
    UILabel *label = [UILabel new];
    label.tag = 11;
    label.text = @"测试CoordinatorLayout";
    [headerView addSubview:label];
    [label sizeToFit];
    CGRect rect = headerView.frame;
    label.center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    return headerView;
}

- (UITableView *)makeSingleContentView {

    CGFloat viewWidth = CGRectGetWidth(self.coordinatorLayout.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.coordinatorLayout.bounds);
    UITableView *contentView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, viewWidth, viewHeight)];
    contentView.dataSource = self;
    contentView.backgroundColor = [UIColor orangeColor];
    return contentView;
}

- (UIView *)makeScrollContentView {

    CGFloat viewWidth = CGRectGetWidth(self.coordinatorLayout.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.coordinatorLayout.bounds);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.coordinatorLayout.bounds];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO;
    scrollView.delaysContentTouches = NO;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    scrollView.backgroundColor = [UIColor magentaColor];
    
    scrollView.contentSize = CGSizeMake(viewWidth * 2, viewHeight);

    UITableView *tab1View = [self makeSingleContentView];
    UITableView *tab2View = [self makeSingleContentView];

    [scrollView addSubview:tab1View];

    [scrollView addSubview:tab2View];
    CGRect rect = tab2View.frame;
    rect.origin.x = viewWidth;
    tab2View.frame = rect;

    return scrollView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __kindof UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Abc"];
    if (!cell) {
        cell = [UITableViewCell new];
    }
    cell.textLabel.text = self.listData[indexPath.row];
    return cell;
}
@end