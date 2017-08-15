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

@interface PostTableViewController ()

@property (nonatomic, strong) NSMutableArray<Post *> *postList;

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

//    self.tableView.delegate = self; //基类是uitableview则无需设置delete、datasource
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

    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *simpleTableIdentifier = @"SimpleTableIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
//    cell.textLabel.text = mDataArray[indexPath.row];
//    return cell;

    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.postList[indexPath.row];
    [cell configWithModel:post];
    return cell;
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


@end
