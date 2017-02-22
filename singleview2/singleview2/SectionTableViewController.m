//
// Created by 钱红凯 on 17/2/22.
// Copyright (c) 2017 TTPod. All rights reserved.
//

#import "SectionTableViewController.h"

@implementation SectionTableViewController {
    NSDictionary<NSString *, NSArray *> *mNames;
    NSArray<NSString *> *mKeys;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    NSString *plistFile = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    NSLog(@"sortednames.plist path=%@", plistFile);
    mNames = [NSDictionary dictionaryWithContentsOfFile:plistFile];
    mKeys = [mNames.allKeys sortedArrayUsingSelector:@selector(compare:)];
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
    NSString * text = mNames[mKeys[indexPath.section]][indexPath.row];
    cell.textLabel.text = text;
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return mKeys;
}


@end