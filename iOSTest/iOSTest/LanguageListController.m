//
// Created by kai on 17/3/2.
// Copyright (c) 2017 Njnu. All rights reserved.
//

#import "LanguageListController.h"
#import "DetailViewController.h"

@interface LanguageListController () {


}

@end

@implementation LanguageListController {
    NSArray *languageList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    languageList = @[@"English", @"中文", @"Frecnh", @"Spanish"];

    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320, languageList.count * 44);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return languageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __kindof UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = languageList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.detailViewController.language = languageList[indexPath.row];
}

@end
