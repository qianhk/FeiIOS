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
#import "SVPullToRefresh.h"
#import "OperateSuccessView.h"

#import <ReactiveObjC/RACEXTScope.h>

@interface PostTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<Post *> *postList;
@property (nonatomic, strong) NSMutableArray<NSString *> *stringList;

@property (nonatomic, strong) OperateSuccessView *successView;

@property (nonatomic, strong) NSMutableDictionary *cellHeightDictionary;
@end;

BOOL useEstimatedRowHeight = YES;

@implementation PostTableViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:<#(SEL)aSelector#> object:<#(nullable id)anArgument#>];

//    [self removeObserver:self forKeyPath:@"postList"];

    NSLog(@"PostTableViewController dealloc");
}

#pragma mark - View lifecycle

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"PostTableViewController viewWillDisappear");
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify removeObserver:self];
    self.successView = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify addObserver:self
               selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:nil];

    [notify addObserver:self
               selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
}


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
        if (indexPath.section == 2) {
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

    NSLog(@"PostTableViewController viewDidLoad");

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];

    [self.tableView registerNib:[UINib nibWithNibName:@"PostCell" bundle:nil] forCellReuseIdentifier:@"PostCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextTableViewCell"];
    [self.tableView registerClass:CodeTextTableViewCell.class forCellReuseIdentifier:@"CodeTextTableViewCell"];

    self.tableView.delegate = self; //基类是uitableview则无需设置delete、datasource
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor magentaColor];

    if (useEstimatedRowHeight) {
        self.tableView.estimatedRowHeight = 10;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }
    self.tableView.separatorInset = UIEdgeInsetsZero;

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.view.bounds = [self getContentViewFrame];

//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

//    [self addObserver:self forKeyPath:@"postList" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial context:nil];

//    id abc = nil;
//    [abc addObserver:self forKeyPath:@"postList" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial context:nil];

//    [self addObserver:nil forKeyPath:@"postList" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial context:nil];

    self.cellHeightDictionary = @{}.mutableCopy;

    self.postList = [NSMutableArray arrayWithArray:[Post makeData]];


    self.stringList = [NSMutableArray arrayWithCapacity:16];
    for (int idx = 0; idx < 16; ++idx) {
        [self.stringList addObject:[NSString stringWithFormat:@"kai string %d", idx]];
    }

    [self.tableView reloadData];

    [self performSelector:@selector(identifyFirstFullDisplayCell) withObject:nil afterDelay:0.4f];

//    [self performSelector:@selector(delayDoSth) withObject:nil afterDelay:2.f];


    @weakify(self)
    [self.tableView addPullToRefreshWithActionHandler:^{
    }];

    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf insertRowAtBottom];
    }];

}

- (void)insertRowAtTop {
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
//        [self.tableView beginUpdates];
//        [self.dataSource insertObject:[NSDate date] atIndex:0];
//        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
//        [self.tableView endUpdates];

        [self.tableView.pullToRefreshView stopAnimating];
    });
}


- (void)insertRowAtBottom {
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
//        [self.tableView beginUpdates];
//        [self.dataSource addObject:[self.dataSource.lastObject dateByAddingTimeInterval:-90]];
//        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
//        [self.tableView endUpdates];

        [self.tableView.infiniteScrollingView stopAnimating];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    //'NSInternalInconsistencyException', reason: '<UserDefaultsViewController: 0x100403580>: An -observeValueForKeyPath:ofObject:change:context: message was received but not handled.


    NSLog(@"PostTableViewController observeValueForKeyPath key=%@ new=%@ old=%@", keyPath, [change valueForKey:NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey]);
    if ([keyPath isEqualToString:@"name"]) {
    }
}

- (void)delayDoSth {
    [self keyboardWillShow:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {

    CGFloat toY = self.tableView.contentOffset.y + 100.f;
    CGFloat duration = 3; //[[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    @weakify(self)
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         @strongify(self)
                         self.tableView.contentOffset = CGPointMake(0, toY);
                     } completion:^(BOOL finished) {
            }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.stringList.count;
    } else if (section == 1) {
        return 1;
    }
    return self.postList.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    _cellHeightDictionary[indexPath] = @(cell.frame.size.height);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = _cellHeightDictionary[indexPath];
    if (height) {
        return height.floatValue;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (useEstimatedRowHeight) {
        if (indexPath.section == 0 && indexPath.row % 2 == 0) {
            return [CodeTextTableViewCell heightOfCell];
        } else if (indexPath.section == 1) {
            return 44;
        }
        return UITableViewAutomaticDimension;
    } else {
        if (indexPath.section <= 1) {
            return 44;
        } else {
            return 100;
        }
    }
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
    } else if (indexPath.section == 1) {
        UITableViewCell *reloadDataCell = [tableView dequeueReusableCellWithIdentifier:@"ReloadDataCell"];
        if (!reloadDataCell) {
            reloadDataCell = [UITableViewCell new];
        }
        reloadDataCell.textLabel.text = @"点我倒序加载下面的内容";
        return reloadDataCell;
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


//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return nil;
////    } else if (indexPath.row == 2) {
////        return [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
//    } else {
//        return indexPath;
//    }
//}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"moveRowAtIndexPath sourceRow=%ld destRow=%ld", (long) sourceIndexPath.row, (long) destinationIndexPath.row);
    Post *post = self.postList[sourceIndexPath.row];
    [self.postList removeObjectAtIndex:sourceIndexPath.row];
    [self.postList insertObject:post atIndex:destinationIndexPath.row];
}

- (void)testReloadData {
    NSArray *tmpArray = [[self.postList reverseObjectEnumerator] allObjects];
    self.postList = [NSMutableArray arrayWithArray:tmpArray];

    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section <= 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:indexPath.row % 2 == 0];
    }

    if (indexPath.section == 1) {
        [self performSelector:@selector(testReloadData) withObject:nil afterDelay:.5f];
        return;
    }

    //NSLog(@"didSelectRowAtIndexPath row=%ld %.2f", (long) indexPath.row, UITableViewAutomaticDimension);
    self.successView = [OperateSuccessView show:self.view.window];
    self.successView.actionTapped = ^(NSInteger state) {
        self.successView.subtitleLabel.text = [NSString stringWithFormat:@"此乃子View啊，哈哈 %d", state];
        [self.successView.actionButton setTitle:[NSString stringWithFormat:@"按钮%d", state] forState:UIControlStateNormal];
    };
    self.successView.onViewDismissed = ^() {
        self.successView = nil;
    };
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
