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
#import "CodeTextTableViewCell.h"

@interface PostTableViewController ()

@property (nonatomic, strong) NSMutableArray<Post *> *postList;
@property (nonatomic, strong) NSMutableArray<NSString *> *stringList;

@end;

@implementation PostTableViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:<#(SEL)aSelector#> object:<#(nullable id)anArgument#>];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - View lifecycle


- (void)findFullDisplayCell:(NSIndexPath *)indexPath {
    PostCell *postCell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGRect oldFrame = postCell.avatarImageView.frame;
//    CGRect newFrame = [postCell.avatarImageView convertRect:oldFrame toView:self.view];
//    CGRect newFrame = [postCell.avatarImageView convertRect:oldFrame toView:[[UIApplication sharedApplication].delegate window]];
    CGRect newFrame = [postCell.avatarImageView convertRect:oldFrame toView:nil];
    NSLog(@"lookVisibleRow oldFrame=%@ newFrame=%@", NSStringFromCGRect(oldFrame), NSStringFromCGRect(newFrame));
}

/*
     offset.y + height  >= cell.y + cell.height 说明底都显示出来了
    offset.y + 64 <= cell.y 说明顶部还没冒出去
 */
- (void)identifyFirstFullDisplayCell {
    NSArray<NSIndexPath *> *array = self.tableView.indexPathsForVisibleRows;
    CGPoint contentOffset = self.tableView.contentOffset;
    CGFloat tableHeight = self.tableView.frame.size.height;
    NSLog(@"lookVisibleRow tableView offset.y=%.2f height=%.2f VisibleRowCount=%d", contentOffset.y, tableHeight, array.count);


    [array enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        if (indexPath.section == 1) {
            CGRect cellRect = [self.tableView rectForRowAtIndexPath:indexPath];
            CGFloat cellHeight = cellRect.size.height;
            CGFloat cellY = cellRect.origin.y;
            //        NSLog(@"lookVisibleRow indexPath=%d_%02d rect(y=%.2f ht=%.2f)", indexPath.section, indexPath.row, rect.origin.y, rect.size.height);
            if (contentOffset.y + 64 <= cellY && contentOffset.y + tableHeight >= cellY + cellHeight) {
                NSLog(@"lookVisibleRow find first post full display cell: indexPath=%d_%02d", indexPath.section, indexPath.row);
                [self findFullDisplayCell:indexPath];
                *stop = YES;
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"PostCell" bundle:nil] forCellReuseIdentifier:@"PostCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextTableViewCell"];
    [self.tableView registerClass:CodeTextTableViewCell.class forCellReuseIdentifier:@"CodeTextTableViewCell"];

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

    [self performSelector:@selector(identifyFirstFullDisplayCell) withObject:nil afterDelay:0.4f];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row % 2 == 0) {
        return [CodeTextTableViewCell heightOfCell];
    }
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row % 2 == 0) {
            CodeTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CodeTextTableViewCell"];
            [cell configWithText:self.stringList[indexPath.row]];
            return cell;
        } else {
            TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextTableViewCell"];
            cell.textLabel.text = self.stringList[indexPath.row];
            return cell;
        }
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

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"moveRowAtIndexPath sourceRow=%ld destRow=%ld", (long) sourceIndexPath.row, (long) destinationIndexPath.row);
    Post *post = self.postList[sourceIndexPath.row];
    [self.postList removeObjectAtIndex:sourceIndexPath.row];
    [self.postList insertObject:post atIndex:destinationIndexPath.row];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:indexPath.row % 2 == 0];
    }
    
    //NSLog(@"didSelectRowAtIndexPath row=%ld %.2f", (long) indexPath.row, UITableViewAutomaticDimension);
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
    [self identifyFirstFullDisplayCell];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"lookScroll scrollViewDidEndScrollingAnimation");
}


@end
