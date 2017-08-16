//
//  ViewController.m
//  singleview2
//
//  Created by hongkai.qian on 12-2-27.
//  Copyright (c) 2012年 Njnu. All rights reserved.
//

#import "PostTableViewController.h"
#import "PostCell.h"
#import "PostData.h"
#import "TextTableViewCell.h"

@interface PostTableViewController ()

@property (nonatomic, strong) NSMutableArray<Post *> *postList;
@property (nonatomic, strong) NSMutableArray<NSString *> *stringList;

@end;

@implementation PostTableViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
}

#pragma mark - View lifecycle



- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"PostCell" bundle:nil] forCellReuseIdentifier:@"PostCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextTableViewCell"];

    self.tableView.delegate = self; //基类是uitableview则无需设置delete、datasource
//    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor magentaColor];

//    self.tableView.rowHeight = 80;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.view.bounds = [self getContentViewFrame];

//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    self.postList = [NSMutableArray arrayWithArray:[Post makeData]];

    self.stringList = [NSMutableArray arrayWithCapacity:16];
    for (int idx = 0; idx < 16; ++idx) {
        [self.stringList addObject:[NSString stringWithFormat:@"kai string %d", idx]];
    }

    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.stringList.count;
    }
    return self.postList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextTableViewCell"];
        cell.textLabel.text = self.stringList[indexPath.row];
        return cell;
    } else {
        PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
        Post *post = self.postList[indexPath.row];
        [cell configWithModel:post];
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableView commitEditingStyle %d row=%d", editingStyle, indexPath.row);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.postList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return nil;
//    } else if (indexPath.row == 2) {
//        return [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
    } else {
        return indexPath;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"moveRowAtIndexPath sourceRow=%ld destRow=%ld", (long) sourceIndexPath.row, (long) destinationIndexPath.row);
    Post *post = self.postList[sourceIndexPath.row];
    [self.postList removeObjectAtIndex:sourceIndexPath.row];
    [self.postList insertObject:post atIndex:destinationIndexPath.row];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath row=%ld %.2f", (long) indexPath.row, UITableViewAutomaticDimension);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"lookScroll scrollViewDidScroll"); //只要手在滑或者惯性自动滑都触发，刚进入页面、退出页面也会触发大约2次
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //如果decelerate为NO，则真的停止了，如果为true，则会惯性滑动，得等scrollViewDidEndDecelerating才真的停止
//    NSLog(@"lookScroll scrollViewDidEndDragging willDecelerate=%@", decelerate ? @"YES" : @"NO");
    if (!decelerate) {
        [self scrollViewDidEndScroll:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"lookScroll scrollViewDidEndDecelerating"); //惯性滑动停止
    [self scrollViewDidEndScroll:scrollView];
}

- (void)scrollViewDidEndScroll:(UIScrollView *)scrollView {
    NSLog(@"lookScroll scrollViewDidEndScroll"); //自己定义的，无论惯性滑动还是慢慢滑动的停止
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"lookScroll scrollViewDidEndScrollingAnimation");
}


@end
