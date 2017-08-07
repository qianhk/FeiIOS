//
// Created by kai on 17/2/22.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "SectionTableViewController.h"
#import "SearchResultController.h"

@interface SectionTableViewController () <UISearchBarDelegate> {

}

@property(strong, nonatomic) UISearchController *searchController;

@end

@implementation SectionTableViewController {
    NSDictionary<NSString *, NSArray *> *mNames;
    NSArray<NSString *> *mKeys;
}

- (void)dealloc {
    NSLog(@"lookEvent SectionTableViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    NSString *plistFile = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    NSLog(@"sortednames.plist path=%@", plistFile);
    mNames = [NSDictionary dictionaryWithContentsOfFile:plistFile];
    mKeys = [mNames.allKeys sortedArrayUsingSelector:@selector(compare:)];

    SearchResultController *resultController = [[SearchResultController alloc] initWithNames:mNames keys:mKeys];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultController];

    UISearchBar *searchBar = self.searchController.searchBar;
    searchBar.scopeButtonTitles = @[@"All", @"Short", @"Long"];
    searchBar.placeholder = @"Enter a search item";
    searchBar.delegate = self;
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    self.searchController.searchResultsUpdater = resultController;
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self.searchController.searchResultsUpdater performSelector:@selector(updateSearchResultsForSearchController:) withObject:self.searchController];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return mKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mNames[mKeys[section]].count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return mKeys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSString *text = mNames[mKeys[indexPath.section]][indexPath.row];
    cell.textLabel.text = text;
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return mKeys;
}


@end
