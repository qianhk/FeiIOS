//
// Created by 钱红凯 on 17/2/22.
// Copyright (c) 2017 TTPod. All rights reserved.
//

#import "SearchResultController.h"

static NSString *SectionsTableSearchIdentifier = @"SearchIdentifier";

static const NSUInteger LongNameSize = 6;
static const NSUInteger ShortNameIndex = 1;
static const NSUInteger LongNameIndex = 2;

@implementation SearchResultController {
    NSDictionary<NSString *, NSArray *> *mNames;
    NSArray<NSString *> *mKeys;

    NSMutableArray *mFilterArray;
}

- (void)dealloc {
    NSLog(@"lookEvent SearchResultController dealloc");
}

- (instancetype)initWithNames:(NSDictionary *)names keys:(NSArray *)keys {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        mNames = names;
        mKeys = keys;
        mFilterArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SectionsTableSearchIdentifier];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mFilterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __kindof UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableSearchIdentifier];
    cell.textLabel.text = mFilterArray[indexPath.row];
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    UISearchBar *bar = searchController.searchBar;
    NSString *searchText = bar.text;
    NSInteger buttonIndex = bar.selectedScopeButtonIndex;
    NSLog(@"updateSearchResultsForSearchController %@ %d", searchText, buttonIndex);
    [mFilterArray removeAllObjects];
    if (searchText.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *name, NSDictionary *bindings) {
            NSUInteger nameLength = name.length;
            if ((buttonIndex == ShortNameIndex && nameLength >= LongNameSize) || (buttonIndex == LongNameIndex && nameLength < LongNameSize)) {
                return NO;
            }
            NSRange range = [name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
        }];
        for (NSString *key in mKeys) {
            [mFilterArray addObjectsFromArray:[mNames[key] filteredArrayUsingPredicate:predicate]];
        }
    }
    [self.tableView reloadData];
}

@end